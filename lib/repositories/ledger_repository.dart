import 'package:dio/dio.dart';

import '../data/local/app_database.dart';
import '../data/remote/ledger_remote_data_source.dart';
import '../models/accounting_transaction_model.dart';
import '../models/ledger_balance_model.dart';

class LedgerRepository {
  final AppDatabase database;
  final LedgerRemoteDataSource remote;

  LedgerRepository({
    required this.database,
    required this.remote,
  });

  Future<PartyLedgerModel>
      getPartyLedger(
    int partyId,
  ) async {
    if (partyId < 0) {
      return _localPartyLedger(partyId);
    }

    try {
      return await remote
          .getPartyLedger(
        partyId,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw LedgerException(
          _message(e),
        );
      }

      return _localPartyLedger(
        partyId,
      );
    }
  }

  Future<WorkerLedgerModel>
      getWorkerLedger(
    int workerId,
  ) async {
    if (workerId < 0) {
      return _localWorkerLedger(workerId);
    }

    try {
      return await remote
          .getWorkerLedger(
        workerId,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw LedgerException(
          _message(e),
        );
      }

      return _localWorkerLedger(
        workerId,
      );
    }
  }

  Future<PartyLedgerModel>
      _localPartyLedger(
    int partyId,
  ) async {
    final transactions =
        await database
            .readAllTransactions();

    final receivable =
        <int, _BalanceAccumulator>{};

    final payable =
        <int, _BalanceAccumulator>{};

    String name = 'الحساب';

    if (partyId < 0) {
      for (final party in await database.readParties()) {
        if (party.id != partyId) continue;

        name = party.name;

        for (final balance in party.openingBalances) {
          final target =
              balance.balanceSide == 'receivable'
                  ? receivable
                  : payable;

          final accumulator = target.putIfAbsent(
            balance.currencyId,
            () => _BalanceAccumulator(
              currencyId: balance.currencyId,
              code: balance.currencyCode,
              symbol: balance.currencySymbol,
              decimalPlaces: balance.currencyDecimalPlaces,
            ),
          );

          accumulator.balance += balance.amountMinor;
        }

        break;
      }
    }

    for (final item in transactions) {
      if (
        item.partyId != partyId ||
        !_countsLocally(item)
      ) {
        continue;
      }

      name =
          item.partyName ?? name;

      switch (item.type) {
        case 'customer_opening_balance':
          _add(
            receivable,
            item,
            item.amountMinor,
          );
          break;

        case 'sale':
          _add(
            receivable,
            item,
            item.amountMinor -
                item.paidNowMinor,
          );
          break;

        case 'customer_collection':
          _add(
            receivable,
            item,
            -item.amountMinor,
          );
          break;

        case 'supplier_opening_balance':
          _add(
            payable,
            item,
            item.amountMinor,
          );
          break;

        case 'purchase':
          _add(
            payable,
            item,
            item.amountMinor -
                item.paidNowMinor,
          );
          break;

        case 'supplier_payment':
          _add(
            payable,
            item,
            -item.amountMinor,
          );
          break;
      }
    }

    return PartyLedgerModel(
      partyId: partyId,
      name: name,
      receivable:
          _toModels(receivable),
      payable:
          _toModels(payable),
    );
  }

  Future<WorkerLedgerModel>
      _localWorkerLedger(
    int workerId,
  ) async {
    final transactions =
        await database
            .readAllTransactions();

    final payable =
        <int, _BalanceAccumulator>{};

    final advances =
        <int, _BalanceAccumulator>{};

    String name = 'العامل';

    if (workerId < 0) {
      for (final worker in await database.readWorkers()) {
        if (worker.id != workerId) continue;

        name = worker.name;

        for (final balance in worker.openingBalances) {
          final target =
              balance.balanceSide == 'advance'
                  ? advances
                  : payable;

          final accumulator = target.putIfAbsent(
            balance.currencyId,
            () => _BalanceAccumulator(
              currencyId: balance.currencyId,
              code: balance.currencyCode,
              symbol: balance.currencySymbol,
              decimalPlaces: balance.currencyDecimalPlaces,
            ),
          );

          accumulator.balance += balance.amountMinor;
        }

        break;
      }
    }

    for (final item in transactions) {
      if (
        item.workerId != workerId ||
        !_countsLocally(item)
      ) {
        continue;
      }

      name =
          item.workerName ?? name;

      switch (item.type) {
        case 'worker_opening_payable':
        case 'worker_salary_accrual':
          _add(
            payable,
            item,
            item.amountMinor,
          );
          break;

        case 'worker_salary_payment':
        case 'worker_deduction':
          _add(
            payable,
            item,
            -item.amountMinor,
          );
          break;

        case 'worker_opening_advance':
        case 'worker_advance':
          _add(
            advances,
            item,
            item.amountMinor,
          );
          break;

        case 'worker_advance_recovery':
          _add(
            advances,
            item,
            -item.amountMinor,
          );
          break;
      }
    }

    return WorkerLedgerModel(
      workerId: workerId,
      name: name,
      payable:
          _toModels(payable),
      advances:
          _toModels(advances),
    );
  }

  bool _countsLocally(
    AccountingTransactionModel item,
  ) {
    return item.status !=
            'reversed' &&
        item.status !=
            'reversed_pending' &&
        item.status !=
            'failed' &&
        item.type !=
            'reversal';
  }

  void _add(
    Map<int, _BalanceAccumulator> map,
    AccountingTransactionModel item,
    int delta,
  ) {
    if (delta == 0) {
      return;
    }

    final accumulator =
        map.putIfAbsent(
      item.currencyId,
      () => _BalanceAccumulator(
        currencyId:
            item.currencyId,
        code:
            item.currencyCode,
        symbol:
            item.currencySymbol,
        decimalPlaces:
            item.currencyDecimalPlaces,
      ),
    );

    accumulator.balance +=
        delta;
  }

  List<LedgerBalanceModel>
      _toModels(
    Map<int, _BalanceAccumulator> map,
  ) {
    final values =
        map.values
            .where(
              (item) =>
                  item.balance != 0,
            )
            .toList()
          ..sort(
            (a, b) =>
                a.code.compareTo(
              b.code,
            ),
          );

    return values
        .map(
          (item) =>
              LedgerBalanceModel(
            currencyId:
                item.currencyId,
            currencyCode:
                item.code,
            currencySymbol:
                item.symbol,
            decimalPlaces:
                item.decimalPlaces,
            balanceMinor:
                item.balance,
          ),
        )
        .toList();
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

    return 'تعذر تحميل الرصيد الحالي من دفتر الأستاذ.';
  }
}

class _BalanceAccumulator {
  final int currencyId;
  final String code;
  final String symbol;
  final int decimalPlaces;

  int balance = 0;

  _BalanceAccumulator({
    required this.currencyId,
    required this.code,
    required this.symbol,
    required this.decimalPlaces,
  });
}

class LedgerException
    implements Exception {
  final String message;

  const LedgerException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
