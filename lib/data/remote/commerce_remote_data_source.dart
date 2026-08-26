import '../../core/network/api_client.dart';
import '../../models/accounting_transaction_model.dart';

class CommerceRemoteDataSource {
  final ApiClient apiClient;

  CommerceRemoteDataSource(
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

    return _fromResponse(
      response.data,
    );
  }

  Future<AccountingTransactionModel>
      createPurchase(
    Map<String, dynamic> payload,
  ) async {
    final response =
        await apiClient.dio.post(
      '/purchases',
      data: payload,
    );

    return _fromResponse(
      response.data,
    );
  }

  AccountingTransactionModel _fromResponse(
    dynamic responseData,
  ) {
    final root =
        Map<String, dynamic>.from(
      responseData as Map,
    );

    return AccountingTransactionModel
        .fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }
}
