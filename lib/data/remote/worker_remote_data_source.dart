import '../../core/network/api_client.dart';
import '../../models/worker_model.dart';
import '../../models/worker_opening_balance_model.dart';

class WorkerRemoteDataSource {
  final ApiClient apiClient;

  WorkerRemoteDataSource(
    this.apiClient,
  );

  Future<List<WorkerModel>> getWorkers({
    String? search,
  }) async {
    final response =
        await apiClient.dio.get(
      '/workers',
      queryParameters: {
        if (search != null &&
            search.trim().isNotEmpty)
          'q': search.trim(),
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final list =
        root['data'] as List<dynamic>;

    return list
        .map(
          (item) =>
              WorkerModel.fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<WorkerModel> createWorker({
    required String name,
    String? phone,
    String? jobTitle,
    required String wageType,
    int? wageCurrencyId,
    int? wageAmountMinor,
    DateTime? hireDate,
    String? notes,
    required List<
            WorkerOpeningBalanceModel>
        openingBalances,
  }) async {
    final response =
        await apiClient.dio.post(
      '/workers',
      data: _payload(
        name: name,
        phone: phone,
        jobTitle: jobTitle,
        wageType: wageType,
        wageCurrencyId:
            wageCurrencyId,
        wageAmountMinor:
            wageAmountMinor,
        hireDate: hireDate,
        notes: notes,
        openingBalances:
            openingBalances,
      ),
    );

    return _fromResponse(
      response.data,
    );
  }

  Future<WorkerModel> updateWorker({
    required int workerId,
    required String name,
    String? phone,
    String? jobTitle,
    required String wageType,
    int? wageCurrencyId,
    int? wageAmountMinor,
    DateTime? hireDate,
    String? notes,
    required List<
            WorkerOpeningBalanceModel>
        openingBalances,
  }) async {
    final response =
        await apiClient.dio.put(
      '/workers/$workerId',
      data: _payload(
        name: name,
        phone: phone,
        jobTitle: jobTitle,
        wageType: wageType,
        wageCurrencyId:
            wageCurrencyId,
        wageAmountMinor:
            wageAmountMinor,
        hireDate: hireDate,
        notes: notes,
        openingBalances:
            openingBalances,
      ),
    );

    return _fromResponse(
      response.data,
    );
  }

  Future<WorkerModel> setStatus({
    required int workerId,
    required bool isActive,
  }) async {
    final response =
        await apiClient.dio.patch(
      '/workers/$workerId/status',
      data: {
        'is_active': isActive,
      },
    );

    return _fromResponse(
      response.data,
    );
  }

  Map<String, dynamic> _payload({
    required String name,
    String? phone,
    String? jobTitle,
    required String wageType,
    int? wageCurrencyId,
    int? wageAmountMinor,
    DateTime? hireDate,
    String? notes,
    required List<
            WorkerOpeningBalanceModel>
        openingBalances,
  }) {
    return {
      'name': name.trim(),
      'phone': _nullableText(phone),
      'job_title':
          _nullableText(jobTitle),
      'wage_type': wageType,
      'wage_currency_id':
          wageCurrencyId,
      'wage_amount_minor':
          wageAmountMinor,
      'hire_date': hireDate == null
          ? null
          : _dateOnly(hireDate),
      'notes':
          _nullableText(notes),
      'opening_balances':
          openingBalances
              .map(
                (item) =>
                    item.toRequestJson(),
              )
              .toList(),
    };
  }

  WorkerModel _fromResponse(
    dynamic responseData,
  ) {
    final root =
        Map<String, dynamic>.from(
      responseData as Map,
    );

    return WorkerModel.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }

  String _dateOnly(
    DateTime value,
  ) {
    final year =
        value.year.toString().padLeft(4, '0');

    final month =
        value.month.toString().padLeft(2, '0');

    final day =
        value.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  String? _nullableText(
    String? value,
  ) {
    final text =
        value?.trim() ?? '';

    return text.isEmpty
        ? null
        : text;
  }
}
