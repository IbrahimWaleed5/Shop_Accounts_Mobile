import '../../core/network/api_client.dart';
import '../../models/app_user.dart';

class UserManagementRemoteDataSource {
  final ApiClient apiClient;

  UserManagementRemoteDataSource(
    this.apiClient,
  );

  Future<List<AppUser>> getUsers() async {
    final response =
        await apiClient.dio.get('/users');

    final root = Map<String, dynamic>.from(
      response.data as Map,
    );

    final list = root['data'] as List<dynamic>;

    return list.map((item) {
      return AppUser.fromJson(
        Map<String, dynamic>.from(
          item as Map,
        ),
      );
    }).toList();
  }

  Future<AppUser> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final response =
        await apiClient.dio.post(
      '/users',
      data: {
        'name': name.trim(),
        'email':
            email.trim().toLowerCase(),
        'password': password,
        'password_confirmation': password,
        'role': role,
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return AppUser.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }

  Future<AppUser> updateStatus({
    required int userId,
    required String status,
  }) async {
    final response =
        await apiClient.dio.patch(
      '/users/$userId/status',
      data: {
        'status': status,
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return AppUser.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }
}