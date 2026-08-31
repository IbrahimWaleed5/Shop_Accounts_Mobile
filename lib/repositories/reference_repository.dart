import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/reference_remote_data_source.dart';
import '../models/category_model.dart';
import '../models/currency_model.dart';
import '../models/financial_account_model.dart';
import '../models/reference_data_model.dart';

class ReferenceLoadResult {
  final ReferenceDataModel data;
  final bool fromLocal;

  const ReferenceLoadResult({
    required this.data,
    required this.fromLocal,
  });
}

class ReferenceRepository {
  final AppDatabase database;
  final ReferenceRemoteDataSource remote;

  ReferenceRepository({
    required this.database,
    required this.remote,
  });

  Future<ReferenceLoadResult> loadReferenceData() async {
    if (await database.hasPendingMasterDataChanges()) {
      return ReferenceLoadResult(
        data: await database.readReferenceData(),
        fromLocal: true,
      );
    }

    try {
      final remoteData = await remote.fetchReferenceData();
      await database.replaceReferenceData(remoteData);
      return ReferenceLoadResult(
        data: await database.readReferenceData(),
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_isNetworkFailure(e)) {
        throw ReferenceException(_message(e));
      }

      final local = await database.readReferenceData();
      if (local.currencies.isEmpty) {
        throw const ReferenceException(
          'لا توجد إعدادات محلية بعد. يلزم اتصال أول مرة فقط لتحميل العملة الأساسية.',
        );
      }

      return ReferenceLoadResult(data: local, fromLocal: true);
    }
  }

  Future<void> createFinancialAccount({
    required String name,
    required String type,
    required int currencyId,
    required int openingBalanceMinor,
    String? notes,
  }) async {
    final refs = await database.readReferenceData();
    CurrencyModel? currency;
    for (final item in refs.currencies) {
      if (item.id == currencyId) {
        currency = item;
        break;
      }
    }
    if (currency == null) {
      throw const ReferenceException('تعذر العثور على العملة محليًا.');
    }

    final tempId = await database.nextTemporaryFinancialAccountId();
    final uuid = UuidUtils.v4();
    final account = FinancialAccountModel(
      id: tempId,
      uuid: uuid,
      name: name.trim(),
      type: type,
      currencyId: currencyId,
      currencyCode: currency.code,
      currencySymbol: currency.symbol,
      currencyDecimalPlaces: currency.decimalPlaces,
      openingBalanceMinor: openingBalanceMinor,
      notes: _trim(notes),
      isActive: true,
      updatedAt: DateTime.now(),
    );

    await database.upsertFinancialAccount(account);
    await database.enqueueSyncOperation(
      operationUuid: uuid,
      operationType: 'financial_account_create',
      payload: {
        '_temp_id': tempId,
        'name': name.trim(),
        'type': type,
        'currency_id': currencyId,
        'opening_balance_minor': openingBalanceMinor,
        'notes': _trim(notes),
      },
    );
  }

  Future<void> setFinancialAccountStatus({
    required int accountId,
    required bool isActive,
  }) async {
    final refs = await database.readReferenceData();
    FinancialAccountModel? current;
    for (final item in refs.financialAccounts) {
      if (item.id == accountId) {
        current = item;
        break;
      }
    }
    if (current == null) {
      throw const ReferenceException('تعذر العثور على الحساب المالي محليًا.');
    }

    await database.upsertFinancialAccount(
      FinancialAccountModel(
        id: current.id,
        uuid: current.uuid,
        name: current.name,
        type: current.type,
        currencyId: current.currencyId,
        currencyCode: current.currencyCode,
        currencySymbol: current.currencySymbol,
        currencyDecimalPlaces: current.currencyDecimalPlaces,
        openingBalanceMinor: current.openingBalanceMinor,
        notes: current.notes,
        isActive: isActive,
        updatedAt: DateTime.now(),
      ),
    );

    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'financial_account_status',
      payload: {
        'financial_account_id': accountId,
        'is_active': isActive,
      },
    );
  }

  Future<void> createCategory({
    required String name,
    required String type,
    String? notes,
  }) async {
    final tempId = await database.nextTemporaryCategoryId();
    final uuid = UuidUtils.v4();
    final category = CategoryModel(
      id: tempId,
      uuid: uuid,
      name: name.trim(),
      type: type,
      notes: _trim(notes),
      isActive: true,
      updatedAt: DateTime.now(),
    );

    await database.upsertCategory(category);
    await database.enqueueSyncOperation(
      operationUuid: uuid,
      operationType: 'category_create',
      payload: {
        '_temp_id': tempId,
        'name': name.trim(),
        'type': type,
        'notes': _trim(notes),
      },
    );
  }

  Future<void> setCategoryStatus({
    required int categoryId,
    required bool isActive,
  }) async {
    final refs = await database.readReferenceData();
    CategoryModel? current;
    for (final item in refs.categories) {
      if (item.id == categoryId) {
        current = item;
        break;
      }
    }
    if (current == null) {
      throw const ReferenceException('تعذر العثور على التصنيف محليًا.');
    }

    await database.upsertCategory(
      CategoryModel(
        id: current.id,
        uuid: current.uuid,
        name: current.name,
        type: current.type,
        notes: current.notes,
        isActive: isActive,
        updatedAt: DateTime.now(),
      ),
    );

    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'category_status',
      payload: {
        'category_id': categoryId,
        'is_active': isActive,
      },
    );
  }

  String? _trim(String? value) {
    final v = value?.trim();
    return v == null || v.isEmpty ? null : v;
  }

  bool _isNetworkFailure(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout;

  String _message(DioException exception) {
    final data = exception.response?.data;
    if (data is Map) {
      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) return first.first.toString();
      }
      final message = data['message'];
      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }
    }
    return 'تعذر تحميل الإعدادات.';
  }
}

class ReferenceException implements Exception {
  final String message;
  const ReferenceException(this.message);
  @override
  String toString() => message;
}
