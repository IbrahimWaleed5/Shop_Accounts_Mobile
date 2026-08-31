import 'package:dio/dio.dart';

import '../data/local/app_database.dart';
import '../data/remote/dashboard_remote_data_source.dart';
import '../models/accounting_transaction_model.dart';
import '../models/home_financial_summary_model.dart';
import '../models/party_model.dart';

class DashboardLoadResult {
  final List<HomeFinancialSummaryModel>
      summaries;

  final bool fromLocal;

  const DashboardLoadResult({
    required this.summaries,
    required this.fromLocal,
  });
}

class DashboardRepository {
  final AppDatabase database;
  final DashboardRemoteDataSource remote;

  DashboardRepository({
    required this.database,
    required this.remote,
  });

  Future<DashboardLoadResult>
      loadFinancialSummary() async {
    try {
      final server =
          await remote.getFinancialSummary();

      final pending =
          await database
              .readPendingTransactions();

      final hasMasterChanges =
          await database.hasPendingMasterDataChanges();

      // While there are unsynced local changes, use the local ledger as
      // the source of truth so debts and totals react immediately offline.
      if (pending.isNotEmpty || hasMasterChanges) {
        final localTransactions =
            await database.readAllTransactions();
        final temporaryParties =
            (await database.readParties())
                .where((item) => item.id < 0)
                .toList();

        return DashboardLoadResult(
          summaries: _fromTransactions(
            localTransactions,
            temporaryParties: temporaryParties,
          ),
          fromLocal: true,
        );
      }

      return DashboardLoadResult(
        summaries: server,
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        rethrow;
      }

      final transactions =
          await database
              .readAllTransactions();

      final temporaryParties =
          (await database.readParties())
              .where((item) => item.id < 0)
              .toList();

      return DashboardLoadResult(
        summaries:
            _fromTransactions(
          transactions,
          temporaryParties: temporaryParties,
        ),
        fromLocal: true,
      );
    }
  }

  List<HomeFinancialSummaryModel>
      _mergePending(
    List<HomeFinancialSummaryModel>
        server,
    List<AccountingTransactionModel>
        pending,
  ) {
    final map = {
      for (final item in server)
        item.currencyId: item,
    };

    final pendingSummaries =
        _fromTransactions(
      pending,
    );

    for (
      final pendingSummary
      in pendingSummaries
    ) {
      final current =
          map[pendingSummary.currencyId];

      if (current == null) {
        map[pendingSummary.currencyId] =
            pendingSummary;

        continue;
      }

      map[pendingSummary.currencyId] =
          current.copyWith(
        incomingMinor:
            current.incomingMinor +
                pendingSummary.incomingMinor,
        outgoingMinor:
            current.outgoingMinor +
                pendingSummary.outgoingMinor,
        cashResultMinor:
            current.cashResultMinor +
                pendingSummary.cashResultMinor,
        salesTotalMinor:
            current.salesTotalMinor +
                pendingSummary.salesTotalMinor,
        salesReceivedMinor:
            current.salesReceivedMinor +
                pendingSummary.salesReceivedMinor,
        purchasesTotalMinor:
            current.purchasesTotalMinor +
                pendingSummary.purchasesTotalMinor,
        supplierPaidMinor:
            current.supplierPaidMinor +
                pendingSummary.supplierPaidMinor,
        supplierDebtPaymentsMinor:
            current.supplierDebtPaymentsMinor +
                pendingSummary
                    .supplierDebtPaymentsMinor,
        customerCollectionsMinor:
            current.customerCollectionsMinor +
                pendingSummary
                    .customerCollectionsMinor,
        expensesMinor:
            current.expensesMinor +
                pendingSummary.expensesMinor,
        otherIncomeMinor:
            current.otherIncomeMinor +
                pendingSummary.otherIncomeMinor,
        workerSalaryPaymentsMinor:
            current.workerSalaryPaymentsMinor +
                pendingSummary
                    .workerSalaryPaymentsMinor,
        workerAdvancesMinor:
            current.workerAdvancesMinor +
                pendingSummary.workerAdvancesMinor,
        workerAdvanceRecoveryMinor:
            current.workerAdvanceRecoveryMinor +
                pendingSummary
                    .workerAdvanceRecoveryMinor,
      );
    }

    final result =
        map.values.toList()
          ..sort(
            (a, b) =>
                a.currencyCode.compareTo(
              b.currencyCode,
            ),
          );

    return result;
  }

