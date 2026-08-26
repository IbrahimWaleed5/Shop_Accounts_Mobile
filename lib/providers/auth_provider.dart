import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import '../repositories/auth_repository.dart';

class AuthProvider
    extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider(
    this.repository,
  );

  AppUser? _user;

  bool _isBootstrapping =
      true;

  bool _isLoading =
      false;

  bool _requestLoading =
      false;

  bool _localTrustedSession =
      false;

  String? _errorMessage;
  String? _requestError;
  String? _requestSuccess;

  AppUser? get user =>
      _user;

  bool get isBootstrapping =>
      _isBootstrapping;

  bool get isLoading =>
      _isLoading;

  bool get requestLoading =>
      _requestLoading;

  bool get isAuthenticated =>
      _user != null;

  bool get localTrustedSession =>
      _localTrustedSession;

  String? get errorMessage =>
      _errorMessage;

  String? get requestError =>
      _requestError;

  String? get requestSuccess =>
      _requestSuccess;

  Future<void> bootstrap() async {
    _isBootstrapping =
        true;

    notifyListeners();

    try {
      final localUser =
          await repository
              .loadTrustedLocalSession();

      if (localUser != null) {
        _user =
            localUser;

        _localTrustedSession =
            true;
      }
    } finally {
      _isBootstrapping =
          false;

      notifyListeners();
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading =
        true;

    _errorMessage =
        null;

    notifyListeners();

    try {
      _user =
          await repository.login(
        email:
            email,
        password:
            password,
      );

      _localTrustedSession =
          false;

      return true;
    } on AuthException catch (e) {
      _errorMessage =
          e.message;

      return false;
    } catch (_) {
      _errorMessage =
          'حدث خطأ غير متوقع.';

      return false;
    } finally {
      _isLoading =
          false;

      notifyListeners();
    }
  }

  Future<bool> requestAccount({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
  }) async {
    _requestLoading =
        true;

    _requestError =
        null;

    _requestSuccess =
        null;

    notifyListeners();

    try {
      _requestSuccess =
          await repository.requestAccount(
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

      return true;
    } on AuthException catch (e) {
      _requestError =
          e.message;

      return false;
    } catch (_) {
      _requestError =
          'حدث خطأ غير متوقع أثناء إرسال الطلب.';

      return false;
    } finally {
      _requestLoading =
          false;

      notifyListeners();
    }
  }

  void clearRequestFeedback() {
    _requestError =
        null;

    _requestSuccess =
        null;

    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading =
        true;

    notifyListeners();

    try {
      await repository.logout();

      _user =
          null;

      _localTrustedSession =
          false;

      _errorMessage =
          null;
    } finally {
      _isLoading =
          false;

      notifyListeners();
    }
  }
}
