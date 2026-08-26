class AppConfig {
  AppConfig._();

  static const String appName =
      'نظام حسابات الدكان';

  static const String appVersion =
      '1.0.0';

  static const String releaseLabel =
      'v1.0';

  static const String apiBaseUrl =
      String.fromEnvironment(
    'API_BASE_URL',
    defaultValue:
        'http://10.0.2.2:8000/api',
  );
}
