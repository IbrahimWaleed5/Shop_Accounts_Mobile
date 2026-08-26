import 'package:flutter/foundation.dart';

import '../models/accounting_transaction_model.dart';
import '../repositories/commerce_repository.dart';

class CommerceProvider
    extends ChangeNotifier {
  final CommerceRepository repository;

  CommerceProvider(
    this.repository,
  );

  bool _submitting = false;
  String? _error;

  bool get submitting => _submitting;
  String? get error => _error;

  Future<AccountingTransactionModel?>
      create({
    required bool sale,
    required Map<String, dynamic> payload,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      return sale
          ? await repository.createSale(
              payload,
            )
          : await repository.createPurchase(
              payload,
            );
    } on CommerceException catch (e) {
      _error = e.message;
      return null;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
