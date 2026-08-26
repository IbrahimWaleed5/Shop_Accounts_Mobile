class ReportRequestAccountantModel {
  final int id;
  final String name;
  final String email;

  const ReportRequestAccountantModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory ReportRequestAccountantModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReportRequestAccountantModel(
      id:
          (json['id'] as num).toInt(),
      name:
          json['name'].toString(),
      email:
          json['email'].toString(),
    );
  }
}

class ReportRequestModel {
  final int id;
  final String uuid;
  final String reportType;
  final String? managerNote;
  final String status;
  final DateTime? reportFrom;
  final DateTime? reportTo;
  final int? currencyId;
  final String? currencyCode;
  final String? currencySymbol;
  final String? accountantNote;
  final String? requestedByName;
  final String? accountantName;
  final String? accountantEmail;
  final DateTime? submittedAt;
  final DateTime createdAt;
  final ReportRequestSnapshotModel? snapshot;

  const ReportRequestModel({
    required this.id,
    required this.uuid,
    required this.reportType,
    required this.status,
    required this.createdAt,
    this.managerNote,
    this.reportFrom,
    this.reportTo,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.accountantNote,
    this.requestedByName,
    this.accountantName,
    this.accountantEmail,
    this.submittedAt,
    this.snapshot,
  });

  bool get isPending =>
      status == 'pending';

  bool get isSubmitted =>
      status == 'submitted';

  factory ReportRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final snapshotJson =
        json['report_snapshot'];

    return ReportRequestModel(
      id:
          (json['id'] as num).toInt(),
      uuid:
          json['uuid'].toString(),
      reportType:
          json['report_type'].toString(),
      managerNote:
          json['manager_note']
              ?.toString(),
      status:
          json['status'].toString(),
      reportFrom:
          json['report_from'] == null
              ? null
              : DateTime.parse(
                  json['report_from']
                      .toString(),
                ),
      reportTo:
          json['report_to'] == null
              ? null
              : DateTime.parse(
                  json['report_to']
                      .toString(),
                ),
      currencyId:
          (json['currency_id'] as num?)
              ?.toInt(),
      currencyCode:
          json['currency_code']
              ?.toString(),
      currencySymbol:
          json['currency_symbol']
              ?.toString(),
      accountantNote:
          json['accountant_note']
              ?.toString(),
      requestedByName:
          json['requested_by_name']
              ?.toString(),
      accountantName:
          json['accountant_name']
              ?.toString(),
      accountantEmail:
          json['accountant_email']
              ?.toString(),
      submittedAt:
          json['submitted_at'] == null
              ? null
              : DateTime.parse(
                  json['submitted_at']
                      .toString(),
                ),
      createdAt:
          DateTime.parse(
        json['created_at'].toString(),
      ),
      snapshot:
          snapshotJson is Map
              ? ReportRequestSnapshotModel
                  .fromJson(
                Map<String, dynamic>.from(
                  snapshotJson,
                ),
              )
              : null,
    );
  }
}

class ReportRequestSnapshotModel {
  final String reportType;
  final DateTime from;
  final DateTime to;
  final int rowsCount;
  final bool truncated;
  final List<ReportRequestTotalModel> totals;
  final List<ReportRequestRowModel> rows;

  const ReportRequestSnapshotModel({
    required this.reportType,
    required this.from,
    required this.to,
    required this.rowsCount,
    required this.truncated,
    required this.totals,
    required this.rows,
  });

  factory ReportRequestSnapshotModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReportRequestSnapshotModel(
      reportType:
          json['report_type'].toString(),
      from:
          DateTime.parse(
        json['from'].toString(),
      ),
      to:
          DateTime.parse(
        json['to'].toString(),
      ),
      rowsCount:
          (json['rows_count'] as num?)
              ?.toInt() ??
          0,
      truncated:
          json['truncated'] == true,
      totals:
          (json['totals']
                      as List<dynamic>? ??
                  [])
              .map(
                (item) =>
                    ReportRequestTotalModel
                        .fromJson(
                  Map<String, dynamic>.from(
                    item as Map,
                  ),
                ),
              )
              .toList(),
      rows:
          (json['rows']
                      as List<dynamic>? ??
                  [])
              .map(
                (item) =>
                    ReportRequestRowModel
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

class ReportRequestTotalModel {
  final String currencyCode;
  final String currencySymbol;
  final int decimalPlaces;
  final int rowsCount;
  final int reportTotalMinor;
  final int cashInMinor;
  final int cashOutMinor;

  const ReportRequestTotalModel({
    required this.currencyCode,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.rowsCount,
    required this.reportTotalMinor,
    required this.cashInMinor,
    required this.cashOutMinor,
  });

  factory ReportRequestTotalModel.fromJson(
    Map<String, dynamic> json,
  ) {
    int value(String key) =>
        (json[key] as num?)?.toInt() ??
        0;

    return ReportRequestTotalModel(
      currencyCode:
          json['currency_code']
                  ?.toString() ??
              '',
      currencySymbol:
          json['currency_symbol']
                  ?.toString() ??
              '',
      decimalPlaces:
          value('decimal_places'),
      rowsCount:
          value('rows_count'),
      reportTotalMinor:
          value(
        'report_total_minor',
      ),
      cashInMinor:
          value('cash_in_minor'),
      cashOutMinor:
          value('cash_out_minor'),
    );
  }
}

class ReportRequestRowModel {
  final String transactionNo;
  final String type;
  final int reportAmountMinor;
  final String currencyCode;
  final String currencySymbol;
  final int decimalPlaces;
  final String? partyName;
  final String? workerName;
  final String? description;
  final DateTime occurredAt;

  const ReportRequestRowModel({
    required this.transactionNo,
    required this.type,
    required this.reportAmountMinor,
    required this.currencyCode,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.occurredAt,
    this.partyName,
    this.workerName,
    this.description,
  });

  factory ReportRequestRowModel.fromJson(
    Map<String, dynamic> json,
  ) {
    int value(String key) =>
        (json[key] as num?)?.toInt() ??
        0;

    return ReportRequestRowModel(
      transactionNo:
          json['transaction_no']
              .toString(),
      type:
          json['type'].toString(),
      reportAmountMinor:
          value(
        'report_amount_minor',
      ),
      currencyCode:
          json['currency_code']
                  ?.toString() ??
              '',
      currencySymbol:
          json['currency_symbol']
                  ?.toString() ??
              '',
      decimalPlaces:
          value('decimal_places'),
      partyName:
          json['party_name']
              ?.toString(),
      workerName:
          json['worker_name']
              ?.toString(),
      description:
          json['description']
              ?.toString(),
      occurredAt:
          DateTime.parse(
        json['occurred_at'].toString(),
      ),
    );
  }
}
