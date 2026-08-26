import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../core/utils/uuid_utils.dart';
import '../data/local/app_database.dart';
import '../data/remote/attachment_remote_data_source.dart';
import '../models/attachment_model.dart';

class AttachmentRepository {
  final AppDatabase database;
  final AttachmentRemoteDataSource remote;

  AttachmentRepository({
    required this.database,
    required this.remote,
  });

  Future<List<AttachmentModel>> load({
    required int transactionId,
    required String transactionUuid,
  }) async {
    try {
      final remoteItems =
          transactionId > 0
              ? await remote.getAttachments(
                  transactionId,
                )
              : <AttachmentModel>[];

      final localItems =
          await database
              .readLocalAttachments(
        transactionUuid,
      );

      return [
        ...localItems,
        ...remoteItems.where(
          (remoteItem) =>
              !localItems.any(
            (localItem) =>
                localItem.uuid ==
                remoteItem.uuid,
          ),
        ),
      ];
    } on DioException {
      return database
          .readLocalAttachments(
        transactionUuid,
      );
    }
  }

  Future<String> addLocal({
    required String transactionUuid,
    required String fileName,
    required String mimeType,
    required Uint8List bytes,
  }) async {
    final uuid =
        UuidUtils.v4();

    await database.enqueueAttachment(
      uuid: uuid,
      transactionUuid:
          transactionUuid,
      originalName:
          fileName,
      mimeType:
          mimeType,
      bytes:
          bytes,
    );

    return uuid;
  }

  Future<int> syncPending() async {
    final rows =
        await database
            .pendingAttachments();

    var synced = 0;

    for (final row in rows) {
      try {
        final bytes =
            base64Decode(
          row.bytesBase64,
        );

        await remote.upload(
          uuid: row.uuid,
          transactionUuid:
              row.transactionUuid,
          fileName:
              row.originalName,
          mimeType:
              row.mimeType,
          bytes:
              Uint8List.fromList(
            bytes,
          ),
        );

        await database
            .removeAttachmentQueue(
          row.uuid,
        );

        synced++;
      } on DioException catch (e) {
        final message =
            _message(e);

        await database
            .markAttachmentFailed(
          uuid: row.uuid,
          error: message,
        );
      }
    }

    return synced;
  }

  Future<int> pendingCount() =>
      database
          .pendingAttachmentCount();

  Future<void> deleteRemote(
    int attachmentId,
  ) =>
      remote.delete(
        attachmentId,
      );

  String _message(
    DioException e,
  ) {
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
          return first.first.toString();
        }
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

    return 'تعذر رفع المرفق الآن.';
  }
}
