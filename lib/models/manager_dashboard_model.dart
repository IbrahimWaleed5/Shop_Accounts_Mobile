class ManagerDashboardModel {
  final String preset;
  final DateTime startDate;
  final DateTime endDate;

  final List<
      ManagerDashboardCurrencyModel>
      currencies;

  final List<
      ManagerDashboardRecentTransaction>
      recentTransactions;

  const ManagerDashboardModel({
    required this.preset,
    required this.startDate,
    required this.endDate,
    required this.currencies,
    required this.recentTransactions,
  });

  factory ManagerDashboardModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final currencies =
        json['currencies']
                as List<dynamic>? ??
            [];

    final recent =
        json['recent_transactions']
                as List<dynamic>? ??
            [];

    return ManagerDashboardModel(
      preset:
          json['preset']?.toString() ??
              'month',
      startDate:
          DateTime.parse(
        json['start_date'].toString(),
      ),
      endDate:
          DateTime.parse(
        json['end_date'].toString(),
      ),
      currencies:
          currencies
              .map(
                (item) =>
                    ManagerDashboardCurrencyModel
                        .fromJson(
                  Map<String, dynamic>.from(
                    item as Map,
                  ),
                ),
              )
              .toList(),
      recentTransactions:
          recent
              .map(
                (item) =>
                    ManagerDashboardRecentTransaction
                        .fromJson(
                  Map<String, dynamic>.from(
                    item as Map,
                  ),
                ),
              )
              .toList(),
    );
  }
}

class ManagerDashboardCurrencyModel {
  final int currencyId;
  final String currencyCode;
  final String currencyNameAr;
  final String currencySymbol;
  final int decimalPlaces;

  final int incomingMinor;
  final int outgoingMinor;
  final int cashResultMinor;

  final int salesTotalMinor;
  final int salesReceivedMinor;

  final int purchasesTotalMinor;
  final int supplierPaidMinor;
  final int supplierDebtPaymentsMinor;

  final int customerCollectionsMinor;
  final int expensesMinor;
  final int otherIncomeMinor;

  final int workerSalaryPaymentsMinor;
  final int workerAdvancesMinor;

  final int financialBalanceTotalMinor;
  final int customerDebtTotalMinor;
  final int supplierDebtTotalMinor;

  final int debtorCount;
  final int supplierDueCount;

  final List<
      ManagerDashboardFinancialAccount>
      financialAccounts;

  final List<
      ManagerDashboardPartyBalance>
      topDebtors;

  final List<
      ManagerDashboardPartyBalance>
      topSuppliers;

  const ManagerDashboardCurrencyModel({
    required this.currencyId,
    required this.currencyCode,
    required this.currencyNameAr,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.incomingMinor,
    required this.outgoingMinor,
    required this.cashResultMinor,
    required this.salesTotalMinor,
    required this.salesReceivedMinor,
    required this.purchasesTotalMinor,
    required this.supplierPaidMinor,
    required this.supplierDebtPaymentsMinor,
    required this.customerCollectionsMinor,
    required this.expensesMinor,
    required this.otherIncomeMinor,
    required this.workerSalaryPaymentsMinor,
    required this.workerAdvancesMinor,
    required this.financialBalanceTotalMinor,
    required this.customerDebtTotalMinor,
    required this.supplierDebtTotalMinor,
    required this.debtorCount,
    required this.supplierDueCount,
    required this.financialAccounts,
    required this.topDebtors,
    required this.topSuppliers,
  });