  List<HomeFinancialSummaryModel>
      _fromTransactions(
    List<AccountingTransactionModel>
        transactions, {
    List<PartyModel> temporaryParties = const [],
  }) {
    final map =
        <int, _MutableSummary>{};

    final customerBalances =
        <int, Map<int, int>>{};
    final supplierBalances =
        <int, Map<int, int>>{};

    void addPartyBalance(
      Map<int, Map<int, int>> target,
      int currencyId,
      int? partyId,
      int delta,
    ) {
      if (partyId == null || delta == 0) return;
      final byParty = target.putIfAbsent(
        currencyId,
        () => <int, int>{},
      );
      byParty[partyId] = (byParty[partyId] ?? 0) + delta;
    }

    for (final party in temporaryParties) {
      for (final balance in party.openingBalances) {
        map.putIfAbsent(
          balance.currencyId,
          () => _MutableSummary(
            currencyId: balance.currencyId,
            currencyCode: balance.currencyCode,
            currencyNameAr: balance.currencyNameAr,
            currencySymbol: balance.currencySymbol,
            decimalPlaces: balance.currencyDecimalPlaces,
          ),
        );

        addPartyBalance(
          balance.balanceSide == 'receivable'
              ? customerBalances
              : supplierBalances,
          balance.currencyId,
          party.id,
          balance.amountMinor,
        );
      }
    }

    for (final item in transactions) {
      if (
        item.status == 'failed' ||
        item.status == 'reversed' ||
        item.status == 'reversed_pending' ||
        item.type == 'reversal'
      ) {
        continue;
      }

      final summary =
          map.putIfAbsent(
        item.currencyId,
        () => _MutableSummary(
          currencyId:
              item.currencyId,
          currencyCode:
              item.currencyCode,
          currencyNameAr:
              item.currencyCode,
          currencySymbol:
              item.currencySymbol,
          decimalPlaces:
              item.currencyDecimalPlaces,
        ),
      );

      switch (item.type) {
        case 'sale':
          addPartyBalance(
            customerBalances,
            item.currencyId,
            item.partyId,
            item.amountMinor - item.paidNowMinor,
          );

          summary.salesTotal +=
              item.amountMinor;

          summary.salesReceived +=
              item.paidNowMinor;

          summary.incoming +=
              item.paidNowMinor;
          break;

        case 'purchase':
          addPartyBalance(
            supplierBalances,
            item.currencyId,
            item.partyId,
            item.amountMinor - item.paidNowMinor,
          );

          summary.purchasesTotal +=
              item.amountMinor;

          summary.supplierPaid +=
              item.paidNowMinor;

          summary.outgoing +=
              item.paidNowMinor;
          break;

        case 'customer_collection':
          addPartyBalance(
            customerBalances,
            item.currencyId,
            item.partyId,
            -item.amountMinor,
          );

          summary.customerCollections +=
              item.amountMinor;

          summary.incoming +=
              item.amountMinor;
          break;

        case 'supplier_payment':
          addPartyBalance(
            supplierBalances,
            item.currencyId,
            item.partyId,
            -item.amountMinor,
          );

          summary.supplierPaid +=
              item.amountMinor;

          summary.supplierDebtPayments +=
              item.amountMinor;

          summary.outgoing +=
              item.amountMinor;
          break;

        case 'customer_opening_balance':
          addPartyBalance(
            customerBalances,
            item.currencyId,
            item.partyId,
            item.amountMinor,
          );
          break;

        case 'supplier_opening_balance':
          addPartyBalance(
            supplierBalances,
            item.currencyId,
            item.partyId,
            item.amountMinor,
          );
          break;

        case 'expense':
          summary.expenses +=
              item.amountMinor;

          summary.outgoing +=
              item.amountMinor;
          break;

        case 'other_income':
          summary.otherIncome +=
              item.amountMinor;

          summary.incoming +=
              item.amountMinor;
          break;

        case 'worker_salary_payment':
          summary.workerSalaryPayments +=
              item.amountMinor;

          summary.outgoing +=
              item.amountMinor;
          break;

        case 'worker_advance':
          summary.workerAdvances +=
              item.amountMinor;

          summary.outgoing +=
              item.amountMinor;
          break;

        case 'worker_advance_recovery':
          summary.workerAdvanceRecovery +=
              item.amountMinor;

          summary.incoming +=
              item.amountMinor;
          break;
      }
    }

    for (final entry in map.entries) {
      final summary = entry.value;
      final customer = customerBalances[entry.key]?.values ?? const <int>[];
      final supplier = supplierBalances[entry.key]?.values ?? const <int>[];

      summary.customerDebtTotal = customer
          .where((value) => value > 0)
          .fold(0, (sum, value) => sum + value);

      summary.supplierDebtOnShop = supplier
          .where((value) => value > 0)
          .fold(0, (sum, value) => sum + value);

      summary.supplierDebtToShop = supplier
          .where((value) => value < 0)
          .fold(0, (sum, value) => sum + value.abs());
    }

    final result =
        map.values
            .map(
              (item) =>
                  item.toModel(),
            )
            .toList()
          ..sort(
            (a, b) =>
                a.currencyCode.compareTo(
              b.currencyCode,
            ),
          );

    return result;
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
}

class _MutableSummary {
  final int currencyId;
  final String currencyCode;
  final String currencyNameAr;
  final String currencySymbol;
  final int decimalPlaces;

