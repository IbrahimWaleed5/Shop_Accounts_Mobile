class AttachmentModel {
  final int? id;
  final String uuid;
  final int? transactionId;
  final String transactionUuid;
  final String originalName;
  final String mimeType;
  final int sizeBytes;
  final String? url;

  final String syncStatus;
  final String? lastError;

  const AttachmentModel({
    required this.uuid,
    required this.transactionUuid,
    required this.originalName,
    required this.mimeType,
    required this.sizeBytes,
    required this.syncStatus,
    this.id,
    this.transactionId,
    this.url,
    this.lastError,
  });

  factory AttachmentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AttachmentModel(
      id:
          (json['id'] as num?)?.toInt(),
      uuid:
          json['uuid'].toString(),
      transactionId:
          (json['transaction_id']
                  as num?)
              ?.toInt(),
      transactionUuid:
          json['transaction_uuid']
              .toString(),
      originalName:
          json['original_name']
              .toString(),
      mimeType:
          json['mime_type'].toString(),
      sizeBytes:
          (json['size_bytes'] as num)
              .toInt(),
      url:
          json['url']?.toString(),
      syncStatus:
          'synced',
    );
  }
}
