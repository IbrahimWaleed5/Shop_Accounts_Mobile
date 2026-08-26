class TransactionItemModel {
  final int id;
  final int? productId;
  final String? productName;
  final String? productSku;
  final String description;

  final int quantityMilli;
  final String unit;

  final int unitPriceMinor;
  final int? unitCostMinor;
  final int lineTotalMinor;
  final int? lineCostMinor;
  final String? costSource;

  const TransactionItemModel({
    required this.id,
    required this.description,
    required this.quantityMilli,
    required this.unit,
    required this.unitPriceMinor,
    required this.lineTotalMinor,
    this.productId,
    this.productName,
    this.productSku,
    this.unitCostMinor,
    this.lineCostMinor,
    this.costSource,
  });

  factory TransactionItemModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TransactionItemModel(
      id: (json['id'] as num).toInt(),
      productId:
          (json['product_id'] as num?)?.toInt(),
      productName:
          json['product_name']?.toString(),
      productSku:
          json['product_sku']?.toString(),
      description:
          json['description'].toString(),
      quantityMilli:
          (json['quantity_milli'] as num)
              .toInt(),
      unit: json['unit'].toString(),
      unitPriceMinor:
          (json['unit_price_minor'] as num)
              .toInt(),
      unitCostMinor:
          (json['unit_cost_minor'] as num?)
              ?.toInt(),
      lineTotalMinor:
          (json['line_total_minor'] as num)
              .toInt(),
      lineCostMinor:
          (json['line_cost_minor'] as num?)
              ?.toInt(),
      costSource:
          json['cost_source']?.toString(),
    );
  }
}