  int incoming = 0;
  int outgoing = 0;

  int salesTotal = 0;
  int salesReceived = 0;

  int purchasesTotal = 0;
  int supplierPaid = 0;
  int supplierDebtPayments = 0;

  int customerCollections = 0;
  int expenses = 0;
  int otherIncome = 0;

  int workerSalaryPayments = 0;
  int workerAdvances = 0;
  int workerAdvanceRecovery = 0;

  int customerDebtTotal = 0;
  int supplierDebtToShop = 0;
  int supplierDebtOnShop = 0;

  _MutableSummary({
    required this.currencyId,
    required this.currencyCode,
    required this.currencyNameAr,
    required this.currencySymbol,
    required this.decimalPlaces,
  });

  HomeFinancialSummaryModel
      toModel() {
    return HomeFinancialSummaryModel(
      currencyId: currencyId,
      currencyCode: currencyCode,
      currencyNameAr: currencyNameAr,
      currencySymbol: currencySymbol,
      decimalPlaces: decimalPlaces,
      incomingMinor: incoming,
      outgoingMinor: outgoing,
      cashResultMinor:
          incoming - outgoing,
      salesTotalMinor:
          salesTotal,
      salesReceivedMinor:
          salesReceived,
      purchasesTotalMinor:
          purchasesTotal,
      supplierPaidMinor:
          supplierPaid,
      supplierDebtPaymentsMinor:
          supplierDebtPayments,
      customerCollectionsMinor:
          customerCollections,
      expensesMinor:
          expenses,
      otherIncomeMinor:
          otherIncome,
      workerSalaryPaymentsMinor:
          workerSalaryPayments,
      workerAdvancesMinor:
          workerAdvances,
      workerAdvanceRecoveryMinor:
          workerAdvanceRecovery,
      customerDebtTotalMinor:
          customerDebtTotal,
      supplierDebtToShopMinor:
          supplierDebtToShop,
      supplierDebtOnShopMinor:
          supplierDebtOnShop,
    );
  }
}
