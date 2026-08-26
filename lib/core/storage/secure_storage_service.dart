import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class SecureStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _deviceUuidKey = 'device_uuid';

  final FlutterSecureStorage _storage;
  final Uuid _uuid;

  SecureStorageService({
    FlutterSecureStorage? storage,
    Uuid? uuid,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _uuid = uuid ?? const Uuid();

  Future<String?> readToken() {
    return _storage.read(key: _tokenKey);
  }

  Future<void> saveToken(String token) {
    return _storage.write(
      key: _tokenKey,
      value: token,
    );
  }

  Future<void> clearToken() {
    return _storage.delete(key: _tokenKey);
  }

  Future<String> getOrCreateDeviceUuid() async {
    final existing = await _storage.read(
      key: _deviceUuidKey,
    );

    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final uuid = _uuid.v4();

    await _storage.write(
      key: _deviceUuidKey,
      value: uuid,
    );

    return uuid;
  }
}
