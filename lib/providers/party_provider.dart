import 'package:flutter/foundation.dart';

import '../models/party_model.dart';
import '../models/party_opening_balance_model.dart';
import '../repositories/party_repository.dart';

class PartyProvider
    extends ChangeNotifier {
  final PartyRepository repository;

  PartyProvider(
    this.repository,
  );

  List<PartyModel> _parties = [];
  bool _loading = false;
  bool _submitting = false;
  bool _fromLocal = false;
  String? _error;

  List<PartyModel> get parties =>
      List.unmodifiable(_parties);

  bool get loading => _loading;
  bool get submitting => _submitting;
  bool get fromLocal => _fromLocal;
  String? get error => _error;

  Future<void> load({
    String? type,
    String? search,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result =
          await repository.loadParties(
        type: type,
        search: search,
      );

      _parties = result.parties;
      _fromLocal = result.fromLocal;
    } on PartyException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> create({
    required String type,
    required String name,
    String? phone,
    String? address,
    String? notes,
    required List<
            PartyOpeningBalanceModel>
        openingBalances,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.createParty(
        type: type,
        name: name,
        phone: phone,
        address: address,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      return true;
    } on PartyException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> update({
    required int partyId,
    required String type,
    required String name,
    String? phone,
    String? address,
    String? notes,
    required List<
            PartyOpeningBalanceModel>
        openingBalances,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateParty(
        partyId: partyId,
        type: type,
        name: name,
        phone: phone,
        address: address,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      return true;
    } on PartyException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> setStatus({
    required int partyId,
    required bool isActive,
  }) async {
    _submitting = true;
    _error = null;
    notifyListeners();

    try {
      final updated =
          await repository.setStatus(
        partyId: partyId,
        isActive: isActive,
      );

      final index = _parties.indexWhere(
        (item) => item.id == partyId,
      );

      if (index != -1) {
        _parties[index] = updated;
      }

      return true;
    } on PartyException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}
