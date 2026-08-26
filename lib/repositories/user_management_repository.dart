import 'package:dio/dio.dart';

import '../data/remote/user_management_remote_data_source.dart';
import '../models/app_user.dart';

class UserManagementRepository {
  final UserManagementRemoteDataSource remote;

  UserManagementRepository({
    required this.remote,
  });

  Future<List<AppUser>> getUsers() async {
    try {
      return await remote.getUsers();
    } on DioException catch (e) {
      throw UserManagementException(
        _message(e),
      );
    }
  }

  Future<AppUser> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      return await remote.createUser(
        name: name,
        email: email,
        password: password,
        role: role,
      );
    } on DioException catch (e) {
      throw UserManagementException(
        _message(e),
      );
    }
  }

  Future<AppUser> updateStatus({
    required int userId,
    required String status,
  }) async {
    try {
      return await remote.updateStatus(
        userId: userId,
        status: status,
      );
    } on DioException catch (e) {
      throw UserManagementException(
        _message(e),
      );
    }
  }

  String _message(DioException e) {
    final data = e.response?.data;

    if (data is Map) {
      final errors = data['errors'];

      if (errors is Map &&
          errors.isNotEmpty) {
        final value = errors.values.first;

        if (value is List &&
            value.isNotEmpty) {
          return value.first.toString();
        }
      }

      final message = data['message'];

      if (message != null) {
        return message.toString();
      }
    }

    return 'تعذر الاتصال بالخادم.';
  }
}

class UserManagementException
    implements Exception {
  final String message;

  const UserManagementException(
    this.message,
  );
}