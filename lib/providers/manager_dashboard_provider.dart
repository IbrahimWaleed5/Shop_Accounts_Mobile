import 'package:flutter/foundation.dart';

import '../models/manager_dashboard_model.dart';
import '../repositories/manager_dashboard_repository.dart';

class ManagerDashboardProvider
    extends ChangeNotifier {
  final ManagerDashboardRepository
      repository;

  ManagerDashboardProvider(
    this.repository,
  );

  ManagerDashboardModel? _dashboard;

  bool _loading = false;
  String? _error;

  ManagerDashboardModel?
      get dashboard =>
          _dashboard;

  bool get loading =>
      _loading;

  String? get error =>
      _error;

  Future<void> load({
    required String preset,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _dashboard =
          await repository.load(
        preset: preset,
        startDate: startDate,
        endDate: endDate,
      );
    } on ManagerDashboardException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
