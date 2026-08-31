import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/party_remote_data_source.dart';
import '../models/party_model.dart';
import '../models/party_opening_balance_model.dart';

class PartyLoadResult {
  final List<PartyModel> parties;
  final bool fromLocal;

  const PartyLoadResult({
    required this.parties,
    required this.fromLocal,
  });
}

class PartyRepository {
  final AppDatabase database;
  final PartyRemoteDataSource remote;

  PartyRepository({
    required this.database,
    required this.remote,
  });

  Future<PartyLoadResult> loadParties({
    String? type,
    String? search,
  }) async {
    if (await database.hasPendingMasterDataChanges()) {
      return PartyLoadResult(
        parties: await database.readParties(type: type, search: search),
        fromLocal: true,
      );
    }

    try {
      final remoteParties = await remote.getParties(
        type: type,
        search: search,
      );
      await database.upsertParties(remoteParties);

      return PartyLoadResult(
        parties: await database.readParties(type: type, search: search),
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw PartyException(_message(e));
      }

      return PartyLoadResult(
        parties: await database.readParties(type: type, search: search),
        fromLocal: true,
      );
    }
  }

  Future<PartyModel> createParty({
    required String type,
    required String name,
    String? phone,
    String? address,
    String? notes,
    required List<PartyOpeningBalanceModel> openingBalances,
  }) async {
    final tempId = await database.nextTemporaryPartyId();
    final uuid = UuidUtils.v4();
    final now = DateTime.now();

    final party = PartyModel(
      id: tempId,
      uuid: uuid,
      type: type,
      name: name.trim(),
      phone: _trim(phone),
      address: _trim(address),
      notes: _trim(notes),
      isActive: true,
      version: 1,
      createdAt: now,
      updatedAt: now,
      openingBalances: openingBalances,
    );

    await database.upsertParties([party]);
    await database.enqueueSyncOperation(
      operationUuid: uuid,
      operationType: 'party_create',
      payload: {
        '_temp_id': tempId,
        'type': type,
        'name': name.trim(),
        'phone': _trim(phone),
        'address': _trim(address),
        'notes': _trim(notes),
        'opening_balances': _openingPayload(openingBalances),
      },
    );

    return party;
  }

  Future<PartyModel> updateParty({
    required int partyId,
    required String type,
    required String name,
    String? phone,
    String? address,
    String? notes,
    required List<PartyOpeningBalanceModel> openingBalances,
  }) async {
    final current = await _findLocal(partyId);
    final now = DateTime.now();

    final updated = PartyModel(
      id: current.id,
      uuid: current.uuid,
      type: type,
      name: name.trim(),
      phone: _trim(phone),
      address: _trim(address),
      notes: _trim(notes),
      isActive: current.isActive,
      version: current.version + 1,
      lastMovementAt: current.lastMovementAt,
      createdAt: current.createdAt,
      updatedAt: now,
      openingBalances: openingBalances,
    );

    await database.upsertParties([updated]);
    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'party_update',
      payload: {
        'party_id': partyId,
        'type': type,
        'name': name.trim(),
        'phone': _trim(phone),
        'address': _trim(address),
        'notes': _trim(notes),
        'opening_balances': _openingPayload(openingBalances),
      },
    );

    return updated;
  }

  Future<PartyModel> setStatus({
    required int partyId,
    required bool isActive,
  }) async {
    final current = await _findLocal(partyId);
    final updated = PartyModel(
      id: current.id,
      uuid: current.uuid,
      type: current.type,
      name: current.name,
      phone: current.phone,
      address: current.address,
      notes: current.notes,
      isActive: isActive,
      version: current.version + 1,
      lastMovementAt: current.lastMovementAt,
      createdAt: current.createdAt,
      updatedAt: DateTime.now(),
      openingBalances: current.openingBalances,
    );

    await database.upsertParties([updated]);
    await database.enqueueSyncOperation(
      operationUuid: UuidUtils.v4(),
      operationType: 'party_status',
      payload: {
        'party_id': partyId,
        'is_active': isActive,
      },
    );

    return updated;
  }

  Future<PartyModel> _findLocal(int id) async {
    final items = await database.readParties();
    for (final item in items) {
      if (item.id == id) return item;
    }
    throw const PartyException('تعذر العثور على الحساب محليًا.');
  }

  List<Map<String, dynamic>> _openingPayload(
    List<PartyOpeningBalanceModel> balances,
  ) {
    return balances
        .map((item) => {
              'currency_id': item.currencyId,
              'balance_side': item.balanceSide,
              'amount_minor': item.amountMinor,
            })
        .toList();
  }

  String? _trim(String? value) {
    final v = value?.trim();
    return v == null || v.isEmpty ? null : v;
  }

  bool _networkFailure(DioException e) {
    return e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout;
  }

  String _message(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final value = errors.values.first;
        if (value is List && value.isNotEmpty) return value.first.toString();
      }
      final message = data['message'];
      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }
    }
    return 'تعذر تحميل الحسابات.';
  }
}

class PartyException implements Exception {
  final String message;
  const PartyException(this.message);
  @override
  String toString() => message;
}
