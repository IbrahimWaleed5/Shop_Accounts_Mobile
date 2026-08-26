class ProductModel {
  final int id;
  final String uuid;
  final String? sku;
  final String name;
  final String productType;
  final String unit;

  final int currencyId;
  final String currencyCode;
  final String currencyNameAr;
  final String currencySymbol;
  final int currencyDecimalPlaces;

  final int? defaultSalePriceMinor;
  final int stockQuantityMilli;
  final int? averageCostMinor;

  final bool isActive;
  final int version;

  const ProductModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.productType,
    required this.unit,
    required this.currencyId,
    required this.currencyCode,
    required this.currencyNameAr,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.stockQuantityMilli,
    required this.isActive,
    required this.version,
    this.sku,
    this.defaultSalePriceMinor,
    this.averageCostMinor,
  });

  bool get isInventory =>
      productType == 'inventory';

  bool get isService =>
      productType == 'service';

  factory ProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ProductModel(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'].toString(),
      sku: json['sku']?.toString(),
      name: json['name'].toString(),
      productType:
          json['product_type'].toString(),
      unit: json['unit'].toString(),
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
      defaultSalePriceMinor:
          (json['default_sale_price_minor']
                  as num?)
              ?.toInt(),
      stockQuantityMilli:
          (json['stock_quantity_milli'] as num)
              .toInt(),
      averageCostMinor:
          (json['average_cost_minor'] as num?)
              ?.toInt(),
      isActive: json['is_active'] == true ||
          json['is_active'] == 1,
      version:
          (json['version'] as num).toInt(),
    );
  }
}
