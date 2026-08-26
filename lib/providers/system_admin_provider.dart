import 'package:flutter/foundation.dart';

import '../models/audit_log_model.dart';
import '../models/system_backup_model.dart';
import '../repositories/system_admin_repository.dart';

class SystemAdminProvider
    extends ChangeNotifier {
  final SystemAdminRepository
      repository;

  SystemAdminProvider(
    this.repository,
  );

  List<AuditLogModel> _auditLogs =
      [];

  List<SystemBackupModel> _backups =
      [];

  bool _loadingAudit =
      false;

  bool _loadingBackups =
      false;

  bool _working =
      false;

  String? _error;

  List<AuditLogModel>
      get auditLogs =>
          List.unmodifiable(
            _auditLogs,
          );

  List<SystemBackupModel>
      get backups =>
          List.unmodifiable(
            _backups,
          );

  bool get loadingAudit =>
      _loadingAudit;

  bool get loadingBackups =>
      _loadingBackups;

  bool get working =>
      _working;

  String? get error =>
      _error;

  Future<void> loadAll() async {
    await Future.wait([
      loadAuditLogs(),
      loadBackups(),
    ]);
  }

  Future<void> loadAuditLogs() async {
    _loadingAudit = true;
    _error = null;
    notifyListeners();

    try {
      _auditLogs =
          await repository.safe(
        repository.auditLogs,
        fallback:
            'تعذر تحميل سجل النشاط.',
      );
    } on SystemAdminException catch (e) {
      _error = e.message;
    } finally {
      _loadingAudit = false;
      notifyListeners();
    }
  }

  Future<void> loadBackups() async {
    _loadingBackups = true;
    _error = null;
    notifyListeners();

    try {
      _backups =
          await repository.safe(
        repository.backups,
        fallback:
            'تعذر تحميل النسخ الاحتياطية.',
      );
    } on SystemAdminException catch (e) {
      _error = e.message;
    } finally {
      _loadingBackups = false;
      notifyListeners();
    }
  }

  Future<bool> createBackup() async {
    _working = true;
    _error = null;
    notifyListeners();

    try {
      await repository.safe(
        repository.createBackup,
        fallback:
            'تعذر إنشاء النسخة الاحتياطية.',
      );

      await loadBackups();
      await loadAuditLogs();

      return true;
    } on SystemAdminException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _working = false;
      notifyListeners();
    }
  }

  Future<Uint8List?> downloadBackup(
    int id,
  ) async {
    _working = true;
    _error = null;
    notifyListeners();

    try {
      return await repository.safe(
        () =>
            repository.downloadBackup(
          id,
        ),
        fallback:
            'تعذر تنزيل النسخة.',
      );
    } on SystemAdminException catch (e) {
      _error = e.message;
      return null;
    } finally {
      _working = false;
      notifyListeners();
    }
  }

  Future<String?> restoreBackup(
    int id,
  ) async {
    _working = true;
    _error = null;
    notifyListeners();

    try {
      final message =
          await repository.restoreBackup(
        id,
      );

      await loadBackups();
      await loadAuditLogs();

      return message;
    } on SystemAdminException catch (e) {
      _error = e.message;
      return null;
    } finally {
      _working = false;
      notifyListeners();
    }
  }

  Future<bool> deleteBackup(
    int id,
  ) async {
    _working = true;
    _error = null;
    notifyListeners();

    try {
      await repository.deleteBackup(
        id,
      );

      await loadBackups();
      await loadAuditLogs();

      return true;
    } on SystemAdminException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _working = false;
      notifyListeners();
    }
  }
}
