import 'package:flutter/foundation.dart';

import '../models/worker_model.dart';
import '../models/worker_opening_balance_model.dart';
import '../repositories/worker_repository.dart';

class WorkerProvider
    extends ChangeNotifier {
  final WorkerRepository repository;

  WorkerProvider(
    this.repository,
  );

  List<WorkerModel> _workers = [];

  bool _loading = false;
  bool _submitting = false;
  bool _fromLocal = false;

  String? _error;

  List<WorkerModel> get workers =>
      List.unmodifiable(_workers);

  bool get loading => _loading;
  bool get submitting => _submitting;
  bool get fromLocal => _fromLocal;
  String? get error => _error;

  Future<void> load({
    String? search,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result =
          await repository.loadWorkers(
        search: search,
      );

      _workers = result.workers;
      _fromLocal =
          result.fromLocal;
    } on WorkerException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> create({
    required String name,
    String? phone,
    String? jobTitle,
    required String wageType,
    int? wageCurrencyId,
    int? wageAmountMinor,
    DateTime? hireDate,
    String? notes,
    required List<
            WorkerOpeningBalanceModel>
        openingBalances,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.createWorker(
        name: name,
        phone: phone,
        jobTitle: jobTitle,
        wageType: wageType,
        wageCurrencyId:
            wageCurrencyId,
        wageAmountMinor:
            wageAmountMinor,
        hireDate: hireDate,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      return true;
    } on WorkerException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> update({
    required int workerId,
    required String name,
    String? phone,
    String? jobTitle,
    required String wageType,
    int? wageCurrencyId,
    int? wageAmountMinor,
    DateTime? hireDate,
    String? notes,
    required List<
            WorkerOpeningBalanceModel>
        openingBalances,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateWorker(
        workerId: workerId,
        name: name,
        phone: phone,
        jobTitle: jobTitle,
        wageType: wageType,
        wageCurrencyId:
            wageCurrencyId,
        wageAmountMinor:
            wageAmountMinor,
        hireDate: hireDate,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      return true;
    } on WorkerException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> setStatus({
    required int workerId,
    required bool isActive,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      final updated =
          await repository.setStatus(
        workerId: workerId,
        isActive: isActive,
      );

      final index =
          _workers.indexWhere(
        (item) =>
            item.id == workerId,
      );

      if (index != -1) {
        _workers[index] =
            updated;
      }

      return true;
    } on WorkerException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
