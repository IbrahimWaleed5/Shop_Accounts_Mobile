import 'party_opening_balance_model.dart';

class PartyModel {
  final int id;
  final String uuid;
  final String type;
  final String name;
  final String? phone;
  final String? address;
  final String? notes;
  final bool isActive;
  final int version;
  final DateTime? lastMovementAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<PartyOpeningBalanceModel>
      openingBalances;

  const PartyModel({
    required this.id,
    required this.uuid,
    required this.type,
    required this.name,
    required this.isActive,
    required this.version,
    required this.openingBalances,
    this.phone,
    this.address,
    this.notes,
    this.lastMovementAt,
    this.createdAt,
    this.updatedAt,
  });

  factory PartyModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final balances =
        json['opening_balances']
                as List<dynamic>? ??
            [];

    return PartyModel(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'].toString(),
      type: json['type'].toString(),
      name: json['name'].toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      notes: json['notes']?.toString(),
      isActive: json['is_active'] == true ||
          json['is_active'] == 1,
      version:
          (json['version'] as num).toInt(),
      lastMovementAt:
          json['last_movement_at'] == null
              ? null
              : DateTime.tryParse(
                  json['last_movement_at']
                      .toString(),
                ),
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
                PartyOpeningBalanceModel
                    .fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList(),
    );
  }

  bool get isCustomer =>
      type == 'customer' || type == 'both';

  bool get isSupplier =>
      type == 'supplier' || type == 'both';
}
