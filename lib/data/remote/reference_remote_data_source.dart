import '../../core/network/api_client.dart';
import '../../models/reference_data_model.dart';

class ReferenceRemoteDataSource {
  final ApiClient apiClient;

  ReferenceRemoteDataSource(
    this.apiClient,
  );

  Future<ReferenceDataModel>
      fetchReferenceData() async {
    final response =
        await apiClient.dio.get(
      '/reference-data',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final data =
        Map<String, dynamic>.from(
      root['data'] as Map,
    );

    return ReferenceDataModel.fromJson(
      data,
    );
  }

  Future<void> createFinancialAccount({
    required String name,
    required String type,
    required int currencyId,
    required int openingBalanceMinor,
    String? notes,
  }) async {
    await apiClient.dio.post(
      '/financial-accounts',
      data: {
        'name': name.trim(),
        'type': type,
        'currency_id': currencyId,
        'opening_balance_minor':
            openingBalanceMinor,
        'notes': notes?.trim().isEmpty == true
            ? null
            : notes?.trim(),
      },
    );
  }

  Future<void> setFinancialAccountStatus({
    required int accountId,
    required bool isActive,
  }) async {
    await apiClient.dio.patch(
      '/financial-accounts/$accountId/status',
      data: {
        'is_active': isActive,
      },
    );
  }

  Future<void> createCategory({
    required String name,
    required String type,
    String? notes,
  }) async {
    await apiClient.dio.post(
      '/categories',
      data: {
        'name': name.trim(),
        'type': type,
        'notes': notes?.trim().isEmpty == true
            ? null
            : notes?.trim(),
      },
    );
  }

  Future<void> setCategoryStatus({
    required int categoryId,
    required bool isActive,
  }) async {
    await apiClient.dio.patch(
      '/categories/$categoryId/status',
      data: {
        'is_active': isActive,
      },
    );
  }
}
