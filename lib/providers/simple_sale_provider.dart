import 'package:flutter/foundation.dart';

import '../models/accounting_transaction_model.dart';
import '../repositories/simple_sale_repository.dart';

class SimpleSaleProvider
    extends ChangeNotifier {
  final SimpleSaleRepository repository;

  SimpleSaleProvider(
    this.repository,
  );

  bool _submitting = false;
  String? _error;

  bool get submitting =>
      _submitting;

  String? get error =>
      _error;

  Future<AccountingTransactionModel?>
      create(
    Map<String, dynamic> payload,
  ) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      return await repository
          .createSale(payload);
    } on SimpleSaleException catch (e) {
      _error = e.message;
      return null;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
