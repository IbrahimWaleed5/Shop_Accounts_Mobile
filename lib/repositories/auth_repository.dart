import 'package:dio/dio.dart';

import '../core/storage/secure_storage_service.dart';
import '../data/local/app_database.dart';
import '../data/remote/auth_remote_data_source.dart';
import '../models/app_user.dart';

class AuthRepository {
  final AppDatabase database;
  final SecureStorageService storage;
  final AuthRemoteDataSource remote;

  AuthRepository({
    required this.database,
    required this.storage,
    required this.remote,
  });

  Future<AppUser?>
      loadTrustedLocalSession() async {
    final token =
        await storage.readToken();

    if (
      token == null ||
      token.isEmpty
    ) {
      return null;
    }

    final localUser =
        await database.getTrustedUser();

    if (localUser == null) {
      return null;
    }

    if (
      localUser.status !=
      'active'
    ) {
      return null;
    }

    return AppUser(
      id:
          localUser.serverId,
      name:
          localUser.name,
      email:
          localUser.email,
      role:
          localUser.role,
      status:
          localUser.status,
      trustedDevice:
          localUser.isTrusted,
    );
  }

  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final deviceUuid =
          await storage
              .getOrCreateDeviceUuid();

      final result =
          await remote.login(
        email:
            email,
        password:
            password,
        deviceUuid:
            deviceUuid,
      );

      await storage.saveToken(
        result.token,
      );

      await database.saveTrustedUser(
        serverId:
            result.user.id,
        name:
            result.user.name,
        email:
            result.user.email,
        role:
            result.user.role,
        status:
            result.user.status,
        deviceUuid:
            deviceUuid,
      );

      return result.user;
    } on DioException catch (e) {
      throw AuthException(
        _extractDioMessage(
          e,
          fallback:
              'تعذر تسجيل الدخول.',
        ),
      );
    } catch (e) {
      if (e is AuthException) {
        rethrow;
      }

      throw const AuthException(
        'حدث خطأ غير متوقع أثناء تسجيل الدخول.',
      );
    }
  }

  Future<String> requestAccount({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
  }) async {
    try {
      return await remote.requestAccount(
        name:
            name,
        email:
            email,
        password:
            password,
        passwordConfirmation:
            passwordConfirmation,
        role:
            role,
      );
    } on DioException catch (e) {
      throw AuthException(
        _extractDioMessage(
          e,
          fallback:
              'تعذر إرسال طلب إنشاء الحساب.',
        ),
      );
    }
  }

  Future<void> logout() async {
    try {
      await remote.logout();
    } catch (_) {
      // تسجيل الخروج المحلي يجب أن يعمل حتى بدون إنترنت.
    }

    await storage.clearToken();
    await database.clearLocalUsers();
  }

  String _extractDioMessage(
    DioException exception, {
    required String fallback,
  }) {
    final responseData =
        exception.response?.data;

    if (responseData is Map) {
      final message =
          responseData['message'];

      if (
        message != null &&
        message.toString().isNotEmpty
      ) {
        return message.toString();
      }

      final errors =
          responseData['errors'];

      if (
        errors is Map &&
        errors.isNotEmpty
      ) {
        final firstValue =
            errors.values.first;

        if (
          firstValue is List &&
          firstValue.isNotEmpty
        ) {
          return firstValue.first
              .toString();
        }
      }
    }

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'تعذر الاتصال بالخادم. تأكد من الإنترنت وعنوان السيرفر.';
      default:
        return fallback;
    }
  }
}

class AuthException
    implements Exception {
  final String message;

  const AuthException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
