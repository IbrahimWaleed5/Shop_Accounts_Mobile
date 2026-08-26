import 'package:dio/dio.dart';

import '../data/local/app_database.dart';
import '../data/remote/accounting_remote_data_source.dart';
import '../data/remote/product_remote_data_source.dart';
import '../data/remote/sync_remote_data_source.dart';
import '../models/accounting_transaction_model.dart';
import '../models/sync_operation_model.dart';

class SyncRepository {
  final AppDatabase database;
  final SyncRemoteDataSource remote;
  final AccountingRemoteDataSource
      accountingRemote;
  final ProductRemoteDataSource
      productRemote;

  SyncRepository({
    required this.database,
    required this.remote,
    required this.accountingRemote,
    required this.productRemote,
  });

  Future<int> pendingCount() =>
      database.pendingSyncCount();

  Future<int> failedCount() =>
      database.failedSyncCount();

  Future<SyncRunResult> sync({
    bool includeFailed = false,
  }) async {
    final operations =
        await database
            .readSyncOperations(
      includeFailed:
          includeFailed,
      limit: 50,
    );

    if (operations.isEmpty) {
      return const SyncRunResult(
        synced: 0,
        failed: 0,
        remaining: 0,
        networkAvailable: true,
      );
    }

    await database.markSyncing(
      operations,
    );

    List<Map<String, dynamic>>
        results;

    try {
      results =
          await remote.push(
        operations,
      );
    } on DioException catch (e) {
      for (final operation
          in operations) {
        await database.markSyncPending(
          operationUuid:
              operation.operationUuid,
          error:
              _networkMessage(e),
        );
      }

      return SyncRunResult.offline(
        remaining:
            await database
                .pendingSyncCount(),
      );
    }

    var synced = 0;
    var failed = 0;
    var purchaseSynced = false;

    final operationByUuid = {
      for (final item in operations)
        item.operationUuid: item,
    };

    for (final result in results) {
      final uuid =
          result['uuid']
              ?.toString();

      if (uuid == null) {
        continue;
      }

      final operation =
          operationByUuid[uuid];

      if (
        result['status'] ==
        'synced'
      ) {
        final rawTransaction =
            result['transaction'];

        if (
          rawTransaction is Map
        ) {
          final transaction =
              AccountingTransactionModel
                  .fromJson(
            Map<String, dynamic>.from(
              rawTransaction,
            ),
          );

          await database
              .upsertTransactions(
            [transaction],
          );
        }

        if (
          operation?.operationType ==
          'purchase'
        ) {
          purchaseSynced = true;
        }

        await database
            .removeSyncOperation(
          uuid,
        );

        synced++;
      } else {
        final error =
            result['error']
                    ?.toString() ??
                'فشلت مزامنة الحركة.';

        await database
            .markSyncFailed(
          operationUuid: uuid,
          error: error,
        );

        failed++;
      }
    }

    // If the server returned fewer result rows
    // than sent, keep unmatched rows pending.
    final returnedUuids =
        results
            .map(
              (item) =>
                  item['uuid']
                      ?.toString(),
            )
            .whereType<String>()
            .toSet();

    for (final operation
        in operations) {
      if (
        !returnedUuids.contains(
          operation.operationUuid,
        )
      ) {
        await database.markSyncPending(
          operationUuid:
              operation.operationUuid,
          error:
              'لم يؤكد الخادم نتيجة الحركة. ستتم إعادة المحاولة.',
        );
      }
    }

    // Refresh authoritative server cache after
    // successful writes. This also updates reversed
    // statuses and transactions entered on another device.
    if (synced > 0) {
      try {
        final transactions =
            await accountingRemote
                .getTransactions();

        await database
            .upsertTransactions(
          transactions,
        );
      } on DioException {
        // The pushed operations are already safe.
        // Cache refresh can happen later.
      }
    }

    if (purchaseSynced) {
      try {
        final products =
            await productRemote
                .getProducts();

        await database
            .upsertProducts(
          products,
        );
      } on DioException {
        // Product stock cache will refresh later.
      }
    }

    return SyncRunResult(
      synced: synced,
      failed: failed,
      remaining:
          await database
              .pendingSyncCount(),
      networkAvailable: true,
    );
  }

  String _networkMessage(
    DioException e,
  ) {
    return 'لا يوجد اتصال بالخادم الآن. الحركة محفوظة محليًا وستتم إعادة المحاولة تلقائيًا.';
  }
}
