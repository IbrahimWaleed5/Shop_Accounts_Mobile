class HomeFinancialSummaryModel {
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
  final int workerAdvanceRecoveryMinor;

  final int customerDebtTotalMinor;
  final int supplierDebtToShopMinor;
  final int supplierDebtOnShopMinor;

  const HomeFinancialSummaryModel({
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
    required this.workerAdvanceRecoveryMinor,
    this.customerDebtTotalMinor = 0,
    this.supplierDebtToShopMinor = 0,
    this.supplierDebtOnShopMinor = 0,
  });

  factory HomeFinancialSummaryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    int value(String key) =>
        (json[key] as num?)?.toInt() ?? 0;

    return HomeFinancialSummaryModel(
      currencyId:
          value('currency_id'),
      currencyCode:
          json['currency_code']?.toString() ?? '',
      currencyNameAr:
          json['currency_name_ar']?.toString() ?? '',
      currencySymbol:
          json['currency_symbol']?.toString() ?? '',
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
          value('supplier_debt_payments_minor'),
      customerCollectionsMinor:
          value('customer_collections_minor'),
      expensesMinor:
          value('expenses_minor'),
      otherIncomeMinor:
          value('other_income_minor'),
      workerSalaryPaymentsMinor:
          value('worker_salary_payments_minor'),
      workerAdvancesMinor:
          value('worker_advances_minor'),
      workerAdvanceRecoveryMinor:
          value('worker_advance_recovery_minor'),
      customerDebtTotalMinor:
          value('customer_debt_total_minor'),
      supplierDebtToShopMinor:
          value('supplier_debt_to_shop_minor'),
      supplierDebtOnShopMinor:
          value('supplier_debt_on_shop_minor'),
    );
  }

  HomeFinancialSummaryModel copyWith({
    int? incomingMinor,
    int? outgoingMinor,
    int? cashResultMinor,
    int? salesTotalMinor,
    int? salesReceivedMinor,
    int? purchasesTotalMinor,
    int? supplierPaidMinor,
    int? supplierDebtPaymentsMinor,
    int? customerCollectionsMinor,
    int? expensesMinor,
    int? otherIncomeMinor,
    int? workerSalaryPaymentsMinor,
    int? workerAdvancesMinor,
    int? workerAdvanceRecoveryMinor,
    int? customerDebtTotalMinor,
    int? supplierDebtToShopMinor,
    int? supplierDebtOnShopMinor,
  }) {
    return HomeFinancialSummaryModel(
      currencyId: currencyId,
      currencyCode: currencyCode,
      currencyNameAr: currencyNameAr,
      currencySymbol: currencySymbol,
      decimalPlaces: decimalPlaces,
      incomingMinor:
          incomingMinor ?? this.incomingMinor,
      outgoingMinor:
          outgoingMinor ?? this.outgoingMinor,
      cashResultMinor:
          cashResultMinor ?? this.cashResultMinor,
      salesTotalMinor:
          salesTotalMinor ?? this.salesTotalMinor,
      salesReceivedMinor:
          salesReceivedMinor ?? this.salesReceivedMinor,
      purchasesTotalMinor:
          purchasesTotalMinor ?? this.purchasesTotalMinor,
      supplierPaidMinor:
          supplierPaidMinor ?? this.supplierPaidMinor,
      supplierDebtPaymentsMinor:
          supplierDebtPaymentsMinor ??
          this.supplierDebtPaymentsMinor,
      customerCollectionsMinor:
          customerCollectionsMinor ??
          this.customerCollectionsMinor,
      expensesMinor:
          expensesMinor ?? this.expensesMinor,
      otherIncomeMinor:
          otherIncomeMinor ?? this.otherIncomeMinor,
      workerSalaryPaymentsMinor:
          workerSalaryPaymentsMinor ??
          this.workerSalaryPaymentsMinor,
      workerAdvancesMinor:
          workerAdvancesMinor ?? this.workerAdvancesMinor,
      workerAdvanceRecoveryMinor:
          workerAdvanceRecoveryMinor ??
          this.workerAdvanceRecoveryMinor,
      customerDebtTotalMinor:
          customerDebtTotalMinor ??
          this.customerDebtTotalMinor,
      supplierDebtToShopMinor:
          supplierDebtToShopMinor ??
          this.supplierDebtToShopMinor,
      supplierDebtOnShopMinor:
          supplierDebtOnShopMinor ??
          this.supplierDebtOnShopMinor,
    );
  }
}
