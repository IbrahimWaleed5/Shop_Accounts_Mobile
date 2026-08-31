import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/simple_sale_remote_data_source.dart';
import '../models/accounting_transaction_model.dart';

class SimpleSaleRepository {
  final AppDatabase database;
  final SimpleSaleRemoteDataSource remote;

  SimpleSaleRepository({
    required this.database,
    required this.remote,
  });

  Future<AccountingTransactionModel>
      createSale(
    Map<String, dynamic> payload,
  ) async {
    final operationUuid =
        payload['uuid']
                ?.toString() ??
            UuidUtils.v4();

    final prepared =
        Map<String, dynamic>.from(
      payload,
    );

    prepared['uuid'] =
        operationUuid;

    prepared[
        'client_created_at'] ??=
        DateTime.now()
            .toIso8601String();

    await database.enqueueSyncOperation(
      operationUuid:
          operationUuid,
      operationType:
          'simple_sale',
      payload: prepared,
    );

    if (_hasTemporaryReference(prepared)) {
      final pending = await database.pendingTransactionByUuid(operationUuid);
      if (pending != null) return pending;
      throw const SimpleSaleException('تعذر حفظ البيع محليًا.');
    }

    try {
      final transaction =
          await remote.createSale(
        prepared,
      );

      await database.upsertTransactions(
        [transaction],
      );

      await database.removeSyncOperation(
        operationUuid,
      );

      return transaction;
    } on DioException catch (e) {
      if (_networkFailure(e)) {
        final pending =
            await database
                .pendingTransactionByUuid(
          operationUuid,
        );

        if (pending != null) {
          return pending;
        }

        throw const SimpleSaleException(
          'تعذر حفظ البيع محليًا.',
        );
      }

      if (_validationFailure(e)) {
        await database.removeSyncOperation(
          operationUuid,
        );

        throw SimpleSaleException(
          _message(e),
        );
      }

      await database.markSyncPending(
        operationUuid:
            operationUuid,
        error:
            _message(e),
      );

      final pending =
          await database
              .pendingTransactionByUuid(
        operationUuid,
      );

      if (pending != null) {
        return pending;
      }

      throw SimpleSaleException(
        _message(e),
      );
    }
  }

  bool _hasTemporaryReference(dynamic value) {
    if (value is Map) {
      for (final entry in value.entries) {
        final key = entry.key.toString();
        final current = entry.value;
        if (const {
          'party_id',
          'financial_account_id',
          'category_id',
        }.contains(key) && current is num && current.toInt() < 0) {
          return true;
        }
        if (_hasTemporaryReference(current)) return true;
      }
    } else if (value is List) {
      for (final item in value) {
        if (_hasTemporaryReference(item)) return true;
      }
    }
    return false;
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

  bool _validationFailure(
    DioException e,
  ) {
    return e.response?.statusCode ==
        422;
  }

  String _message(
    DioException e,
  ) {
    final data =
        e.response?.data;

    if (data is Map) {
      final errors =
          data['errors'];

      if (
        errors is Map &&
        errors.isNotEmpty
      ) {
        final first =
            errors.values.first;

        if (
          first is List &&
          first.isNotEmpty
        ) {
          return first.first
              .toString();
        }
      }

      final message =
          data['message'];

      if (
        message != null &&
        message
            .toString()
            .isNotEmpty
      ) {
        return message
            .toString();
      }
    }

    return 'تعذر ترحيل عملية البيع.';
  }
}

class SimpleSaleException
    implements Exception {
  final String message;

  const SimpleSaleException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
