import '../../core/network/api_client.dart';
import '../../models/app_user.dart';

class AuthLoginResult {
  final String token;
  final AppUser user;

  const AuthLoginResult({
    required this.token,
    required this.user,
  });
}

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(
    this.apiClient,
  );

  Future<AuthLoginResult> login({
    required String email,
    required String password,
    required String deviceUuid,
  }) async {
    final response =
        await apiClient.dio.post(
      '/auth/login',
      data: {
        'email':
            email
                .trim()
                .toLowerCase(),
        'password':
            password,
        'device_uuid':
            deviceUuid,
        'device_name':
            'shop-mobile-'
            '${deviceUuid.substring(0, 8)}',
        'platform':
            'flutter-mobile',
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

    final userJson =
        Map<String, dynamic>.from(
      data['user'] as Map,
    );

    return AuthLoginResult(
      token:
          data['token'].toString(),
      user:
          AppUser.fromJson(
        userJson,
        trustedDevice:
            true,
      ),
    );
  }

  Future<String> requestAccount({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
  }) async {
    final response =
        await apiClient.dio.post(
      '/auth/register-request',
      data: {
        'name':
            name.trim(),
        'email':
            email
                .trim()
                .toLowerCase(),
        'password':
            password,
        'password_confirmation':
            passwordConfirmation,
        'role':
            role,
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return root['message']
            ?.toString() ??
        'تم إرسال طلب إنشاء الحساب.';
  }

  Future<AppUser> me() async {
    final response =
        await apiClient.dio.get(
      '/auth/me',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final data =
        Map<String, dynamic>.from(
      root['data'] as Map,
    );

    return AppUser.fromJson(
      data,
      trustedDevice:
          true,
    );
  }

  Future<void> logout() async {
    await apiClient.dio.post(
      '/auth/logout',
    );
  }
}
