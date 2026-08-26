import 'package:flutter/foundation.dart';

import '../models/attachment_model.dart';
import '../repositories/attachment_repository.dart';

class AttachmentProvider
    extends ChangeNotifier {
  final AttachmentRepository repository;

  AttachmentProvider(
    this.repository,
  );

  List<AttachmentModel> _items = [];
  bool _loading = false;
  bool _syncing = false;
  String? _error;

  List<AttachmentModel> get items =>
      List.unmodifiable(_items);

  bool get loading => _loading;
  bool get syncing => _syncing;
  String? get error => _error;

  Future<void> load({
    required int transactionId,
    required String transactionUuid,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _items =
          await repository.load(
        transactionId:
            transactionId,
        transactionUuid:
            transactionUuid,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> add({
    required int transactionId,
    required String transactionUuid,
    required String fileName,
    required String mimeType,
    required Uint8List bytes,
  }) async {
    _error = null;

    try {
      await repository.addLocal(
        transactionUuid:
            transactionUuid,
        fileName:
            fileName,
        mimeType:
            mimeType,
        bytes:
            bytes,
      );

      await load(
        transactionId:
            transactionId,
        transactionUuid:
            transactionUuid,
      );

      return true;
    } catch (e) {
      _error =
          'تعذر حفظ المرفق محليًا.';
      notifyListeners();
      return false;
    }
  }

  Future<int> sync({
    required int transactionId,
    required String transactionUuid,
  }) async {
    _syncing = true;
    _error = null;
    notifyListeners();

    try {
      final count =
          await repository
              .syncPending();

      await load(
        transactionId:
            transactionId,
        transactionUuid:
            transactionUuid,
      );

      return count;
    } finally {
      _syncing = false;
      notifyListeners();
    }
  }

  Future<bool> deleteRemote({
    required int attachmentId,
    required int transactionId,
    required String transactionUuid,
  }) async {
    try {
      await repository
          .deleteRemote(
        attachmentId,
      );

      await load(
        transactionId:
            transactionId,
        transactionUuid:
            transactionUuid,
      );

      return true;
    } catch (_) {
      _error =
          'تعذر حذف المرفق.';
      notifyListeners();
      return false;
    }
  }
}
