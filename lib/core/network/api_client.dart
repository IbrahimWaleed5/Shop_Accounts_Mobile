import 'package:dio/dio.dart';

import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';

class ApiClient {
  final Dio dio;
  final SecureStorageService storage;

  ApiClient(
    this.storage,
  ) : dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.apiBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 20),
            sendTimeout: const Duration(seconds: 20),
            headers: {
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.readToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          final deviceUuid = await storage.getOrCreateDeviceUuid();

          options.headers['X-Device-UUID'] = deviceUuid;

          handler.next(options);
        },
      ),
    );
  }
}
