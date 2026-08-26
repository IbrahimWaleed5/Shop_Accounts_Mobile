import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../repositories/user_management_repository.dart';

class UserManagementProvider
    extends ChangeNotifier {
  final UserManagementRepository repository;

  UserManagementProvider(
    this.repository,
  );

  List<AppUser> _users = [];

  bool _loading = false;
  bool _submitting = false;

  String? _error;

  List<AppUser> get users =>
      List.unmodifiable(_users);

  bool get loading => _loading;

  bool get submitting => _submitting;

  String? get error => _error;

  Future<void> loadUsers() async {
    _loading = true;
    _error = null;

    notifyListeners();

    try {
      _users =
          await repository.getUsers();
    } on UserManagementException catch (e) {
      _error = e.message;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    _submitting = true;
    _error = null;

    notifyListeners();

    try {
      await repository.createUser(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      await loadUsers();

      return true;
    } on UserManagementException catch (e) {
      _error = e.message;

      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }

  Future<bool> updateStatus({
    required int userId,
    required String status,
  }) async {
    _submitting = true;
    _error = null;

    notifyListeners();

    try {
      await repository.updateStatus(
        userId: userId,
        status: status,
      );

      await loadUsers();

      return true;
    } on UserManagementException catch (e) {
      _error = e.message;

      return false;
    } finally {
      _submitting = false;
      notifyListeners();
    }
  }
}