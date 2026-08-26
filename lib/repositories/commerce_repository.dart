import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/commerce_remote_data_source.dart';
import '../models/accounting_transaction_model.dart';

class CommerceRepository {
  final AppDatabase database;
  final CommerceRemoteDataSource remote;

  CommerceRepository({
    required this.database,
    required this.remote,
  });

  Future<AccountingTransactionModel>
      createSale(
    Map<String, dynamic> payload,
  ) {
    return _create(
      payload: payload,
      operationType:
          'product_sale',
      remoteCall:
          remote.createSale,
    );
  }

  Future<AccountingTransactionModel>
      createPurchase(
    Map<String, dynamic> payload,
  ) {
    return _create(
      payload: payload,
      operationType:
          'purchase',
      remoteCall:
          remote.createPurchase,
    );
  }

  Future<AccountingTransactionModel>
      _create({
    required Map<String, dynamic>
        payload,
    required String operationType,
    required Future<
            AccountingTransactionModel>
        Function(
      Map<String, dynamic>,
    ) remoteCall,
  }) async {
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
          operationType,
      payload: prepared,
    );

    try {
      final transaction =
          await remoteCall(
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

        throw const CommerceException(
          'تعذر حفظ العملية محليًا.',
        );
      }

      if (_validationFailure(e)) {
        await database.removeSyncOperation(
          operationUuid,
        );

        throw CommerceException(
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

      throw CommerceException(
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

    return 'تعذر ترحيل العملية التجارية.';
  }
}

class CommerceException
    implements Exception {
  final String message;

  const CommerceException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
