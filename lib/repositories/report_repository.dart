import 'package:dio/dio.dart';

import '../data/remote/report_remote_data_source.dart';
import '../models/report_model.dart';

class ReportRepository {
  final ReportRemoteDataSource remote;

  ReportRepository({required this.remote});

  Future<ReportModel> generate({
    required String reportType,
    required DateTime from,
    required DateTime to,
    int? currencyId,
    int? partyId,
    int? workerId,
  }) async {
    try {
      return await remote.generate(
        reportType: reportType,
        from: from,
        to: to,
        currencyId: currencyId,
        partyId: partyId,
        workerId: workerId,
      );
    } on DioException catch (e) {
      final data = e.response?.data;

      if (data is Map) {
        final errors = data['errors'];

        if (errors is Map && errors.isNotEmpty) {
          final first = errors.values.first;

          if (first is List && first.isNotEmpty) {
            throw ReportException(first.first.toString());
          }
        }

        final message = data['message'];
        if (message != null && message.toString().isNotEmpty) {
          throw ReportException(message.toString());
        }
      }

      throw const ReportException(
        'تعذر تحميل التقرير. تأكد من اتصال Laravel.',
      );
    }
  }
}

class ReportException implements Exception {
  final String message;

  const ReportException(this.message);
}
