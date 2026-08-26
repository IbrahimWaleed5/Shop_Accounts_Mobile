import '../../core/network/api_client.dart';
import '../../models/manager_dashboard_model.dart';

class ManagerDashboardRemoteDataSource {
  final ApiClient apiClient;

  ManagerDashboardRemoteDataSource(
    this.apiClient,
  );

  Future<ManagerDashboardModel> load({
    required String preset,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    String dateText(
      DateTime value,
    ) {
      String two(int number) =>
          number.toString().padLeft(2, '0');

      return '${value.year}-'
          '${two(value.month)}-'
          '${two(value.day)}';
    }

    final response =
        await apiClient.dio.get(
      '/manager/dashboard',
      queryParameters: {
        'preset': preset,
        if (preset == 'custom' &&
            startDate != null)
          'start_date':
              dateText(startDate),
        if (preset == 'custom' &&
            endDate != null)
          'end_date':
              dateText(endDate),
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return ManagerDashboardModel
        .fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }
}
