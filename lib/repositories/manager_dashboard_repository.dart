import 'package:dio/dio.dart';

import '../data/remote/manager_dashboard_remote_data_source.dart';
import '../models/manager_dashboard_model.dart';

class ManagerDashboardRepository {
  final ManagerDashboardRemoteDataSource
      remote;

  ManagerDashboardRepository({
    required this.remote,
  });

  Future<ManagerDashboardModel> load({
    required String preset,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      return await remote.load(
        preset: preset,
        startDate: startDate,
        endDate: endDate,
      );
    } on DioException catch (e) {
      final data =
          e.response?.data;

      if (data is Map) {
        final message =
            data['message'];

        if (
          message != null &&
          message.toString().isNotEmpty
        ) {
          throw ManagerDashboardException(
            message.toString(),
          );
        }
      }

      throw const ManagerDashboardException(
        'تعذر تحميل لوحة المدير. تأكد من اتصال Laravel ثم أعد المحاولة.',
      );
    }
  }
}

class ManagerDashboardException
    implements Exception {
  final String message;

  const ManagerDashboardException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
