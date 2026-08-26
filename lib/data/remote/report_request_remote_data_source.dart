import '../../core/network/api_client.dart';
import '../../models/report_request_model.dart';

class ReportRequestRemoteDataSource {
  final ApiClient apiClient;

  ReportRequestRemoteDataSource(
    this.apiClient,
  );

  Future<List<ReportRequestModel>> list({
    String? status,
  }) async {
    final response =
        await apiClient.dio.get(
      '/report-requests',
      queryParameters: {
        if (status != null)
          'status':
              status,
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return (root['data']
                as List<dynamic>? ??
            [])
        .map(
          (item) =>
              ReportRequestModel.fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<List<ReportRequestAccountantModel>>
      accountants() async {
    final response =
        await apiClient.dio.get(
      '/manager/report-request-accountants',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return (root['data']
                as List<dynamic>? ??
            [])
        .map(
          (item) =>
              ReportRequestAccountantModel
                  .fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<String> create({
    required int accountantId,
    required String reportType,
    String? managerNote,
  }) async {
    final response =
        await apiClient.dio.post(
      '/manager/report-requests',
      data: {
        'accountant_id':
            accountantId,
        'report_type':
            reportType,
        'manager_note':
            managerNote?.trim(),
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return root['message']
            ?.toString() ??
        'تم إرسال طلب التقرير.';
  }

  Future<String> submit({
    required int requestId,
    required DateTime from,
    required DateTime to,
    int? currencyId,
    String? accountantNote,
  }) async {
    String date(
      DateTime value,
    ) =>
        '${value.year}-'
        '${value.month.toString().padLeft(2, '0')}-'
        '${value.day.toString().padLeft(2, '0')}';

    final response =
        await apiClient.dio.post(
      '/accountant/report-requests/'
      '$requestId/submit',
      data: {
        'from':
            date(from),
        'to':
            date(to),
        'currency_id':
            currencyId,
        'accountant_note':
            accountantNote?.trim(),
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return root['message']
            ?.toString() ??
        'تم إرسال التقرير للمدير.';
  }
}
