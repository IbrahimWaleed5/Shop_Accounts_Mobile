import 'package:dio/dio.dart';

import '../data/local/app_database.dart';
import '../data/remote/accounting_remote_data_source.dart';
import '../data/remote/product_remote_data_source.dart';
import '../data/remote/sync_remote_data_source.dart';
import '../models/accounting_transaction_model.dart';
import '../models/category_model.dart';
import '../models/financial_account_model.dart';
import '../models/party_model.dart';
import '../models/product_model.dart';
import '../models/sync_operation_model.dart';
import '../models/worker_model.dart';

class SyncRepository {
  final AppDatabase database;
  final SyncRemoteDataSource remote;
  final AccountingRemoteDataSource accountingRemote;
  final ProductRemoteDataSource productRemote;

  SyncRepository({
    required this.database,
    required this.remote,
    required this.accountingRemote,
    required this.productRemote,
  });

  Future<int> pendingCount() => database.pendingSyncCount();
  Future<int> failedCount() => database.failedSyncCount();

  Future<SyncRunResult> sync({
    bool includeFailed = false,
  }) async {
    var synced = 0;
    var failed = 0;
    var transactionSynced = false;
    var productChanged = false;
    final processed = <String>{};

    while (processed.length < 50) {
      final candidates = await database.readSyncOperations(
        includeFailed: includeFailed,
        limit: 100,
      );

      SyncOperationModel? operation;
      for (final item in candidates) {
        if (!processed.contains(item.operationUuid)) {
          operation = item;
          break;
        }
      }

      if (operation == null) break;
      processed.add(operation.operationUuid);

      await database.markSyncing([operation]);

      List<Map<String, dynamic>> results;
      try {
        results = await remote.push([operation]);
      } on DioException catch (e) {
        await database.markSyncPending(
          operationUuid: operation.operationUuid,
          error: _networkMessage(e),
        );

        return SyncRunResult.offline(
          remaining: await database.pendingSyncCount(),
        );
      }

      Map<String, dynamic>? result;
      for (final item in results) {
        if (item['uuid']?.toString() == operation.operationUuid) {
          result = item;
          break;
        }
      }

      if (result == null) {
        await database.markSyncPending(
          operationUuid: operation.operationUuid,
          error: 'لم يؤكد الخادم نتيجة العملية. ستتم إعادة المحاولة.',
        );
        continue;
      }

      if (result['status'] == 'synced') {
        await _applySyncedResult(operation, result);

        if (operation.operationType == 'transaction_reverse' ||
            operation.operationType == 'transaction_correct') {
          final transactionId =
              (operation.payload['transaction_id'] as num?)?.toInt();
          if (transactionId != null) {
            await database.markTransactionReversed(transactionId);
          }
        }

        await database.removeSyncOperation(operation.operationUuid);
        synced++;

        if (_transactionOperation(operation.operationType)) {
          transactionSynced = true;
        }
        if (_productAffectingOperation(operation.operationType)) {
          productChanged = true;
        }
      } else {
        final error = result['error']?.toString() ?? 'فشلت مزامنة العملية.';
        await database.markSyncFailed(
          operationUuid: operation.operationUuid,
          error: error,
        );

        if (operation.operationType == 'purchase' ||
            operation.operationType == 'product_sale') {
          await database.applyLocalInventoryDelta(
            operationType: operation.operationType,
            payload: operation.payload,
            direction: -1,
          );
        }

        if (operation.operationType == 'transaction_reverse' ||
            operation.operationType == 'transaction_correct') {
          final transactionId =
              (operation.payload['transaction_id'] as num?)?.toInt();
          if (transactionId != null) {
            await database.restoreTransactionPosted(transactionId);
          }
        }

        failed++;
      }
    }

    if (transactionSynced) {
      try {
        final transactions = await accountingRemote.getTransactions();
        await database.upsertTransactions(transactions);
      } on DioException {
        // The server write is already committed. Cache refresh can retry later.
      }
    }

    if (productChanged) {
      try {
        final products = await productRemote.getProducts();
        await database.upsertProducts(products);

        for (final product in products) {
          await database.reapplyPendingInventoryForProduct(
            product.id,
          );
        }
      } on DioException {
        // Keep local cache until the next refresh.
      }
    }

    return SyncRunResult(
      synced: synced,
      failed: failed,
      remaining: await database.pendingSyncCount(),
      networkAvailable: true,
    );
  }

  Future<void> _applySyncedResult(
    SyncOperationModel operation,
    Map<String, dynamic> result,
  ) async {
    final rawTransaction = result['transaction'];
    if (rawTransaction is Map) {
      final transaction = AccountingTransactionModel.fromJson(
        Map<String, dynamic>.from(rawTransaction),
      );
      await database.upsertTransactions([transaction]);
    }

    final entityType = result['entity_type']?.toString();
    final rawEntity = result['entity'];
    if (entityType == null || rawEntity is! Map) return;

    final entity = Map<String, dynamic>.from(rawEntity);
    final tempId = (result['temp_id'] as num?)?.toInt() ??
        (operation.payload['_temp_id'] as num?)?.toInt();

    if (tempId != null && tempId < 0) {
      await database.deleteTemporaryEntity(
        entityType: entityType,
        tempId: tempId,
      );
    }

    switch (entityType) {
      case 'party':
        await database.upsertParties([PartyModel.fromJson(entity)]);
        break;
      case 'worker':
        await database.upsertWorkers([WorkerModel.fromJson(entity)]);
        break;
      case 'product':
        await database.upsertProducts([ProductModel.fromJson(entity)]);
        break;
      case 'financial_account':
        await database.upsertFinancialAccount(
          FinancialAccountModel.fromJson(entity),
        );
        break;
      case 'category':
        await database.upsertCategory(CategoryModel.fromJson(entity));
        break;
    }

    if (tempId != null && tempId < 0) {
      final newId = (entity['id'] as num?)?.toInt();
      if (newId != null) {
        await database.remapQueuedReferences(
          entityType: entityType,
          oldId: tempId,
          newId: newId,
        );

        if (entityType == 'product') {
          await database.reapplyPendingInventoryForProduct(newId);
        }
      }
    }
  }

  bool _transactionOperation(String type) => const {
        'accounting_transaction',
        'simple_sale',
        'purchase',
        'product_sale',
        'transaction_correct',
        'transaction_reverse',
      }.contains(type);

  bool _productAffectingOperation(String type) => const {
        'purchase',
        'product_sale',
        'product_create',
        'product_update',
        'product_status',
      }.contains(type);

  String _networkMessage(DioException e) {
    return 'لا يوجد اتصال بالخادم الآن. كل البيانات محفوظة محليًا وستتم مزامنتها تلقائيًا عند رجوع الإنترنت.';
  }
}
