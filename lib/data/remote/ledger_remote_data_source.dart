import '../../core/network/api_client.dart';
import '../../models/ledger_balance_model.dart';

class LedgerRemoteDataSource {
  final ApiClient apiClient;

  LedgerRemoteDataSource(
    this.apiClient,
  );

  Future<PartyLedgerModel>
      getPartyLedger(
    int partyId,
  ) async {
    final response =
        await apiClient.dio.get(
      '/ledger/parties/$partyId',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return PartyLedgerModel.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }

  Future<WorkerLedgerModel>
      getWorkerLedger(
    int workerId,
  ) async {
    final response =
        await apiClient.dio.get(
      '/ledger/workers/$workerId',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return WorkerLedgerModel.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }
}
