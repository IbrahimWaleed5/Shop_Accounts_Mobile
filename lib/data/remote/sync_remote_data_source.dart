import '../../core/network/api_client.dart';
import '../../models/sync_operation_model.dart';

class SyncRemoteDataSource {
  final ApiClient apiClient;

  SyncRemoteDataSource(
    this.apiClient,
  );

  Future<List<Map<String, dynamic>>>
      push(
    List<SyncOperationModel> operations,
  ) async {
    final response =
        await apiClient.dio.post(
      '/sync/push',
      data: {
        'operations': operations
            .map(
              (item) =>
                  item.toPushJson(),
            )
            .toList(),
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final data =
        Map<String, dynamic>.from(
      root['data'] as Map,
    );

    final results =
        data['results']
                as List<dynamic>? ??
            [];

    return results
        .map(
          (item) =>
              Map<String, dynamic>.from(
            item as Map,
          ),
        )
        .toList();
  }
}
