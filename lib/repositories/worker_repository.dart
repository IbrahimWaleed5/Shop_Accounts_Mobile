import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/worker_remote_data_source.dart';
import '../models/currency_model.dart';
import '../models/worker_model.dart';
import '../models/worker_opening_balance_model.dart';

class WorkerLoadResult {
  final List<WorkerModel> workers;
  final bool fromLocal;
  const WorkerLoadResult({required this.workers, required this.fromLocal});
}

class WorkerRepository {
  final AppDatabase database;
  final WorkerRemoteDataSource remote;

  WorkerRepository({required this.database, required this.remote});

  Future<WorkerLoadResult> loadWorkers({String? search}) async {
    if (await database.hasPendingMasterDataChanges()) {
      return WorkerLoadResult(
        workers: await database.readWorkers(search: search),
        fromLocal: true,
      );
    }

    try {
      final workers = await remote.getWorkers(search: search);
      await database.upsertWorkers(workers);
      return WorkerLoadResult(
        workers: await database.readWorkers(search: search),
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) throw WorkerException(_message(e));
      return WorkerLoadResult(
        workers: await database.readWorkers(search: search),
        fromLocal: true,
      );
    }
  }

  Future<WorkerModel> createWorker({
    required String name,
    String? phone,
    String? jobTitle,
    required String wageType,
    int? wageCurrencyId,
    int? wageAmountMinor,
    DateTime? hireDate,
    String? notes,
    required List<WorkerOpeningBalanceModel> openingBalances,
  }) async {
    final tempId = await database.nextTemporaryWorkerId();
    final uuid = UuidUtils.v4();
    final now = DateTime.now();
    final refs = await database.readReferenceData();
    CurrencyModel? wageCurrency;
    for (final item in refs.currencies) {
      if (item.id == wageCurrencyId) {
        wageCurrency = item;
        break;
      }
    }

    final worker = WorkerModel(
      id: tempId,
      uuid: uuid,
      name: name.trim(),
      phone: _trim(phone),
      jobTitle: _trim(jobTitle),
      wageType: wageType,
      wageCurrencyId: wageCurrencyId,
      wageCurrencyCode: wageCurrency?.code,
      wageCurrencySymbol: wageCurrency?.symbol,
      wageCurrencyDecimalPlaces: wageCurrency?.decimalPlaces,
      wageAmountMinor: wageAmountMinor,
      hireDate: hireDate,
      notes: _trim(notes),
      isActive: true,
      version: 1,
      createdAt: now,
      updatedAt: now,
      openingBalances: openingBalances,
    );

    await database.upsertWorkers([worker]);
    await database.enqueueSyncOperation(
      operationUuid: uuid,
      operationType: 'worker_create',
      payload: {
        '_temp_id': tempId,
        'name': name.trim(),
        'phone': _trim(phone),
        'job_title': _trim(jobTitle),
        'wage_type': wageType,
        'wage_currency_id': wageCurrencyId,
        'wage_amount_minor': wageAmountMinor,
        'hire_date': hireDate?.toIso8601String(),
        'notes': _trim(notes),
        'opening_balances': _openingPayload(openingBalances),
      },
    );

    return worker;
  }

  Future<WorkerModel> updateWorker({
    required int workerId,
    required String name,
    String? phone,
    String? jobTitle,
    required String wageType,
    int? wageCurrencyId,
    int? wageAmountMinor,
    DateTime? hireDate,
    String? notes,
    required List<WorkerOpeningBalanceModel> openingBalances,
  }) async {
    final current = await _findLocal(workerId);
    final refs = await database.readReferenceData();
    CurrencyModel? wageCurrency;
    for (final item in refs.currencies) {
      if (item.id == wageCurrencyId) {
        wageCurrency = item;
        break;
      }
    }

    final updated = WorkerModel(
      id: current.id,
      uuid: current.uuid,
      name: name.trim(),
      phone: _trim(phone),
      jobTitle: _trim(jobTitle),
      wageType: wageType,
      wageCurrencyId: wageCurrencyId,
      wageCurrencyCode: wageCurrency?.code,
      wageCurrencySymbol: wageCurrency?.symbol,
      wageCurrencyDecimalPlaces: wageCurrency?.decimalPlaces,
      wageAmountMinor: wageAmountMinor,
      hireDate: hireDate,
      notes: _trim(notes),
      isActive: current.isActive,
      version: current.version + 1,
      createdAt: current.createdAt,
      updatedAt: DateTime.now(),
      openingBalances: openingBalances,
    );

    await database.upsertWorkers([updated]);
    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'worker_update',
      payload: {
        'worker_id': workerId,
        'name': name.trim(),
        'phone': _trim(phone),
        'job_title': _trim(jobTitle),
        'wage_type': wageType,
        'wage_currency_id': wageCurrencyId,
        'wage_amount_minor': wageAmountMinor,
        'hire_date': hireDate?.toIso8601String(),
        'notes': _trim(notes),
        'opening_balances': _openingPayload(openingBalances),
      },
    );
    return updated;
  }

  Future<WorkerModel> setStatus({
    required int workerId,
    required bool isActive,
  }) async {
    final current = await _findLocal(workerId);
    final updated = WorkerModel(
      id: current.id,
      uuid: current.uuid,
      name: current.name,
      phone: current.phone,
      jobTitle: current.jobTitle,
      wageType: current.wageType,
      wageCurrencyId: current.wageCurrencyId,
      wageCurrencyCode: current.wageCurrencyCode,
      wageCurrencySymbol: current.wageCurrencySymbol,
      wageCurrencyDecimalPlaces: current.wageCurrencyDecimalPlaces,
      wageAmountMinor: current.wageAmountMinor,
      hireDate: current.hireDate,
      notes: current.notes,
      isActive: isActive,
      version: current.version + 1,
      createdAt: current.createdAt,
      updatedAt: DateTime.now(),
      openingBalances: current.openingBalances,
    );

    await database.upsertWorkers([updated]);
    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'worker_status',
      payload: {'worker_id': workerId, 'is_active': isActive},
    );
    return updated;
  }

  Future<WorkerModel> _findLocal(int id) async {
    for (final item in await database.readWorkers()) {
      if (item.id == id) return item;
    }
    throw const WorkerException('تعذر العثور على العامل محليًا.');
  }

  List<Map<String, dynamic>> _openingPayload(
    List<WorkerOpeningBalanceModel> balances,
  ) => balances
      .map((item) => {
            'currency_id': item.currencyId,
            'balance_side': item.balanceSide,
            'amount_minor': item.amountMinor,
          })
      .toList();

  String? _trim(String? value) {
    final v = value?.trim();
    return v == null || v.isEmpty ? null : v;
  }

  bool _networkFailure(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout;

  String _message(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) return data['message'].toString();
    return 'تعذر تحميل العمال.';
  }
}

class WorkerException implements Exception {
  final String message;
  const WorkerException(this.message);
  @override
  String toString() => message;
}
