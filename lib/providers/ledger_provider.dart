import 'package:flutter/foundation.dart';

import '../models/ledger_balance_model.dart';
import '../repositories/ledger_repository.dart';

class LedgerProvider
    extends ChangeNotifier {
  final LedgerRepository repository;

  LedgerProvider(
    this.repository,
  );

  final Map<int, PartyLedgerModel>
      _partyLedgers = {};

  final Map<int, WorkerLedgerModel>
      _workerLedgers = {};

  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;

  PartyLedgerModel? partyLedger(
    int partyId,
  ) =>
      _partyLedgers[partyId];

  WorkerLedgerModel? workerLedger(
    int workerId,
  ) =>
      _workerLedgers[workerId];

  Future<void> loadParty(
    int partyId,
  ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _partyLedgers[partyId] =
          await repository.getPartyLedger(
        partyId,
      );
    } on LedgerException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> loadWorker(
    int workerId,
  ) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _workerLedgers[workerId] =
          await repository.getWorkerLedger(
        workerId,
      );
    } on LedgerException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
