import 'package:flutter/foundation.dart';

import '../models/account_request_model.dart';
import '../repositories/account_request_repository.dart';

class AccountRequestProvider
    extends ChangeNotifier {
  final AccountRequestRepository
      repository;

  AccountRequestProvider(
    this.repository,
  );

  List<AccountRequestModel> _items =
      [];

  bool _loading =
      false;

  bool _working =
      false;

  String _status =
      'pending';

  String? _error;

  List<AccountRequestModel>
      get items =>
          List.unmodifiable(
            _items,
          );

  bool get loading =>
      _loading;

  bool get working =>
      _working;

  String get status =>
      _status;

  String? get error =>
      _error;

  Future<void> load({
    String? status,
  }) async {
    if (status != null) {
      _status =
          status;
    }

    _loading =
        true;

    _error =
        null;

    notifyListeners();

    try {
      _items =
          await repository.list(
        status:
            _status,
      );
    } on AccountRequestException catch (e) {
      _error =
          e.message;
    } finally {
      _loading =
          false;

      notifyListeners();
    }
  }

  Future<String?> approve(
    int userId,
  ) async {
    _working =
        true;

    _error =
        null;

    notifyListeners();

    try {
      final message =
          await repository.approve(
        userId,
      );

      await load(
        status:
            _status,
      );

      return message;
    } on AccountRequestException catch (e) {
      _error =
          e.message;

      return null;
    } finally {
      _working =
          false;

      notifyListeners();
    }
  }

  Future<String?> reject(
    int userId, {
    String? reason,
  }) async {
    _working =
        true;

    _error =
        null;

    notifyListeners();

    try {
      final message =
          await repository.reject(
        userId,
        reason:
            reason,
      );

      await load(
        status:
            _status,
      );

      return message;
    } on AccountRequestException catch (e) {
      _error =
          e.message;

      return null;
    } finally {
      _working =
          false;

      notifyListeners();
    }
  }
}
