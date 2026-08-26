import '../../core/network/api_client.dart';
import '../../models/report_model.dart';

class ReportRemoteDataSource {
  final ApiClient apiClient;

  ReportRemoteDataSource(this.apiClient);

  Future<ReportModel> generate({
    required String reportType,
    required DateTime from,
    required DateTime to,
    int? currencyId,
    int? partyId,
    int? workerId,
  }) async {
    String d(DateTime value) =>
        '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

    final queryParameters = <String, dynamic>{
      'report_type': reportType,
      'from': d(from),
      'to': d(to),
    };

    if (currencyId != null) {
      queryParameters['currency_id'] = currencyId;
    }

    if (partyId != null) {
      queryParameters['party_id'] = partyId;
    }

    if (workerId != null) {
      queryParameters['worker_id'] = workerId;
    }

    final response = await apiClient.dio.get(
      '/manager/reports',
      queryParameters: queryParameters,
    );

    final root = Map<String, dynamic>.from(
      response.data as Map,
    );

    return ReportModel.fromJson(
      Map<String, dynamic>.from(root['data'] as Map),
    );
  }
}
