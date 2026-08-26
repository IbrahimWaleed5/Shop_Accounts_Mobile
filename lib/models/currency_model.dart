class CurrencyModel {
  final int id;
  final String uuid;
  final String code;
  final String nameAr;
  final String symbol;
  final int decimalPlaces;
  final bool isActive;
  final DateTime? updatedAt;

  const CurrencyModel({
    required this.id,
    required this.uuid,
    required this.code,
    required this.nameAr,
    required this.symbol,
    required this.decimalPlaces,
    required this.isActive,
    this.updatedAt,
  });

  factory CurrencyModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CurrencyModel(
      id: json['id'] as int,
      uuid: json['uuid'].toString(),
      code: json['code'].toString(),
      nameAr: json['name_ar'].toString(),
      symbol: json['symbol'].toString(),
      decimalPlaces:
          (json['decimal_places'] as num).toInt(),
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
