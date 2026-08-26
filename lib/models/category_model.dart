class CategoryModel {
  final int id;
  final String uuid;
  final String name;
  final String type;
  final String? notes;
  final bool isActive;
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.uuid,
    required this.name,
    required this.type,
    required this.isActive,
    this.notes,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return CategoryModel(
      id: json['id'] as int,
      uuid: json['uuid'].toString(),
      name: json['name'].toString(),
      type: json['type'].toString(),
      notes: json['notes']?.toString(),
      isActive: json['is_active'] == true ||
          json['is_active'] == 1,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.tryParse(
              json['updated_at'].toString(),
            ),
    );
  }
}
