import 'package:flutter/foundation.dart';

import '../models/report_request_model.dart';
import '../repositories/report_request_repository.dart';

class ReportRequestProvider
    extends ChangeNotifier {
  final ReportRequestRepository
      repository;

  ReportRequestProvider(
    this.repository,
  );

  List<ReportRequestModel> _items =
      [];

  List<ReportRequestAccountantModel>
      _accountants =
      [];

  bool _loading =
      false;

  bool _working =
      false;

  String? _statusFilter;
  String? _error;

  List<ReportRequestModel>
      get items =>
          List.unmodifiable(
            _items,
          );

  List<ReportRequestAccountantModel>
      get accountants =>
          List.unmodifiable(
            _accountants,
          );

  bool get loading =>
      _loading;

  bool get working =>
      _working;

  String? get statusFilter =>
      _statusFilter;

  String? get error =>
      _error;

  Future<void> load({
    String? status,
    bool keepCurrentFilter = false,
  }) async {
    if (!keepCurrentFilter) {
      _statusFilter =
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
            _statusFilter,
      );
    } on ReportRequestException catch (e) {
      _error =
          e.message;
    } finally {
      _loading =
          false;

      notifyListeners();
    }
  }

  Future<void> loadAccountants() async {
    try {
      _accountants =
          await repository.accountants();

      notifyListeners();
    } on ReportRequestException catch (e) {
      _error =
          e.message;

      notifyListeners();
    }
  }

  Future<String?> create({
    required int accountantId,
    required String reportType,
    String? managerNote,
  }) async {
    _working =
        true;

    _error =
        null;

    notifyListeners();

    try {
      final message =
          await repository.create(
        accountantId:
            accountantId,
        reportType:
            reportType,
        managerNote:
            managerNote,
      );

      await load(
        keepCurrentFilter:
            true,
      );

      return message;
    } on ReportRequestException catch (e) {
      _error =
          e.message;

      return null;
    } finally {
      _working =
          false;

      notifyListeners();
    }
  }

  Future<String?> submit({
    required int requestId,
    required DateTime from,
    required DateTime to,
    int? currencyId,
    String? accountantNote,
  }) async {
    _working =
        true;

    _error =
        null;

    notifyListeners();

    try {
      final message =
          await repository.submit(
        requestId:
            requestId,
        from:
            from,
        to:
            to,
        currencyId:
            currencyId,
        accountantNote:
            accountantNote,
      );

      await load(
        keepCurrentFilter:
            true,
      );

      return message;
    } on ReportRequestException catch (e) {
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
