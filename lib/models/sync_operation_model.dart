import 'dart:convert';

class SyncOperationModel {
  final int localId;
  final String operationUuid;
  final String operationType;
  final String payloadJson;
  final String status;
  final int attempts;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SyncOperationModel({
    required this.localId,
    required this.operationUuid,
    required this.operationType,
    required this.payloadJson,
    required this.status,
    required this.attempts,
    required this.createdAt,
    required this.updatedAt,
    this.lastError,
  });

  Map<String, dynamic> get payload {
    final value =
        jsonDecode(payloadJson);

    return Map<String, dynamic>.from(
      value as Map,
    );
  }

  Map<String, dynamic>
      toPushJson() {
    return {
      'uuid': operationUuid,
      'operation_type':
          operationType,
      'payload': payload,
    };
  }
}

class SyncRunResult {
  final int synced;
  final int failed;
  final int remaining;
  final bool networkAvailable;

  const SyncRunResult({
    required this.synced,
    required this.failed,
    required this.remaining,
    required this.networkAvailable,
  });

  const SyncRunResult.offline({
    required this.remaining,
  })  : synced = 0,
        failed = 0,
        networkAvailable = false;
}
