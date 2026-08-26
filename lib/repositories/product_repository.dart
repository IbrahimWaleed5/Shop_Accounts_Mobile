import 'package:dio/dio.dart';

import '../data/local/app_database.dart';
import '../data/remote/product_remote_data_source.dart';
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
    try {
      final products =
          await remote.getProducts(
        search: search,
        type: type,
        currencyId: currencyId,
      );

      await database.upsertProducts(
        products,
      );

      return ProductLoadResult(
        products: products,
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw ProductException(
          _message(e),
        );
      }

      final products =
          await database.readProducts(
        search: search,
        type: type,
        currencyId: currencyId,
      );

      return ProductLoadResult(
        products: products,
        fromLocal: true,
      );
    }
  }

  Future<ProductModel> createProduct(
    Map<String, dynamic> payload,
  ) async {
    try {
      final product =
          await remote.createProduct(
        payload,
      );

      await database.upsertProducts(
        [product],
      );

      return product;
    } on DioException catch (e) {
      throw ProductException(
        _message(e),
      );
    }
  }

  Future<ProductModel> updateProduct(
    int productId,
    Map<String, dynamic> payload,
  ) async {
    try {
      final product =
          await remote.updateProduct(
        productId,
        payload,
      );

      await database.upsertProducts(
        [product],
      );

      return product;
    } on DioException catch (e) {
      throw ProductException(
        _message(e),
      );
    }
  }

  Future<ProductModel> setStatus({
    required int productId,
    required bool isActive,
  }) async {
    try {
      final product =
          await remote.setStatus(
        productId: productId,
        isActive: isActive,
      );

      await database.upsertProducts(
        [product],
      );

      return product;
    } on DioException catch (e) {
      throw ProductException(
        _message(e),
      );
    }
  }

  bool _networkFailure(
    DioException e,
  ) {
    return e.type ==
            DioExceptionType.connectionError ||
        e.type ==
            DioExceptionType.connectionTimeout ||
        e.type ==
            DioExceptionType.sendTimeout ||
        e.type ==
            DioExceptionType.receiveTimeout;
  }

  String _message(
    DioException e,
  ) {
    final data =
        e.response?.data;

    if (data is Map) {
      final errors = data['errors'];

      if (errors is Map &&
          errors.isNotEmpty) {
        final first =
            errors.values.first;

        if (first is List &&
            first.isNotEmpty) {
          return first.first.toString();
        }
      }

      final message =
          data['message'];

      if (message != null &&
          message.toString().isNotEmpty) {
        return message.toString();
      }
    }

    if (_networkFailure(e)) {
      return 'هذه العملية تحتاج إلى الإنترنت حاليًا.';
    }

    return 'تعذر تنفيذ عملية الصنف.';
  }
}

class ProductException
    implements Exception {
  final String message;

  const ProductException(
    this.message,
  );

  @override
  String toString() => message;
}
