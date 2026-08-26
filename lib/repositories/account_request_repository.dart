import 'package:dio/dio.dart';

import '../data/remote/account_request_remote_data_source.dart';
import '../models/account_request_model.dart';

class AccountRequestRepository {
  final AccountRequestRemoteDataSource
      remote;

  AccountRequestRepository({
    required this.remote,
  });

  Future<List<AccountRequestModel>> list({
    required String status,
  }) async {
    try {
      return await remote.list(
        status:
            status,
      );
    } on DioException catch (e) {
      throw AccountRequestException(
        _message(
          e,
          'تعذر تحميل طلبات الحسابات.',
        ),
      );
    }
  }

  Future<String> approve(
    int userId,
  ) async {
    try {
      return await remote.approve(
        userId,
      );
    } on DioException catch (e) {
      throw AccountRequestException(
        _message(
          e,
          'تعذر قبول الطلب.',
        ),
      );
    }
  }

  Future<String> reject(
    int userId, {
    String? reason,
  }) async {
    try {
      return await remote.reject(
        userId,
        reason:
            reason,
      );
    } on DioException catch (e) {
      throw AccountRequestException(
        _message(
          e,
          'تعذر رفض الطلب.',
        ),
      );
    }
  }

  String _message(
    DioException exception,
    String fallback,
  ) {
    final data =
        exception.response?.data;

    if (data is Map) {
      final message =
          data['message'];

      if (
        message != null &&
        message.toString().isNotEmpty
      ) {
        return message.toString();
      }

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
    }

    return fallback;
  }
}

class AccountRequestException
    implements Exception {
  final String message;

  const AccountRequestException(
    this.message,
  );

  @override
  String toString() =>
      message;
}
