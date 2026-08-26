class ReportModel {
  final String reportType;
  final String title;
  final DateTime from;
  final DateTime to;
  final String? entityName;
  final List<ReportTotalModel> totals;
  final List<ReportBalanceModel> balances;
  final List<ReportRowModel> rows;
  final bool truncated;

  const ReportModel({
    required this.reportType,
    required this.title,
    required this.from,
    required this.to,
    required this.totals,
    required this.balances,
    required this.rows,
    required this.truncated,
    this.entityName,
  });

  factory ReportModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReportModel(
      reportType: json['report_type'].toString(),
      title: json['title'].toString(),
      from: DateTime.parse(json['from'].toString()),
      to: DateTime.parse(json['to'].toString()),
      entityName: json['entity_name']?.toString(),
      totals: (json['totals'] as List<dynamic>? ?? [])
          .map((item) => ReportTotalModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),
      balances:
          (json['statement_balances'] as List<dynamic>? ?? [])
              .map((item) => ReportBalanceModel.fromJson(
                    Map<String, dynamic>.from(item as Map),
                  ))
              .toList(),
      rows: (json['rows'] as List<dynamic>? ?? [])
          .map((item) => ReportRowModel.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(),
      truncated: json['truncated'] == true,
    );
  }
}

class ReportTotalModel {
  final int currencyId;
  final String currencyCode;
  final String currencySymbol;
  final int decimalPlaces;
  final int rowsCount;
  final int reportTotalMinor;
  final int cashInMinor;
  final int cashOutMinor;

  const ReportTotalModel({
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.rowsCount,
    required this.reportTotalMinor,
    required this.cashInMinor,
    required this.cashOutMinor,
  });

  factory ReportTotalModel.fromJson(Map<String, dynamic> json) {
    int v(String key) => (json[key] as num?)?.toInt() ?? 0;

    return ReportTotalModel(
      currencyId: v('currency_id'),
      currencyCode: json['currency_code']?.toString() ?? '',
      currencySymbol: json['currency_symbol']?.toString() ?? '',
      decimalPlaces: v('decimal_places'),
      rowsCount: v('rows_count'),
      reportTotalMinor: v('report_total_minor'),
      cashInMinor: v('cash_in_minor'),
      cashOutMinor: v('cash_out_minor'),
    );
  }
}

class ReportBalanceModel {
  final String currencyCode;
  final String currencySymbol;
  final int decimalPlaces;
  final int openingReceivableMinor;
  final int closingReceivableMinor;
  final int openingPayableMinor;
  final int closingPayableMinor;
  final int openingWorkerPayableMinor;
  final int closingWorkerPayableMinor;
  final int openingWorkerAdvanceMinor;
  final int closingWorkerAdvanceMinor;

  const ReportBalanceModel({
    required this.currencyCode,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.openingReceivableMinor,
    required this.closingReceivableMinor,
    required this.openingPayableMinor,
    required this.closingPayableMinor,
    required this.openingWorkerPayableMinor,
    required this.closingWorkerPayableMinor,
    required this.openingWorkerAdvanceMinor,
    required this.closingWorkerAdvanceMinor,
  });

  factory ReportBalanceModel.fromJson(Map<String, dynamic> json) {
    int v(String key) => (json[key] as num?)?.toInt() ?? 0;

    return ReportBalanceModel(
      currencyCode: json['currency_code']?.toString() ?? '',
      currencySymbol: json['currency_symbol']?.toString() ?? '',
      decimalPlaces: v('decimal_places'),
      openingReceivableMinor: v('opening_receivable_minor'),
      closingReceivableMinor: v('closing_receivable_minor'),
      openingPayableMinor: v('opening_payable_minor'),
      closingPayableMinor: v('closing_payable_minor'),
      openingWorkerPayableMinor: v('opening_worker_payable_minor'),
      closingWorkerPayableMinor: v('closing_worker_payable_minor'),
      openingWorkerAdvanceMinor: v('opening_worker_advance_minor'),
      closingWorkerAdvanceMinor: v('closing_worker_advance_minor'),
    );
  }
}

class ReportRowModel {
  final String transactionNo;
  final String type;
  final int reportAmountMinor;
  final int cashEffectMinor;
  final String cashDirection;
  final String currencyCode;
  final String currencySymbol;
  final int decimalPlaces;
  final String? partyName;
  final String? workerName;
  final String? financialAccountName;
  final String? description;
  final String? notes;
  final DateTime occurredAt;

  const ReportRowModel({
    required this.transactionNo,
    required this.type,
    required this.reportAmountMinor,
    required this.cashEffectMinor,
    required this.cashDirection,
    required this.currencyCode,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.occurredAt,
    this.partyName,
    this.workerName,
    this.financialAccountName,
    this.description,
    this.notes,
  });

  factory ReportRowModel.fromJson(Map<String, dynamic> json) {
    int v(String key) => (json[key] as num?)?.toInt() ?? 0;

    return ReportRowModel(
      transactionNo: json['transaction_no'].toString(),
      type: json['type'].toString(),
      reportAmountMinor: v('report_amount_minor'),
      cashEffectMinor: v('cash_effect_minor'),
      cashDirection: json['cash_direction']?.toString() ?? 'none',
      currencyCode: json['currency_code']?.toString() ?? '',
      currencySymbol: json['currency_symbol']?.toString() ?? '',
      decimalPlaces: v('decimal_places'),
      partyName: json['party_name']?.toString(),
      workerName: json['worker_name']?.toString(),
      financialAccountName:
          json['financial_account_name']?.toString(),
      description: json['description']?.toString(),
      notes: json['notes']?.toString(),
      occurredAt: DateTime.parse(json['occurred_at'].toString()),
    );
  }
}
