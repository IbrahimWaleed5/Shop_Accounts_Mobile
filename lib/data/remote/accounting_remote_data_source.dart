import '../../core/network/api_client.dart';
import '../../models/accounting_transaction_model.dart';

class AccountingRemoteDataSource {
  final ApiClient apiClient;

  AccountingRemoteDataSource(
    this.apiClient,
  );

  Future<List<AccountingTransactionModel>>
      getTransactions() async {
    final response =
        await apiClient.dio.get(
      '/transactions',
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
              AccountingTransactionModel
                  .fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<AccountingTransactionModel>
      createTransaction(
    Map<String, dynamic> payload,
  ) async {
    final response =
        await apiClient.dio.post(
      '/transactions',
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

  Future<AccountingTransactionModel>
      reverseTransaction({
    required int transactionId,
    String? reason,
  }) async {
    final response =
        await apiClient.dio.post(
      '/transactions/$transactionId/reverse',
      data: {
        'reason': reason,
      },
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
