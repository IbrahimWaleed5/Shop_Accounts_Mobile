import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../data/remote/system_admin_remote_data_source.dart';
import '../models/audit_log_model.dart';
import '../models/system_backup_model.dart';

class SystemAdminRepository {
  final SystemAdminRemoteDataSource
      remote;

  SystemAdminRepository({
    required this.remote,
  });

  Future<List<AuditLogModel>>
      auditLogs() =>
          remote.auditLogs();

  Future<List<SystemBackupModel>>
      backups() =>
          remote.backups();

  Future<SystemBackupModel>
      createBackup() =>
          remote.createBackup();

  Future<Uint8List> downloadBackup(
    int id,
  ) =>
      remote.downloadBackup(
        id,
      );

  Future<String> restoreBackup(
    int id,
  ) async {
    try {
      return await remote.restoreBackup(
        id,
      );
    } on DioException catch (e) {
      throw SystemAdminException(
        _message(
          e,
          fallback:
              'تعذر استعادة النسخة.',
        ),
      );
    }
  }

  Future<void> deleteBackup(
    int id,
  ) async {
    try {
      await remote.deleteBackup(
        id,
      );
    } on DioException catch (e) {
      throw SystemAdminException(
        _message(
          e,
          fallback:
              'تعذر حذف النسخة.',
        ),
      );
    }
  }

  Future<T> safe<T>(
    Future<T> Function() action, {
    required String fallback,
  }) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw SystemAdminException(
        _message(
          e,
          fallback:
              fallback,
        ),
      );
    }
  }

  String _message(
    DioException e, {
    required String fallback,
  }) {
    final data =
        e.response?.data;

    if (data is Map) {
      final errors =
          data['errors'];

      if (
        errors is Map &&
        errors.isNotEmpty
      ) {
        final first =
            errors.values.first;

        if (
          first is List &&
          first.isNotEmpty
        ) {
          return first.first
              .toString();
        }
      }

      final error =
          data['error'];

      if (
        error != null &&
        error.toString().isNotEmpty
      ) {
        return error.toString();
      }

      final message =
          data['message'];

      if (
        message != null &&
        message.toString().isNotEmpty
      ) {
        return message.toString();
      }
    }

    return fallback;
  }
}

class SystemAdminException
    implements Exception {
  final String message;

  const SystemAdminException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
