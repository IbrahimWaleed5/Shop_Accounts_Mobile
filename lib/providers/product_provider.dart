import 'package:flutter/foundation.dart';

import '../models/product_model.dart';
import '../repositories/product_repository.dart';

class ProductProvider
    extends ChangeNotifier {
  final ProductRepository repository;

  ProductProvider(
    this.repository,
  );

  List<ProductModel> _products = [];
  bool _loading = false;
  bool _submitting = false;
  bool _fromLocal = false;
  String? _error;

  List<ProductModel> get products =>
      List.unmodifiable(_products);

  bool get loading => _loading;
  bool get submitting => _submitting;
  bool get fromLocal => _fromLocal;
  String? get error => _error;

  Future<void> load({
    String? search,
    String? type,
    int? currencyId,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result =
          await repository.loadProducts(
        search: search,
        type: type,
        currencyId: currencyId,
      );

      _products = result.products;
      _fromLocal = result.fromLocal;
    } on ProductException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> create(
    Map<String, dynamic> payload,
  ) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.createProduct(
        payload,
      );

      await load();
      return true;
    } on ProductException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> update(
    int productId,
    Map<String, dynamic> payload,
  ) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateProduct(
        productId,
        payload,
      );

      await load();
      return true;
    } on ProductException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> setStatus({
    required int productId,
    required bool isActive,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      final updated =
          await repository.setStatus(
        productId: productId,
        isActive: isActive,
      );

      final index =
          _products.indexWhere(
        (item) => item.id == productId,
      );

      if (index != -1) {
        _products[index] = updated;
      }

      return true;
    } on ProductException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
