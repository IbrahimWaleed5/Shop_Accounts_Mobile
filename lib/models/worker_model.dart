import 'worker_opening_balance_model.dart';

class WorkerModel {
  final int id;
  final String uuid;
  final String name;
  final String? phone;
  final String? jobTitle;

  final String wageType;
  final int? wageCurrencyId;
  final String? wageCurrencyCode;
  final String? wageCurrencySymbol;
  final int? wageCurrencyDecimalPlaces;
  final int? wageAmountMinor;

  final DateTime? hireDate;
  final String? notes;

  final bool isActive;
  final int version;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final List<WorkerOpeningBalanceModel>
      openingBalances;

  const WorkerModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.wageType,
    required this.isActive,
    required this.version,
    required this.openingBalances,
    this.phone,
    this.jobTitle,
    this.wageCurrencyId,
    this.wageCurrencyCode,
    this.wageCurrencySymbol,
    this.wageCurrencyDecimalPlaces,
    this.wageAmountMinor,
    this.hireDate,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkerModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final balances =
        json['opening_balances']
                as List<dynamic>? ??
            [];

    return WorkerModel(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'].toString(),
      name: json['name'].toString(),
      phone: json['phone']?.toString(),
      jobTitle:
          json['job_title']?.toString(),
      wageType:
          json['wage_type'].toString(),
      wageCurrencyId:
          (json['wage_currency_id'] as num?)
              ?.toInt(),
      wageCurrencyCode:
          json['wage_currency_code']?.toString(),
      wageCurrencySymbol:
          json['wage_currency_symbol']?.toString(),
      wageCurrencyDecimalPlaces:
          (json['wage_currency_decimal_places']
                  as num?)
              ?.toInt(),
      wageAmountMinor:
          (json['wage_amount_minor'] as num?)
              ?.toInt(),
      hireDate: json['hire_date'] == null
          ? null
          : DateTime.tryParse(
              json['hire_date'].toString(),
            ),
      notes: json['notes']?.toString(),
      isActive: json['is_active'] == true ||
          json['is_active'] == 1,
      version:
          (json['version'] as num).toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.tryParse(
              json['created_at'].toString(),
            ),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.tryParse(
              json['updated_at'].toString(),
            ),
      openingBalances: balances
          .map(
            (item) =>
                WorkerOpeningBalanceModel
                    .fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList(),
    );
  }
}
