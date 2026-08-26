import '../../core/network/api_client.dart';
import '../../models/account_request_model.dart';

class AccountRequestRemoteDataSource {
  final ApiClient apiClient;

  AccountRequestRemoteDataSource(
    this.apiClient,
  );

  Future<List<AccountRequestModel>> list({
    required String status,
  }) async {
    final response =
        await apiClient.dio.get(
      '/manager/account-requests',
      queryParameters: {
        'status':
            status,
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final items =
        root['data'] as List<dynamic>? ??
            [];

    return items
        .map(
          (item) =>
              AccountRequestModel
                  .fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<String> approve(
    int userId,
  ) async {
    final response =
        await apiClient.dio.post(
      '/manager/account-requests/'
      '$userId/approve',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return root['message']
            ?.toString() ??
        'تم قبول الطلب.';
  }

  Future<String> reject(
    int userId, {
    String? reason,
  }) async {
    final response =
        await apiClient.dio.post(
      '/manager/account-requests/'
      '$userId/reject',
      data: {
        'reason':
            reason?.trim(),
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return root['message']
            ?.toString() ??
        'تم رفض الطلب.';
  }
}
