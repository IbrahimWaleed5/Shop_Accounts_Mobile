import 'package:dio/dio.dart';

import '../data/local/app_database.dart';
import '../data/remote/reference_remote_data_source.dart';
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

  Future<ReferenceLoadResult>
      loadReferenceData() async {
    try {
      final remoteData =
          await remote.fetchReferenceData();

      await database.replaceReferenceData(
        remoteData,
      );

      return ReferenceLoadResult(
        data: remoteData,
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_isNetworkFailure(e)) {
        throw ReferenceException(
          _message(e),
        );
      }

      final local =
          await database.readReferenceData();

      if (local.currencies.isEmpty &&
          local.financialAccounts.isEmpty &&
          local.categories.isEmpty) {
        throw const ReferenceException(
          'لا توجد بيانات محلية بعد. اتصل بالإنترنت مرة واحدة لتحميل الإعدادات المحاسبية.',
        );
      }

      return ReferenceLoadResult(
        data: local,
        fromLocal: true,
      );
    }
  }

  Future<void> createFinancialAccount({
    required String name,
    required String type,
    required int currencyId,
    required int openingBalanceMinor,
    String? notes,
  }) async {
    try {
      await remote.createFinancialAccount(
        name: name,
        type: type,
        currencyId: currencyId,
        openingBalanceMinor:
            openingBalanceMinor,
        notes: notes,
      );
    } on DioException catch (e) {
      throw ReferenceException(
        _message(e),
      );
    }
  }

  Future<void> setFinancialAccountStatus({
    required int accountId,
    required bool isActive,
  }) async {
    try {
      await remote.setFinancialAccountStatus(
        accountId: accountId,
        isActive: isActive,
      );
    } on DioException catch (e) {
      throw ReferenceException(
        _message(e),
      );
    }
  }

  Future<void> createCategory({
    required String name,
    required String type,
    String? notes,
  }) async {
    try {
      await remote.createCategory(
        name: name,
        type: type,
        notes: notes,
      );
    } on DioException catch (e) {
      throw ReferenceException(
        _message(e),
      );
    }
  }

  Future<void> setCategoryStatus({
    required int categoryId,
    required bool isActive,
  }) async {
    try {
      await remote.setCategoryStatus(
        categoryId: categoryId,
        isActive: isActive,
      );
    } on DioException catch (e) {
      throw ReferenceException(
        _message(e),
      );
    }
  }

  bool _isNetworkFailure(
    DioException e,
  ) {
    return e.type ==
            DioExceptionType.connectionError ||
        e.type ==
            DioExceptionType.connectionTimeout ||
        e.type ==
            DioExceptionType.receiveTimeout ||
        e.type ==
            DioExceptionType.sendTimeout;
  }

  String _message(
    DioException exception,
  ) {
    final data =
        exception.response?.data;

    if (data is Map) {
      final errors = data['errors'];

      if (errors is Map &&
          errors.isNotEmpty) {
        final first =
            errors.values.first;

        if (first is List &&
            first.isNotEmpty) {
          return first.first.toString();
        }
      }

      final message =
          data['message'];

      if (message != null &&
          message.toString().isNotEmpty) {
        return message.toString();
      }
    }

    if (_isNetworkFailure(exception)) {
      return 'هذه العملية تحتاج إلى اتصال بالإنترنت.';
    }

    return 'تعذر تنفيذ العملية.';
  }
}

class ReferenceException
    implements Exception {
  final String message;

  const ReferenceException(
    this.message,
  );

  @override
  String toString() => message;
}
