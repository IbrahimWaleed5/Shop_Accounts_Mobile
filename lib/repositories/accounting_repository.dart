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
    if (partyId < 0) {
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

    if (_hasTemporaryReference(prepared)) {
      final pending = await database.pendingTransactionByUuid(operationUuid);
      if (pending != null) return pending;
      throw const AccountingException('تعذر حفظ الحركة المحلية.');
    }

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
      if (transaction.status == 'failed' &&
          transaction.reversalOfId != null) {
        await database.markTransactionReversalPending(
          transaction.reversalOfId!,
        );
      }

      final updated =
          await database
              .updatePendingTransactionPayload(
        operationUuid: transaction.uuid,
        payload: payload,
      );

      if (!updated) {
        if (transaction.reversalOfId != null) {
          await database.restoreTransactionPosted(
            transaction.reversalOfId!,
          );
        }
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

    final operationUuid = UuidUtils.v4();
    final prepared = Map<String, dynamic>.from(payload);
    prepared['transaction_id'] = transaction.id;
    prepared['uuid'] = operationUuid;
    prepared['client_created_at'] ??= DateTime.now().toIso8601String();

    // Offline-first correction: the original is hidden from local totals
    // and the corrected replacement is shown as pending until sync.
    await database.markTransactionReversalPending(transaction.id);
    await database.enqueueSyncOperation(
      operationUuid: operationUuid,
      operationType: 'transaction_correct',
      payload: prepared,
    );

    final pending = await database.pendingTransactionByUuid(operationUuid);
    if (pending == null) {
      await database.restoreTransactionPosted(transaction.id);
      await database.removeSyncOperation(operationUuid);
      throw const AccountingException(
        'تعذر حفظ التصحيح محليًا.',
      );
    }

    return pending;
  }

  Future<AccountingTransactionModel>
      reverseTransaction({
    required int transactionId,
    String? reason,
  }) async {
    final transactions = await database.readTransactions();
    AccountingTransactionModel? original;
    for (final item in transactions) {
      if (item.id == transactionId) {
        original = item;
        break;
      }
    }

    if (original == null) {
      throw const AccountingException(
        'تعذر العثور على الحركة محليًا. حدّث السجل ثم حاول مرة أخرى.',
      );
    }

    if (original.status != 'posted') {
      throw const AccountingException(
        'لا يمكن عكس الحركة في حالتها الحالية.',
      );
    }

    final operationUuid = UuidUtils.v4();
    final payload = <String, dynamic>{
      'transaction_id': transactionId,
      'reason': reason,
      'currency_id': original.currencyId,
      'amount_minor': original.amountMinor,
      'occurred_at': DateTime.now().toIso8601String(),
      'party_id': original.partyId,
      'worker_id': original.workerId,
      'category_id': original.categoryId,
      'financial_account_id': original.financialAccountId,
      'target_financial_account_id': original.targetFinancialAccountId,
      'uuid': operationUuid,
      'client_created_at': DateTime.now().toIso8601String(),
    };

    await database.markTransactionReversalPending(transactionId);
    await database.enqueueSyncOperation(
      operationUuid: operationUuid,
      operationType: 'transaction_reverse',
      payload: payload,
    );

    final pending = await database.pendingTransactionByUuid(operationUuid);
    if (pending == null) {
      await database.restoreTransactionPosted(transactionId);
      await database.removeSyncOperation(operationUuid);
      throw const AccountingException(
        'تعذر حفظ القيد العكسي محليًا.',
      );
    }

    return pending;
  }

  bool _hasTemporaryReference(dynamic value) {
    if (value is Map) {
      for (final entry in value.entries) {
        final key = entry.key.toString();
        final current = entry.value;
        if (const {
          'party_id',
          'worker_id',
          'category_id',
          'financial_account_id',
          'target_financial_account_id',
          'product_id',
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
