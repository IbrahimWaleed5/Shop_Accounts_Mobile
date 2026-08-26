class FinancialAccountModel {
  final int id;
  final String uuid;
  final String name;
  final String type;
  final int currencyId;
  final String currencyCode;
  final String currencySymbol;
  final int currencyDecimalPlaces;
  final int openingBalanceMinor;
  final String? notes;
  final bool isActive;
  final DateTime? updatedAt;

  const FinancialAccountModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.type,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.openingBalanceMinor,
    required this.isActive,
    this.notes,
    this.updatedAt,
  });

  factory FinancialAccountModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinancialAccountModel(
      id: json['id'] as int,
      uuid: json['uuid'].toString(),
      name: json['name'].toString(),
      type: json['type'].toString(),
      currencyId:
          (json['currency_id'] as num).toInt(),
      currencyCode:
          json['currency_code'].toString(),
      currencySymbol:
          json['currency_symbol'].toString(),
      currencyDecimalPlaces:
          (json['currency_decimal_places'] as num)
              .toInt(),
      openingBalanceMinor:
          (json['opening_balance_minor'] as num)
              .toInt(),
      notes: json['notes']?.toString(),
      isActive: json['is_active'] == true ||
          json['is_active'] == 1,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.tryParse(
              json['updated_at'].toString(),
            ),
    );
  }
}
