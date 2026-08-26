class AuditLogModel {
  final int id;
  final String action;
  final String method;
  final String route;
  final String? entityType;
  final String? entityId;

  final Map<String, dynamic>?
      beforeValues;

  final Map<String, dynamic>?
      afterValues;

  final Map<String, dynamic>?
      requestData;

  final int? responseStatus;
  final String? deviceUuid;

  final String? userName;
  final String? userEmail;
  final String? userRole;

  final DateTime createdAt;

  const AuditLogModel({
    required this.id,
    required this.action,
    required this.method,
    required this.route,
    required this.createdAt,
    this.entityType,
    this.entityId,
    this.beforeValues,
    this.afterValues,
    this.requestData,
    this.responseStatus,
    this.deviceUuid,
    this.userName,
    this.userEmail,
    this.userRole,
  });

  factory AuditLogModel.fromJson(
    Map<String, dynamic> json,
  ) {
    Map<String, dynamic>? map(
      String key,
    ) {
      final value =
          json[key];

      if (value is! Map) {
        return null;
      }

      return Map<String, dynamic>.from(
        value,
      );
    }

    return AuditLogModel(
      id:
          (json['id'] as num).toInt(),
      action:
          json['action'].toString(),
      method:
          json['method'].toString(),
      route:
          json['route'].toString(),
      entityType:
          json['entity_type']
              ?.toString(),
      entityId:
          json['entity_id']
              ?.toString(),
      beforeValues:
          map('before_values'),
      afterValues:
          map('after_values'),
      requestData:
          map('request_data'),
      responseStatus:
          (json['response_status']
                  as num?)
              ?.toInt(),
      deviceUuid:
          json['device_uuid']
              ?.toString(),
      userName:
          json['user_name']
              ?.toString(),
      userEmail:
          json['user_email']
              ?.toString(),
      userRole:
          json['user_role']
              ?.toString(),
      createdAt:
          DateTime.parse(
        json['created_at'].toString(),
      ),
    );
  }
}
