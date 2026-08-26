import 'package:flutter/foundation.dart';

import '../models/sync_operation_model.dart';
import '../repositories/sync_repository.dart';

class SyncProvider
    extends ChangeNotifier {
  final SyncRepository repository;

  SyncProvider(
    this.repository,
  );

  bool _syncing = false;
  int _pending = 0;
  int _failed = 0;
  String? _lastMessage;

  bool get syncing =>
      _syncing;

  int get pending =>
      _pending;

  int get failed =>
      _failed;

  int get attentionCount =>
      _pending + _failed;

  String? get lastMessage =>
      _lastMessage;

  Future<void> refreshCounts() async {
    _pending =
        await repository
            .pendingCount();

    _failed =
        await repository
            .failedCount();

    notifyListeners();
  }

  Future<SyncRunResult> syncNow({
    bool includeFailed = false,
    bool silent = false,
  }) async {
    if (_syncing) {
      return SyncRunResult(
        synced: 0,
        failed: 0,
        remaining: _pending,
        networkAvailable: true,
      );
    }

    _syncing = true;

    if (!silent) {
      _lastMessage = null;
    }

    notifyListeners();

    try {
      final result =
          await repository.sync(
        includeFailed:
            includeFailed,
      );

      _pending =
          await repository
              .pendingCount();

      _failed =
          await repository
              .failedCount();

      if (!silent) {
        if (
          !result.networkAvailable
        ) {
          _lastMessage =
              'لا يوجد اتصال حاليًا. الحركات محفوظة على الجهاز.';
        } else if (
          result.failed > 0
        ) {
          _lastMessage =
              'تمت مزامنة ${result.synced} حركة، وتعذر ترحيل ${result.failed} حركة.';
        } else if (
          result.synced > 0
        ) {
          _lastMessage =
              'تمت مزامنة ${result.synced} حركة بنجاح.';
        } else {
          _lastMessage =
              'لا توجد حركات جديدة للمزامنة.';
        }
      }

      return result;
    } finally {
      _syncing = false;
      notifyListeners();
    }
  }
}