  factory ManagerDashboardCurrencyModel
      .fromJson(
    Map<String, dynamic> json,
  ) {
    int value(String key) =>
        (json[key] as num?)?.toInt() ??
        0;

    List<T> parseList<T>(
      String key,
      T Function(
        Map<String, dynamic>,
      ) parser,
    ) {
      final list =
          json[key] as List<dynamic>? ??
              [];

      return list
          .map(
            (item) => parser(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList();
    }

    return ManagerDashboardCurrencyModel(
      currencyId:
          value('currency_id'),
      currencyCode:
          json['currency_code']?.toString() ??
              '',
      currencyNameAr:
          json['currency_name_ar']
                  ?.toString() ??
              '',
      currencySymbol:
          json['currency_symbol']
                  ?.toString() ??
              '',
      decimalPlaces:
          value('decimal_places'),
      incomingMinor:
          value('incoming_minor'),
      outgoingMinor:
          value('outgoing_minor'),
      cashResultMinor:
          value('cash_result_minor'),
      salesTotalMinor:
          value('sales_total_minor'),
      salesReceivedMinor:
          value('sales_received_minor'),
      purchasesTotalMinor:
          value('purchases_total_minor'),
      supplierPaidMinor:
          value('supplier_paid_minor'),
      supplierDebtPaymentsMinor:
          value(
        'supplier_debt_payments_minor',
      ),
      customerCollectionsMinor:
          value(
        'customer_collections_minor',
      ),
      expensesMinor:
          value('expenses_minor'),
      otherIncomeMinor:
          value('other_income_minor'),
      workerSalaryPaymentsMinor:
          value(
        'worker_salary_payments_minor',
      ),
      workerAdvancesMinor:
          value('worker_advances_minor'),
      financialBalanceTotalMinor:
          value(
        'financial_balance_total_minor',
      ),
      customerDebtTotalMinor:
          value(
        'customer_debt_total_minor',
      ),
      supplierDebtTotalMinor:
          value(
        'supplier_debt_total_minor',
      ),
      debtorCount:
          value('debtor_count'),
      supplierDueCount:
          value('supplier_due_count'),
      financialAccounts:
          parseList(
        'financial_accounts',
        ManagerDashboardFinancialAccount
            .fromJson,
      ),
      topDebtors:
          parseList(
        'top_debtors',
        ManagerDashboardPartyBalance
            .fromJson,
      ),
      topSuppliers:
          parseList(
        'top_suppliers',
        ManagerDashboardPartyBalance
            .fromJson,
      ),
    );
  }
}

class ManagerDashboardFinancialAccount {
  final int id;
  final String name;
  final String type;
  final bool isActive;
  final int balanceMinor;

  const ManagerDashboardFinancialAccount({
    required this.id,
    required this.name,
    required this.type,
    required this.isActive,
    required this.balanceMinor,
  });

  factory ManagerDashboardFinancialAccount
      .fromJson(
    Map<String, dynamic> json,
  ) {
    return ManagerDashboardFinancialAccount(
      id:
          (json['id'] as num).toInt(),
      name:
          json['name'].toString(),
      type:
          json['type'].toString(),
      isActive:
          json['is_active'] == true ||
              json['is_active'] == 1,
      balanceMinor:
          (json['balance_minor'] as num)
              .toInt(),
    );
  }
}

class ManagerDashboardPartyBalance {
  final int partyId;
  final String partyName;
  final int balanceMinor;

  const ManagerDashboardPartyBalance({
    required this.partyId,
    required this.partyName,
    required this.balanceMinor,
  });

  factory ManagerDashboardPartyBalance
      .fromJson(
    Map<String, dynamic> json,
  ) {
    return ManagerDashboardPartyBalance(
      partyId:
          (json['party_id'] as num)
              .toInt(),
      partyName:
          json['party_name'].toString(),
      balanceMinor:
          (json['balance_minor'] as num)
              .toInt(),
    );
  }
}

class ManagerDashboardRecentTransaction {
  final int id;
  final String transactionNo;
  final String type;
  final int amountMinor;
  final int paidNowMinor;

  final String currencyCode;
  final String currencySymbol;
  final int decimalPlaces;

  final String? partyName;
  final String? workerName;
  final String? financialAccountName;
  final String? description;

  final String status;
  final DateTime occurredAt;

  const ManagerDashboardRecentTransaction({
    required this.id,
    required this.transactionNo,
    required this.type,
    required this.amountMinor,
    required this.paidNowMinor,
    required this.currencyCode,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.status,
    required this.occurredAt,
    this.partyName,
    this.workerName,
    this.financialAccountName,
    this.description,
  });

  factory ManagerDashboardRecentTransaction
      .fromJson(
    Map<String, dynamic> json,
  ) {
    return ManagerDashboardRecentTransaction(
      id:
          (json['id'] as num).toInt(),
      transactionNo:
          json['transaction_no'].toString(),
      type:
          json['type'].toString(),
      amountMinor:
          (json['amount_minor'] as num)
              .toInt(),
      paidNowMinor:
          (json['paid_now_minor'] as num)
              .toInt(),
      currencyCode:
          json['currency_code']?.toString() ??
              '',
      currencySymbol:
          json['currency_symbol']
                  ?.toString() ??
              '',
      decimalPlaces:
          (json['decimal_places'] as num?)
                  ?.toInt() ??
              2,
      partyName:
          json['party_name']?.toString(),
      workerName:
          json['worker_name']?.toString(),
      financialAccountName:
          json['financial_account_name']
              ?.toString(),
      description:
          json['description']?.toString(),
      status:
          json['status'].toString(),
      occurredAt:
          DateTime.parse(
        json['occurred_at'].toString(),
      ),
    );
  }
}
