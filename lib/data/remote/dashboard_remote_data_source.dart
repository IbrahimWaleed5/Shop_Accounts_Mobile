import '../../core/network/api_client.dart';
import '../../models/home_financial_summary_model.dart';

class DashboardRemoteDataSource {
  final ApiClient apiClient;

  DashboardRemoteDataSource(
    this.apiClient,
  );

  Future<List<HomeFinancialSummaryModel>>
      getFinancialSummary() async {
    final response =
        await apiClient.dio.get(
      '/manager/dashboard-summary',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final list =
        root['data'] as List<dynamic>? ?? [];

    return list
        .map(
          (item) =>
              HomeFinancialSummaryModel.fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }
}
