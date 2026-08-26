import 'package:flutter/foundation.dart';

import '../models/home_financial_summary_model.dart';
import '../repositories/dashboard_repository.dart';

class DashboardProvider
    extends ChangeNotifier {
  final DashboardRepository repository;

  DashboardProvider(
    this.repository,
  );

  List<HomeFinancialSummaryModel>
      _summaries = [];

  bool _loading = false;
  bool _fromLocal = false;
  String? _error;

  List<HomeFinancialSummaryModel>
      get summaries =>
          List.unmodifiable(
            _summaries,
          );

  bool get loading =>
      _loading;

  bool get fromLocal =>
      _fromLocal;

  String? get error =>
      _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result =
          await repository
              .loadFinancialSummary();

      _summaries =
          result.summaries;

      _fromLocal =
          result.fromLocal;
    } catch (e) {
      _error =
          'تعذر تحميل الملخص المالي.';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
