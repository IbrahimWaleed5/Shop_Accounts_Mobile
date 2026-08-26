import '../../core/network/api_client.dart';
import '../../models/party_model.dart';
import '../../models/party_opening_balance_model.dart';

class PartyRemoteDataSource {
  final ApiClient apiClient;

  PartyRemoteDataSource(
    this.apiClient,
  );

  Future<List<PartyModel>> getParties({
    String? type,
    String? search,
  }) async {
    final response =
        await apiClient.dio.get(
      '/parties',
      queryParameters: {
        if (type != null &&
            type.isNotEmpty)
          'type': type,
        if (search != null &&
            search.trim().isNotEmpty)
          'q': search.trim(),
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final list =
        root['data'] as List<dynamic>;

    return list
        .map(
          (item) =>
              PartyModel.fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
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
    final response =
        await apiClient.dio.post(
      '/parties',
      data: {
        'type': type,
        'name': name.trim(),
        'phone':
            _nullableText(phone),
        'address':
            _nullableText(address),
        'notes':
            _nullableText(notes),
        'opening_balances':
            openingBalances
                .map(
                  (item) =>
                      item.toRequestJson(),
                )
                .toList(),
      },
    );

    return _partyFromResponse(
      response.data,
    );
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
    final response =
        await apiClient.dio.put(
      '/parties/$partyId',
      data: {
        'type': type,
        'name': name.trim(),
        'phone':
            _nullableText(phone),
        'address':
            _nullableText(address),
        'notes':
            _nullableText(notes),
        'opening_balances':
            openingBalances
                .map(
                  (item) =>
                      item.toRequestJson(),
                )
                .toList(),
      },
    );

    return _partyFromResponse(
      response.data,
    );
  }

  Future<PartyModel> setStatus({
    required int partyId,
    required bool isActive,
  }) async {
    final response =
        await apiClient.dio.patch(
      '/parties/$partyId/status',
      data: {
        'is_active': isActive,
      },
    );

    return _partyFromResponse(
      response.data,
    );
  }

  PartyModel _partyFromResponse(
    dynamic responseData,
  ) {
    final root =
        Map<String, dynamic>.from(
      responseData as Map,
    );

    return PartyModel.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }

  String? _nullableText(
    String? value,
  ) {
    final text = value?.trim() ?? '';

    return text.isEmpty ? null : text;
  }
}
