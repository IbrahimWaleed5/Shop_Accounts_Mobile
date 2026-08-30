import 'package:flutter/foundation.dart';

import '../models/accounting_transaction_model.dart';
import '../repositories/accounting_repository.dart';

class AccountingProvider
    extends ChangeNotifier {
  final AccountingRepository repository;

  AccountingProvider(
    this.repository,
  );

  List<AccountingTransactionModel>
      _transactions = [];

  final Map<int, List<AccountingTransactionModel>>
      _partyStatements = {};

  bool _loading = false;
  bool _submitting = false;
  bool _fromLocal = false;

  String? _error;
  String? _lastCreatedStatus;

  List<AccountingTransactionModel>
      get transactions =>
          List.unmodifiable(
            _transactions,
          );

  List<AccountingTransactionModel>
      partyStatement(
    int partyId,
  ) =>
          List.unmodifiable(
            _partyStatements[partyId] ??
                const <AccountingTransactionModel>[],
          );

  bool get loading =>
      _loading;

  bool get submitting =>
      _submitting;

  bool get fromLocal =>
      _fromLocal;

  String? get error =>
      _error;

  String? get lastCreatedStatus =>
      _lastCreatedStatus;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result =
          await repository
              .loadTransactions();

      _transactions =
          result.transactions;

      _fromLocal =
          result.fromLocal;
    } on AccountingException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadPartyStatement(
    int partyId,
  ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result =
          await repository
              .loadPartyTransactions(
        partyId,
      );

      _partyStatements[partyId] =
          result.transactions;
      _fromLocal = result.fromLocal;
    } on AccountingException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(
    Map<String, dynamic> payload,
  ) async {
    _submitting = true;
    _error = null;
    _lastCreatedStatus = null;
    notifyListeners();

    try {
      final transaction =
          await repository
              .createTransaction(
        payload,
      );

      _lastCreatedStatus =
          transaction.status;

      await load();

      return true;
    } on AccountingException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> edit({
    required AccountingTransactionModel transaction,
    required Map<String, dynamic> payload,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.editTransaction(
        transaction: transaction,
        payload: payload,
      );

      await load();

      if (transaction.partyId != null) {
        await loadPartyStatement(
          transaction.partyId!,
        );
      }

      return true;
    } on AccountingException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> reverse({
    required int transactionId,
    String? reason,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository
          .reverseTransaction(
        transactionId:
            transactionId,
        reason: reason,
      );

      await load();

      return true;
    } on AccountingException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
