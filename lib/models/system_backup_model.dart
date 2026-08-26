class SystemBackupModel {
  final int id;
  final String uuid;
  final String fileName;
  final int sizeBytes;
  final String sha256;
  final String schemaHash;
  final int tablesCount;
  final int recordsCount;
  final int attachmentsCount;
  final String reason;
  final String? createdByName;
  final DateTime? restoredAt;
  final String? restoredByName;
  final DateTime createdAt;

  const SystemBackupModel({
    required this.id,
    required this.uuid,
    required this.fileName,
    required this.sizeBytes,
    required this.sha256,
    required this.schemaHash,
    required this.tablesCount,
    required this.recordsCount,
    required this.attachmentsCount,
    required this.reason,
    required this.createdAt,
    this.createdByName,
    this.restoredAt,
    this.restoredByName,
  });

  factory SystemBackupModel.fromJson(
    Map<String, dynamic> json,
  ) {
    int value(
      String key,
    ) =>
        (json[key] as num?)?.toInt()
        ?? 0;

    return SystemBackupModel(
      id:
          value('id'),
      uuid:
          json['uuid'].toString(),
      fileName:
          json['file_name'].toString(),
      sizeBytes:
          value('size_bytes'),
      sha256:
          json['sha256'].toString(),
      schemaHash:
          json['schema_hash']
              .toString(),
      tablesCount:
          value('tables_count'),
      recordsCount:
          value('records_count'),
      attachmentsCount:
          value(
        'attachments_count',
      ),
      reason:
          json['reason'].toString(),
      createdByName:
          json['created_by_name']
              ?.toString(),
      restoredAt:
          json['restored_at'] == null
              ? null
              : DateTime.parse(
                  json['restored_at']
                      .toString(),
                ),
      restoredByName:
          json['restored_by_name']
              ?.toString(),
      createdAt:
          DateTime.parse(
        json['created_at'].toString(),
      ),
    );
  }
}
