import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/product_remote_data_source.dart';
import '../models/currency_model.dart';
import '../models/product_model.dart';

class ProductLoadResult {
  final List<ProductModel> products;
  final bool fromLocal;

  const ProductLoadResult({
    required this.products,
    required this.fromLocal,
  });
}

class ProductRepository {
  final AppDatabase database;
  final ProductRemoteDataSource remote;

  ProductRepository({
    required this.database,
    required this.remote,
  });

  Future<ProductLoadResult> loadProducts({
    String? search,
    String? type,
    int? currencyId,
  }) async {
    if (await database.hasPendingMasterDataChanges()) {
      return ProductLoadResult(
        products: await database.readProducts(
          search: search,
          type: type,
          currencyId: currencyId,
        ),
        fromLocal: true,
      );
    }

    try {
      final products = await remote.getProducts(
        search: search,
        type: type,
        currencyId: currencyId,
      );
      await database.upsertProducts(products);

      for (final product in products) {
        await database.reapplyPendingInventoryForProduct(
          product.id,
        );
      }

      return ProductLoadResult(
        products: await database.readProducts(
          search: search,
          type: type,
          currencyId: currencyId,
        ),
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw ProductException(_message(e));
      }
      return ProductLoadResult(
        products: await database.readProducts(
          search: search,
          type: type,
          currencyId: currencyId,
        ),
        fromLocal: true,
      );
    }
  }

  Future<ProductModel> createProduct(
    Map<String, dynamic> payload,
  ) async {
    final tempId = await database.nextTemporaryProductId();
    final uuid = UuidUtils.v4();
    final refs = await database.readReferenceData();
    final currencyId = (payload['currency_id'] as num).toInt();

    CurrencyModel? currency;
    for (final item in refs.currencies) {
      if (item.id == currencyId) {
        currency = item;
        break;
      }
    }
    if (currency == null) {
      throw const ProductException('تعذر العثور على عملة الصنف محليًا.');
    }

    final openingQty =
        (payload['opening_quantity_milli'] as num?)?.toInt() ?? 0;
    final openingCost =
        (payload['opening_unit_cost_minor'] as num?)?.toInt();

    final product = ProductModel(
      id: tempId,
      uuid: uuid,
      sku: payload['sku']?.toString(),
      name: payload['name'].toString().trim(),
      productType: payload['product_type'].toString(),
      unit: payload['unit'].toString().trim(),
      currencyId: currencyId,
      currencyCode: currency.code,
      currencyNameAr: currency.nameAr,
      currencySymbol: currency.symbol,
      currencyDecimalPlaces: currency.decimalPlaces,
      defaultSalePriceMinor:
          (payload['default_sale_price_minor'] as num?)?.toInt(),
      stockQuantityMilli: openingQty,
      averageCostMinor: openingQty > 0 ? openingCost : null,
      isActive: true,
      version: 1,
    );

    await database.upsertProducts([product]);
    await database.enqueueSyncOperation(
      operationUuid: uuid,
      operationType: 'product_create',
      payload: {
        ...payload,
        '_temp_id': tempId,
      },
    );

    return product;
  }

  Future<ProductModel> updateProduct(
    int productId,
    Map<String, dynamic> payload,
  ) async {
    final current = await _findLocal(productId);
    final refs = await database.readReferenceData();
    final currencyId = (payload['currency_id'] as num).toInt();

    CurrencyModel? currency;
    for (final item in refs.currencies) {
      if (item.id == currencyId) {
        currency = item;
        break;
      }
    }
    if (currency == null) {
      throw const ProductException('تعذر العثور على عملة الصنف محليًا.');
    }

    final updated = ProductModel(
      id: current.id,
      uuid: current.uuid,
      sku: payload['sku']?.toString(),
      name: payload['name'].toString().trim(),
      productType: payload['product_type'].toString(),
      unit: payload['unit'].toString().trim(),
      currencyId: currencyId,
      currencyCode: currency.code,
      currencyNameAr: currency.nameAr,
      currencySymbol: currency.symbol,
      currencyDecimalPlaces: currency.decimalPlaces,
      defaultSalePriceMinor:
          (payload['default_sale_price_minor'] as num?)?.toInt(),
      stockQuantityMilli: current.stockQuantityMilli,
      averageCostMinor: current.averageCostMinor,
      isActive: current.isActive,
      version: current.version + 1,
    );

    await database.upsertProducts([updated]);
    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'product_update',
      payload: {
        ...payload,
        'product_id': productId,
      },
    );

    return updated;
  }

  Future<ProductModel> setStatus({
    required int productId,
    required bool isActive,
  }) async {
    final current = await _findLocal(productId);
    final updated = ProductModel(
      id: current.id,
      uuid: current.uuid,
      sku: current.sku,
      name: current.name,
      productType: current.productType,
      unit: current.unit,
      currencyId: current.currencyId,
      currencyCode: current.currencyCode,
      currencyNameAr: current.currencyNameAr,
      currencySymbol: current.currencySymbol,
      currencyDecimalPlaces: current.currencyDecimalPlaces,
      defaultSalePriceMinor: current.defaultSalePriceMinor,
      stockQuantityMilli: current.stockQuantityMilli,
      averageCostMinor: current.averageCostMinor,
      isActive: isActive,
      version: current.version + 1,
    );

    await database.upsertProducts([updated]);
    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'product_status',
      payload: {
        'product_id': productId,
        'is_active': isActive,
      },
    );
    return updated;
  }

  Future<ProductModel> _findLocal(int id) async {
    for (final item in await database.readProducts()) {
      if (item.id == id) return item;
    }
    throw const ProductException('تعذر العثور على الصنف محليًا.');
  }

  bool _networkFailure(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout;

  String _message(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) return first.first.toString();
      }
      final message = data['message'];
      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }
    }
    return 'تعذر تحميل الأصناف.';
  }
}

class ProductException implements Exception {
  final String message;
  const ProductException(this.message);
  @override
  String toString() => message;
}
