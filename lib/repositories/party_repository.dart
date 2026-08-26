import 'package:dio/dio.dart';

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
    try {
      final remoteParties =
          await remote.getParties(
        type: type,
        search: search,
      );

      await database.upsertParties(
        remoteParties,
      );

      return PartyLoadResult(
        parties: remoteParties,
        fromLocal: false,
      );
    } on DioException catch (e) {
      if (!_networkFailure(e)) {
        throw PartyException(
          _message(e),
        );
      }

      final local =
          await database.readParties(
        type: type,
        search: search,
      );

      return PartyLoadResult(
        parties: local,
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
    required List<
            PartyOpeningBalanceModel>
        openingBalances,
  }) async {
    try {
      final party =
          await remote.createParty(
        type: type,
        name: name,
        phone: phone,
        address: address,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      await database.upsertParties(
        [party],
      );

      return party;
    } on DioException catch (e) {
      throw PartyException(
        _message(e),
      );
    }
  }

  Future<PartyModel> updateParty({
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
    try {
      final party =
          await remote.updateParty(
        partyId: partyId,
        type: type,
        name: name,
        phone: phone,
        address: address,
        notes: notes,
        openingBalances:
            openingBalances,
      );

      await database.upsertParties(
        [party],
      );

      return party;
    } on DioException catch (e) {
      throw PartyException(
        _message(e),
      );
    }
  }

  Future<PartyModel> setStatus({
    required int partyId,
    required bool isActive,
  }) async {
    try {
      final party =
          await remote.setStatus(
        partyId: partyId,
        isActive: isActive,
      );

      await database.upsertParties(
        [party],
      );

      return party;
    } on DioException catch (e) {
      throw PartyException(
        _message(e),
      );
    }
  }

  bool _networkFailure(
    DioException e,
  ) {
    return e.type ==
            DioExceptionType.connectionError ||
        e.type ==
            DioExceptionType.connectionTimeout ||
        e.type ==
            DioExceptionType.sendTimeout ||
        e.type ==
            DioExceptionType.receiveTimeout;
  }

  String _message(
    DioException e,
  ) {
    final data = e.response?.data;

    if (data is Map) {
      final errors = data['errors'];

      if (errors is Map &&
          errors.isNotEmpty) {
        final value =
            errors.values.first;

        if (value is List &&
            value.isNotEmpty) {
          return value.first.toString();
        }
      }

      final message = data['message'];

      if (message != null &&
          message.toString().isNotEmpty) {
        return message.toString();
      }
    }

    if (_networkFailure(e)) {
      return 'هذه العملية تحتاج إلى اتصال بالإنترنت حاليًا.';
    }

    return 'تعذر تنفيذ العملية.';
  }
}

class PartyException
    implements Exception {
  final String message;

  const PartyException(
    this.message,
  );

  @override
  String toString() => message;
}
