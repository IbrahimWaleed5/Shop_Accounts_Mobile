class PartyOpeningBalanceModel {
  final int? id;
  final int currencyId;
  final String currencyCode;
  final String currencyNameAr;
  final String currencySymbol;
  final int currencyDecimalPlaces;
  final String balanceSide;
  final int amountMinor;

  const PartyOpeningBalanceModel({
    this.id,
    required this.currencyId,
    required this.currencyCode,
    required this.currencyNameAr,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.balanceSide,
    required this.amountMinor,
  });

  factory PartyOpeningBalanceModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PartyOpeningBalanceModel(
      id: (json['id'] as num?)?.toInt(),
      currencyId:
          (json['currency_id'] as num).toInt(),
      currencyCode:
          json['currency_code'].toString(),
      currencyNameAr:
          json['currency_name_ar'].toString(),
      currencySymbol:
          json['currency_symbol'].toString(),
      currencyDecimalPlaces:
          (json['currency_decimal_places'] as num)
              .toInt(),
      balanceSide:
          json['balance_side'].toString(),
      amountMinor:
          (json['amount_minor'] as num).toInt(),
    );
  }

  Map<String, dynamic> toRequestJson() {
    return {
      'currency_id': currencyId,
      'balance_side': balanceSide,
      'amount_minor': amountMinor,
    };
  }
}
