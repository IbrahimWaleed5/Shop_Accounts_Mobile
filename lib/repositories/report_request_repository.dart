import 'package:dio/dio.dart';

import '../data/remote/report_request_remote_data_source.dart';
import '../models/report_request_model.dart';

class ReportRequestRepository {
  final ReportRequestRemoteDataSource
      remote;

  ReportRequestRepository({
    required this.remote,
  });

  Future<List<ReportRequestModel>> list({
    String? status,
  }) async {
    try {
      return await remote.list(
        status:
            status,
      );
    } on DioException catch (e) {
      throw ReportRequestException(
        _message(
          e,
          'تعذر تحميل طلبات التقارير.',
        ),
      );
    }
  }

  Future<List<ReportRequestAccountantModel>>
      accountants() async {
    try {
      return await remote.accountants();
    } on DioException catch (e) {
      throw ReportRequestException(
        _message(
          e,
          'تعذر تحميل المحاسبين.',
        ),
      );
    }
  }

  Future<String> create({
    required int accountantId,
    required String reportType,
    String? managerNote,
  }) async {
    try {
      return await remote.create(
        accountantId:
            accountantId,
        reportType:
            reportType,
        managerNote:
            managerNote,
      );
    } on DioException catch (e) {
      throw ReportRequestException(
        _message(
          e,
          'تعذر إرسال طلب التقرير.',
        ),
      );
    }
  }

  Future<String> submit({
    required int requestId,
    required DateTime from,
    required DateTime to,
    int? currencyId,
    String? accountantNote,
  }) async {
    try {
      return await remote.submit(
        requestId:
            requestId,
        from:
            from,
        to:
            to,
        currencyId:
            currencyId,
        accountantNote:
            accountantNote,
      );
    } on DioException catch (e) {
      throw ReportRequestException(
        _message(
          e,
          'تعذر إرسال التقرير.',
        ),
      );
    }
  }

  String _message(
    DioException exception,
    String fallback,
  ) {
    final data =
        exception.response?.data;

    if (data is Map) {
      final errors =
          data['errors'];

      if (
        errors is Map &&
        errors.isNotEmpty
      ) {
        final first =
            errors.values.first;

        if (
          first is List &&
          first.isNotEmpty
        ) {
          return first.first
              .toString();
        }
      }

      final message =
          data['message'];

      if (
        message != null &&
        message.toString().isNotEmpty
      ) {
        return message.toString();
      }
    }

    return fallback;
  }
}

class ReportRequestException
    implements Exception {
  final String message;

  const ReportRequestException(
    this.message,
  );
}
