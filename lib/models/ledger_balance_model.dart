class LedgerBalanceModel {
  final int currencyId;
  final String currencyCode;
  final String currencySymbol;
  final int decimalPlaces;
  final int balanceMinor;

  const LedgerBalanceModel({
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.decimalPlaces,
    required this.balanceMinor,
  });

  factory LedgerBalanceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LedgerBalanceModel(
      currencyId:
          (json['currency_id'] as num).toInt(),
      currencyCode:
          json['currency_code'].toString(),
      currencySymbol:
          json['currency_symbol'].toString(),
      decimalPlaces:
          (json['decimal_places'] as num).toInt(),
      balanceMinor:
          (json['balance_minor'] as num).toInt(),
    );
  }
}

class PartyLedgerModel {
  final int partyId;
  final String name;
  final List<LedgerBalanceModel> receivable;
  final List<LedgerBalanceModel> payable;

  const PartyLedgerModel({
    required this.partyId,
    required this.name,
    required this.receivable,
    required this.payable,
  });

  factory PartyLedgerModel.fromJson(
    Map<String, dynamic> json,
  ) {
    List<LedgerBalanceModel> parse(
      dynamic value,
    ) {
      final list =
          value as List<dynamic>? ?? [];

      return list
          .map(
            (item) =>
                LedgerBalanceModel.fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList();
    }

    return PartyLedgerModel(
      partyId:
          (json['party_id'] as num).toInt(),
      name: json['name'].toString(),
      receivable:
          parse(json['receivable']),
      payable:
          parse(json['payable']),
    );
  }
}

class WorkerLedgerModel {
  final int workerId;
  final String name;
  final List<LedgerBalanceModel> payable;
  final List<LedgerBalanceModel> advances;

  const WorkerLedgerModel({
    required this.workerId,
    required this.name,
    required this.payable,
    required this.advances,
  });

  factory WorkerLedgerModel.fromJson(
    Map<String, dynamic> json,
  ) {
    List<LedgerBalanceModel> parse(
      dynamic value,
    ) {
      final list =
          value as List<dynamic>? ?? [];

      return list
          .map(
            (item) =>
                LedgerBalanceModel.fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList();
    }

    return WorkerLedgerModel(
      workerId:
          (json['worker_id'] as num).toInt(),
      name: json['name'].toString(),
      payable: parse(json['payable']),
      advances: parse(json['advances']),
    );
  }
}
