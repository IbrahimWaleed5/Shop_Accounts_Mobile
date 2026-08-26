import 'package:dio/dio.dart';

import '../data/local/app_database.dart';
import '../data/remote/worker_remote_data_source.dart';
import '../models/worker_model.dart';
import '../models/worker_opening_balance_model.dart';

class WorkerLoadResult {
  final List<WorkerModel> workers;
  final bool fromLocal;

  const WorkerLoadResult({
    required this.workers,
    required this.fromLocal,
  });
}

class WorkerRepository {
  final AppDatabase database;
  final WorkerRemoteDataSource remote;

  WorkerRepository({
    required this.database,
    required this.remote,
  });

  Future<WorkerLoadResult> loadWorkers({
    String? search,
  }) async {
    try {
      final workers =
          await remote.getWorkers(
        search: search,
      );

      await database.upsertWorkers(
        workers,
      );

      return WorkerLoadResult(
        workers: workers,
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw WorkerException(
          _message(e),
        );
      }

      final local =
          await database.readWorkers(
        search: search,
      );

      return WorkerLoadResult(
        workers: local,
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
    required List<
            WorkerOpeningBalanceModel>
        openingBalances,
  }) async {
    try {
      final worker =
          await remote.createWorker(
        name: name,
        phone: phone,
        jobTitle: jobTitle,
        wageType: wageType,
        wageCurrencyId:
            wageCurrencyId,
        wageAmountMinor:
            wageAmountMinor,
        hireDate: hireDate,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      await database.upsertWorkers(
        [worker],
      );

      return worker;
    } on DioException catch (e) {
      throw WorkerException(
        _message(e),
      );
    }
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
    required List<
            WorkerOpeningBalanceModel>
        openingBalances,
  }) async {
    try {
      final worker =
          await remote.updateWorker(
        workerId: workerId,
        name: name,
        phone: phone,
        jobTitle: jobTitle,
        wageType: wageType,
        wageCurrencyId:
            wageCurrencyId,
        wageAmountMinor:
            wageAmountMinor,
        hireDate: hireDate,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      await database.upsertWorkers(
        [worker],
      );

      return worker;
    } on DioException catch (e) {
      throw WorkerException(
        _message(e),
      );
    }
  }

  Future<WorkerModel> setStatus({
    required int workerId,
    required bool isActive,
  }) async {
    try {
      final worker =
          await remote.setStatus(
        workerId: workerId,
        isActive: isActive,
      );

      await database.upsertWorkers(
        [worker],
      );

      return worker;
    } on DioException catch (e) {
      throw WorkerException(
        _message(e),
      );
    }
  }

  bool _networkFailure(
    DioException e,
  ) {
    return e.type ==
            DioExceptionType.connectionError ||
        e.type ==
            DioExceptionType.connectionTimeout ||
        e.type ==
            DioExceptionType.sendTimeout ||
        e.type ==
            DioExceptionType.receiveTimeout;
  }

  String _message(
    DioException e,
  ) {
    final data =
        e.response?.data;

    if (data is Map) {
      final errors =
          data['errors'];

      if (errors is Map &&
          errors.isNotEmpty) {
        final value =
            errors.values.first;

        if (value is List &&
            value.isNotEmpty) {
          return value.first
              .toString();
        }
      }

      final message =
          data['message'];

      if (message != null &&
          message
              .toString()
              .isNotEmpty) {
        return message
            .toString();
      }
    }

    if (_networkFailure(e)) {
      return 'هذه العملية تحتاج إلى اتصال بالإنترنت حاليًا.';
    }

    return 'تعذر تنفيذ العملية.';
  }
}

class WorkerException
    implements Exception {
  final String message;

  const WorkerException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
