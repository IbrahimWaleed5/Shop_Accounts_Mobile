import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';
import '../../models/audit_log_model.dart';
import '../../models/system_backup_model.dart';

class SystemAdminRemoteDataSource {
  final ApiClient apiClient;

  SystemAdminRemoteDataSource(
    this.apiClient,
  );

  Future<List<AuditLogModel>>
      auditLogs() async {
    final response =
        await apiClient.dio.get(
      '/manager/audit-logs',
      queryParameters: {
        'per_page': 100,
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final items =
        root['data'] as List<dynamic>? ??
            [];

    return items
        .map(
          (item) =>
              AuditLogModel.fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<List<SystemBackupModel>>
      backups() async {
    final response =
        await apiClient.dio.get(
      '/manager/backups',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final items =
        root['data'] as List<dynamic>? ??
            [];

    return items
        .map(
          (item) =>
              SystemBackupModel
                  .fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<SystemBackupModel>
      createBackup() async {
    final response =
        await apiClient.dio.post(
      '/manager/backups',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return SystemBackupModel.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }

  Future<Uint8List> downloadBackup(
    int id,
  ) async {
    final response =
        await apiClient.dio.get<List<int>>(
      '/manager/backups/$id/download',
      options: Options(
        responseType:
            ResponseType.bytes,
      ),
    );

    return Uint8List.fromList(
      response.data ??
          const <int>[],
    );
  }

  Future<String> restoreBackup(
    int id,
  ) async {
    final response =
        await apiClient.dio.post(
      '/manager/backups/$id/restore',
      data: {
        'confirmation':
            'RESTORE_BACKUP',
      },
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return root['message']
            ?.toString() ??
        'تمت الاستعادة.';
  }

  Future<void> deleteBackup(
    int id,
  ) async {
    await apiClient.dio.delete(
      '/manager/backups/$id',
    );
  }
}
