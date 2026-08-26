import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../core/network/api_client.dart';
import '../../models/attachment_model.dart';

class AttachmentRemoteDataSource {
  final ApiClient apiClient;

  AttachmentRemoteDataSource(
    this.apiClient,
  );

  Future<List<AttachmentModel>>
      getAttachments(
    int transactionId,
  ) async {
    final response =
        await apiClient.dio.get(
      '/transactions/$transactionId/attachments',
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final list =
        root['data'] as List<dynamic>? ?? [];

    return list
        .map(
          (item) =>
              AttachmentModel.fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<AttachmentModel> upload({
    required String uuid,
    required String transactionUuid,
    required String fileName,
    required String mimeType,
    required Uint8List bytes,
  }) async {
    final form = FormData.fromMap({
      'uuid': uuid,
      'transaction_uuid':
          transactionUuid,
      'file':
          MultipartFile.fromBytes(
        bytes,
        filename: fileName,
        contentType:
            DioMediaType.parse(
          mimeType,
        ),
      ),
    });

    final response =
        await apiClient.dio.post(
      '/attachments',
      data: form,
      options: Options(
        contentType:
            'multipart/form-data',
      ),
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    return AttachmentModel.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }

  Future<void> delete(
    int attachmentId,
  ) async {
    await apiClient.dio.delete(
      '/attachments/$attachmentId',
    );
  }
}
