import 'package:flutter/foundation.dart';

import '../models/report_model.dart';
import '../repositories/report_repository.dart';

class ReportProvider extends ChangeNotifier {
  final ReportRepository repository;

  ReportProvider(this.repository);

  ReportModel? _report;
  bool _loading = false;
  String? _error;

  ReportModel? get report => _report;
  bool get loading => _loading;
  String? get error => _error;

  Future<bool> generate({
    required String reportType,
    required DateTime from,
    required DateTime to,
    int? currencyId,
    int? partyId,
    int? workerId,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _report = await repository.generate(
        reportType: reportType,
        from: from,
        to: to,
        currencyId: currencyId,
        partyId: partyId,
        workerId: workerId,
      );
      return true;
    } on ReportException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear() {
    _report = null;
    _error = null;
    notifyListeners();
  }
}
