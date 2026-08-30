import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/accounting_remote_data_source.dart';
import '../models/accounting_transaction_model.dart';

class AccountingLoadResult {
  final List<AccountingTransactionModel>
      transactions;
  final bool fromLocal;

  const AccountingLoadResult({
    required this.transactions,
    required this.fromLocal,
  });
}

class AccountingRepository {
  final AppDatabase database;
  final AccountingRemoteDataSource remote;

  AccountingRepository({
    required this.database,
    required this.remote,
  });

  Future<AccountingLoadResult>
      loadTransactions() async {
    try {
      final remoteData =
          await remote.getTransactions();

      await database.upsertTransactions(
        remoteData,
      );

      final pending =
          await database
              .readPendingTransactions();

      final combined = [
        ...pending,
        ...remoteData,
      ]..sort(
          (a, b) =>
              b.occurredAt.compareTo(
            a.occurredAt,
          ),
        );

      return AccountingLoadResult(
        transactions: combined,
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw AccountingException(
          _message(e),
        );
      }

      return AccountingLoadResult(
        transactions:
            await database
                .readAllTransactions(),
        fromLocal: true,
      );
    }
  }

  Future<AccountingLoadResult>
      loadPartyTransactions(
    int partyId,
  ) async {
    try {
      final remoteData =
          await remote.getTransactions(
        partyId: partyId,
      );

      await database.upsertTransactions(
        remoteData,
      );

      final pending =
          (await database
                  .readPendingTransactions())
              .where(
                (item) =>
                    item.partyId == partyId,
              )
              .toList();

      final combined = [
        ...pending,
        ...remoteData,
      ]..sort(
          (a, b) =>
              b.occurredAt.compareTo(
            a.occurredAt,
          ),
        );

      return AccountingLoadResult(
        transactions: combined,
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw AccountingException(
          _message(e),
        );
      }

      final local =
          (await database
                  .readAllTransactions())
              .where(
                (item) =>
                    item.partyId == partyId,
              )
              .toList();

      return AccountingLoadResult(
        transactions: local,
        fromLocal: true,
      );
    }
  }

  Future<AccountingTransactionModel>
      createTransaction(
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

    // Local-first:
    // write the operation before attempting HTTP.
    await database.enqueueSyncOperation(
      operationUuid:
          operationUuid,
      operationType:
          'accounting_transaction',
      payload: prepared,
    );

    try {
      final transaction =
          await remote.createTransaction(
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

        throw const AccountingException(
          'تعذر حفظ نسخة الحركة المحلية.',
        );
      }

      if (_validationFailure(e)) {
        await database.removeSyncOperation(
          operationUuid,
        );

        throw AccountingException(
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

      throw AccountingException(
        _message(e),
      );
    }
  }

  Future<AccountingTransactionModel>
      editTransaction({
    required AccountingTransactionModel transaction,
    required Map<String, dynamic> payload,
  }) async {
    final localOnly =
        transaction.id < 0 ||
        transaction.status == 'pending_sync' ||
        transaction.status == 'failed';

    if (localOnly) {
      final updated =
          await database
              .updatePendingTransactionPayload(
        operationUuid: transaction.uuid,
        payload: payload,
      );

      if (!updated) {
        throw const AccountingException(
          'تعذر تعديل الحركة المحلية. إذا كانت المزامنة بدأت، انتظر انتهاءها ثم حاول مجددًا.',
        );
      }

      final pending =
          await database
              .pendingTransactionByUuid(
        transaction.uuid,
      );

      if (pending == null) {
        throw const AccountingException(
          'تعذر قراءة الحركة بعد التعديل.',
        );
      }

      return pending;
    }

    if (transaction.status != 'posted') {
      throw const AccountingException(
        'هذه الحركة لا يمكن تعديلها في حالتها الحالية.',
      );
    }

    try {
      final corrected =
          await remote.correctTransaction(
        transactionId: transaction.id,
        payload: payload,
      );

      final remoteData =
          await remote.getTransactions();

      await database.upsertTransactions(
        remoteData,
      );

      return corrected;
    } on DioException catch (e) {
      throw AccountingException(
        _networkFailure(e)
            ? 'تصحيح الحركة المرحلة يحتاج اتصالًا بالخادم.'
            : _message(e),
      );
    }
  }

  Future<AccountingTransactionModel>
      reverseTransaction({
    required int transactionId,
    String? reason,
  }) async {
    // Reversal remains online-only because it must validate
    // the authoritative server transaction and inventory state.
    try {
      final transaction =
          await remote.reverseTransaction(
        transactionId: transactionId,
        reason: reason,
      );

      final remoteData =
          await remote.getTransactions();

      await database.upsertTransactions(
        remoteData,
      );

      return transaction;
    } on DioException catch (e) {
      throw AccountingException(
        _networkFailure(e)
            ? 'عكس الحركة يحتاج اتصالًا بالخادم للتحقق من حالتها الحالية.'
            : _message(e),
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

      if (errors is Map &&
          errors.isNotEmpty) {
        final value =
            errors.values.first;

        if (
          value is List &&
          value.isNotEmpty
        ) {
          return value.first
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

    return 'تعذر تنفيذ العملية المحاسبية.';
  }
}

class AccountingException
    implements Exception {
  final String message;

  const AccountingException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
