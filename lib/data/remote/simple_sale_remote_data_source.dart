import '../../core/network/api_client.dart';
import '../../models/accounting_transaction_model.dart';

class SimpleSaleRemoteDataSource {
  final ApiClient apiClient;

  SimpleSaleRemoteDataSource(
    this.apiClient,
  );

  Future<AccountingTransactionModel>
      createSale(
    Map<String, dynamic> payload,
  ) async {
    final response =
        await apiClient.dio.post(
      '/sales',
      data: payload,
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return AccountingTransactionModel
        .fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }
}
