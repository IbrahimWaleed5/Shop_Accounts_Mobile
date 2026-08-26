import 'package:flutter/foundation.dart';

import '../models/category_model.dart';
import '../models/currency_model.dart';
import '../models/financial_account_model.dart';
import '../repositories/reference_repository.dart';

class ReferenceDataProvider
    extends ChangeNotifier {
  final ReferenceRepository repository;

  ReferenceDataProvider(
    this.repository,
  );

  List<CurrencyModel> _currencies = [];
  List<FinancialAccountModel>
      _financialAccounts = [];
  List<CategoryModel> _categories = [];

  bool _isLoading = false;
  bool _isSubmitting = false;
  bool _fromLocal = false;
  String? _error;

  List<CurrencyModel> get currencies =>
      List.unmodifiable(_currencies);

  List<CurrencyModel> get activeCurrencies =>
      _currencies
          .where((item) => item.isActive)
          .toList();

  List<FinancialAccountModel>
      get financialAccounts =>
          List.unmodifiable(
            _financialAccounts,
          );

  List<CategoryModel> get categories =>
      List.unmodifiable(_categories);

  bool get isLoading => _isLoading;
  bool get isSubmitting => _isSubmitting;
  bool get fromLocal => _fromLocal;
  String? get error => _error;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result =
          await repository.loadReferenceData();

      _currencies =
          result.data.currencies;

      _financialAccounts =
          result.data.financialAccounts;

      _categories =
          result.data.categories;

      _fromLocal = result.fromLocal;
    } on ReferenceException catch (e) {
      _error = e.message;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createFinancialAccount({
    required String name,
    required String type,
    required int currencyId,
    required int openingBalanceMinor,
    String? notes,
  }) async {
    _isSubmitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.createFinancialAccount(
        name: name,
        type: type,
        currencyId: currencyId,
        openingBalanceMinor:
            openingBalanceMinor,
        notes: notes,
      );

      await load();

      return true;
    } on ReferenceException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> setFinancialAccountStatus({
    required int accountId,
    required bool isActive,
  }) async {
    _isSubmitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository
          .setFinancialAccountStatus(
        accountId: accountId,
        isActive: isActive,
      );

      await load();

      return true;
    } on ReferenceException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> createCategory({
    required String name,
    required String type,
    String? notes,
  }) async {
    _isSubmitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.createCategory(
        name: name,
        type: type,
        notes: notes,
      );

      await load();

      return true;
    } on ReferenceException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  Future<bool> setCategoryStatus({
    required int categoryId,
    required bool isActive,
  }) async {
    _isSubmitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.setCategoryStatus(
        categoryId: categoryId,
        isActive: isActive,
      );

      await load();

      return true;
    } on ReferenceException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
