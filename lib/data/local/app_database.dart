import 'package:drift/drift.dart';
import 'dart:convert';

import 'package:drift_flutter/drift_flutter.dart';

import '../../models/category_model.dart';
import '../../models/currency_model.dart';
import '../../models/financial_account_model.dart';
import '../../models/party_model.dart';
import '../../models/party_opening_balance_model.dart';
import '../../models/reference_data_model.dart';
import '../../models/worker_model.dart';
import '../../models/worker_opening_balance_model.dart';
import '../../models/accounting_transaction_model.dart';
import '../../models/product_model.dart';
import '../../models/transaction_item_model.dart';
import '../../models/sync_operation_model.dart';
import '../../models/attachment_model.dart';

part 'app_database.g.dart';

class LocalUsers extends Table {
  IntColumn get serverId => integer()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get role => text()();
  TextColumn get status => text()();
  TextColumn get deviceUuid => text()();

  BoolColumn get isTrusted => boolean().withDefault(
        const Constant(false),
      )();

  DateTimeColumn get lastOnlineLoginAt =>
      dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}

class LocalCurrencies extends Table {
  IntColumn get serverId => integer()();
  TextColumn get uuid => text()();
  TextColumn get code => text()();
  TextColumn get nameAr => text()();
  TextColumn get symbol => text()();
  IntColumn get decimalPlaces => integer()();
  BoolColumn get isActive => boolean()();

  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}

class LocalFinancialAccounts extends Table {
  IntColumn get serverId => integer()();
  TextColumn get uuid => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get currencyServerId => integer()();
  TextColumn get currencyCode => text()();
  TextColumn get currencySymbol => text()();

  IntColumn get currencyDecimalPlaces =>
      integer()();

  IntColumn get openingBalanceMinor =>
      integer()();

  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean()();

  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}

class LocalCategories extends Table {
  IntColumn get serverId => integer()();
  TextColumn get uuid => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean()();

  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}

class LocalParties extends Table {
  IntColumn get serverId => integer()();
  TextColumn get uuid => text()();
  TextColumn get type => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean()();
  IntColumn get version => integer()();

  DateTimeColumn get lastMovementAt =>
      dateTime().nullable()();

  DateTimeColumn get createdAt =>
      dateTime().nullable()();

  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}

class LocalPartyOpeningBalances extends Table {
  IntColumn get serverId => integer().nullable()();

  IntColumn get partyServerId => integer()();
  IntColumn get currencyServerId => integer()();

  TextColumn get currencyCode => text()();

  TextColumn get currencyNameAr => text()();

  TextColumn get currencySymbol => text()();

  IntColumn get currencyDecimalPlaces =>
      integer()();

  TextColumn get balanceSide => text()();

  IntColumn get amountMinor => integer()();

  @override
  Set<Column<Object>> get primaryKey => {
        partyServerId,
        currencyServerId,
        balanceSide,
      };
}


class LocalWorkers extends Table {
  IntColumn get serverId => integer()();
  TextColumn get uuid => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get jobTitle => text().nullable()();
  TextColumn get wageType => text()();

  IntColumn get wageCurrencyServerId =>
      integer().nullable()();

  TextColumn get wageCurrencyCode =>
      text().nullable()();

  TextColumn get wageCurrencySymbol =>
      text().nullable()();

  IntColumn get wageCurrencyDecimalPlaces =>
      integer().nullable()();

  IntColumn get wageAmountMinor =>
      integer().nullable()();

  DateTimeColumn get hireDate =>
      dateTime().nullable()();

  TextColumn get notes =>
      text().nullable()();

  BoolColumn get isActive => boolean()();
  IntColumn get version => integer()();

  DateTimeColumn get createdAt =>
      dateTime().nullable()();

  DateTimeColumn get updatedAt =>
      dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}

class LocalWorkerOpeningBalances
    extends Table {
  IntColumn get serverId =>
      integer().nullable()();

  IntColumn get workerServerId =>
      integer()();

  IntColumn get currencyServerId =>
      integer()();

  TextColumn get currencyCode =>
      text()();

  TextColumn get currencyNameAr =>
      text()();

  TextColumn get currencySymbol =>
      text()();

  IntColumn get currencyDecimalPlaces =>
      integer()();

  TextColumn get balanceSide =>
      text()();

  IntColumn get amountMinor =>
      integer()();

  @override
  Set<Column<Object>> get primaryKey => {
        workerServerId,
        currencyServerId,
        balanceSide,
      };
}


class LocalAccountingTransactions extends Table {
  IntColumn get serverId => integer()();
  TextColumn get uuid => text()();
  TextColumn get transactionNo => text()();
  TextColumn get type => text()();
  TextColumn get settlementMode => text()();

  IntColumn get currencyServerId => integer()();
  TextColumn get currencyCode => text()();
  TextColumn get currencySymbol => text()();
  IntColumn get currencyDecimalPlaces => integer()();

  IntColumn get amountMinor => integer()();
  IntColumn get paidNowMinor => integer()();

  TextColumn get costStatus => text().withDefault(
        const Constant('not_applicable'),
      )();

  IntColumn get costTotalMinor =>
      integer().nullable()();

  IntColumn get grossProfitMinor =>
      integer().nullable()();

  IntColumn get partyServerId => integer().nullable()();
  TextColumn get partyName => text().nullable()();

  IntColumn get workerServerId => integer().nullable()();
  TextColumn get workerName => text().nullable()();

  IntColumn get categoryServerId => integer().nullable()();
  TextColumn get categoryName => text().nullable()();

  IntColumn get financialAccountServerId =>
      integer().nullable()();

  TextColumn get financialAccountName =>
      text().nullable()();

  IntColumn get targetFinancialAccountServerId =>
      integer().nullable()();

  TextColumn get targetFinancialAccountName =>
      text().nullable()();

  DateTimeColumn get occurredAt => dateTime()();

  TextColumn get description => text().nullable()();
  TextColumn get notes => text().nullable()();

  TextColumn get status => text()();

  IntColumn get reversalOfServerId =>
      integer().nullable()();

  TextColumn get createdByName =>
      text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}


class LocalProducts extends Table {
  IntColumn get serverId => integer()();
  TextColumn get uuid => text()();
  TextColumn get sku => text().nullable()();
  TextColumn get name => text()();
  TextColumn get productType => text()();
  TextColumn get unit => text()();

  IntColumn get currencyServerId => integer()();
  TextColumn get currencyCode => text()();
  TextColumn get currencyNameAr => text()();
  TextColumn get currencySymbol => text()();
  IntColumn get currencyDecimalPlaces => integer()();

  IntColumn get defaultSalePriceMinor =>
      integer().nullable()();

  IntColumn get stockQuantityMilli => integer()();

  IntColumn get averageCostMinor =>
      integer().nullable()();

  BoolColumn get isActive => boolean()();
  IntColumn get version => integer()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}

class LocalTransactionItems extends Table {
  IntColumn get serverId => integer()();
  IntColumn get transactionServerId => integer()();

  IntColumn get productServerId =>
      integer().nullable()();

  TextColumn get productName =>
      text().nullable()();

  TextColumn get productSku =>
      text().nullable()();

  TextColumn get description => text()();

  IntColumn get quantityMilli => integer()();
  TextColumn get unit => text()();

  IntColumn get unitPriceMinor => integer()();

  IntColumn get unitCostMinor =>
      integer().nullable()();

  IntColumn get lineTotalMinor => integer()();

  IntColumn get lineCostMinor =>
      integer().nullable()();

  TextColumn get costSource =>
      text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {
        serverId,
      };
}


class LocalSyncOperations extends Table {
  IntColumn get id =>
      integer().autoIncrement()();

  TextColumn get operationUuid =>
      text().unique()();

  TextColumn get operationType =>
      text()();

  TextColumn get payloadJson =>
      text()();

  TextColumn get status =>
      text().withDefault(
        const Constant(
          'pending_sync',
        ),
      )();

  IntColumn get attempts =>
      integer().withDefault(
        const Constant(0),
      )();

  TextColumn get lastError =>
      text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime()();

  DateTimeColumn get updatedAt =>
      dateTime()();
}


class LocalAttachmentQueue extends Table {
  IntColumn get id =>
      integer().autoIncrement()();

  TextColumn get uuid =>
      text().unique()();

  TextColumn get transactionUuid =>
      text()();

  IntColumn get transactionServerId =>
      integer().nullable()();

  TextColumn get originalName =>
      text()();

  TextColumn get mimeType =>
      text()();

  IntColumn get sizeBytes =>
      integer()();

  TextColumn get bytesBase64 =>
      text()();

  TextColumn get syncStatus =>
      text().withDefault(
        const Constant(
          'pending_sync',
        ),
      )();

  TextColumn get lastError =>
      text().nullable()();

  DateTimeColumn get createdAt =>
      dateTime()();

  DateTimeColumn get updatedAt =>
      dateTime()();
}

@DriftDatabase(
  tables: [
    LocalUsers,
    LocalCurrencies,
    LocalFinancialAccounts,
    LocalCategories,
    LocalParties,
    LocalPartyOpeningBalances,
    LocalWorkers,
    LocalWorkerOpeningBalances,
    LocalAccountingTransactions,
    LocalProducts,
    LocalTransactionItems,
    LocalSyncOperations,
    LocalAttachmentQueue,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          driftDatabase(
            name: 'shop_accounts',
            web: DriftWebOptions(
              sqlite3Wasm:
                  Uri.parse('sqlite3.wasm'),
              driftWorker:
                  Uri.parse('drift_worker.js'),
            ),
          ),
        );

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator migrator) async {
        await migrator.createAll();
      },
      onUpgrade: (
        Migrator migrator,
        int from,
        int to,
      ) async {
        if (from < 2) {
          await migrator.createTable(
            localCurrencies,
          );

          await migrator.createTable(
            localFinancialAccounts,
          );

          await migrator.createTable(
            localCategories,
          );
        }

        if (from < 3) {
          await migrator.createTable(
            localParties,
          );

          await migrator.createTable(
            localPartyOpeningBalances,
          );
        }

        if (from < 4) {
          await migrator.createTable(
            localWorkers,
          );

          await migrator.createTable(
            localWorkerOpeningBalances,
          );
        }

        if (from < 5) {
          await migrator.createTable(
            localAccountingTransactions,
          );
        }

        if (from < 6) {
          await migrator.addColumn(
            localAccountingTransactions,
            localAccountingTransactions.costStatus,
          );

          await migrator.addColumn(
            localAccountingTransactions,
            localAccountingTransactions.costTotalMinor,
          );

          await migrator.addColumn(
            localAccountingTransactions,
            localAccountingTransactions.grossProfitMinor,
          );

          await migrator.createTable(
            localProducts,
          );

          await migrator.createTable(
            localTransactionItems,
          );
        }

        if (from < 7) {
          await migrator.createTable(
            localSyncOperations,
          );
        }

        if (from < 8) {
          await migrator.createTable(
            localAttachmentQueue,
          );
        }
      },
      beforeOpen: (details) async {
        await customStatement(
          'PRAGMA foreign_keys = ON',
        );
      },
    );
  }

  Future<LocalUser?> getTrustedUser() {
    final query = select(localUsers)
      ..where(
        (table) =>
            table.isTrusted.equals(true),
      )
      ..orderBy([
        (table) => OrderingTerm.desc(
              table.lastOnlineLoginAt,
            ),
      ])
      ..limit(1);

    return query.getSingleOrNull();
  }

  Future<void> saveTrustedUser({
    required int serverId,
    required String name,
    required String email,
    required String role,
    required String status,
    required String deviceUuid,
  }) async {
    await transaction(() async {
      await update(localUsers).write(
        const LocalUsersCompanion(
          isTrusted: Value(false),
        ),
      );

      await into(localUsers)
          .insertOnConflictUpdate(
        LocalUsersCompanion(
          serverId: Value(serverId),
          name: Value(name),
          email: Value(email),
          role: Value(role),
          status: Value(status),
          deviceUuid: Value(deviceUuid),
          isTrusted: const Value(true),
          lastOnlineLoginAt:
              Value(DateTime.now()),
        ),
      );
    });
  }

  Future<void> clearLocalUsers() {
    return delete(localUsers).go();
  }

  Future<void> replaceReferenceData(
    ReferenceDataModel data,
  ) async {
    await transaction(() async {
      await delete(
        localFinancialAccounts,
      ).go();

      await delete(localCategories).go();
      await delete(localCurrencies).go();

      for (final currency in data.currencies) {
        await into(localCurrencies).insert(
          LocalCurrenciesCompanion.insert(
            serverId:
                Value(currency.id),
            uuid: currency.uuid,
            code: currency.code,
            nameAr: currency.nameAr,
            symbol: currency.symbol,
            decimalPlaces:
                currency.decimalPlaces,
            isActive: currency.isActive,
            updatedAt:
                Value(currency.updatedAt),
          ),
        );
      }

      for (final account
          in data.financialAccounts) {
        await into(
          localFinancialAccounts,
        ).insert(
          LocalFinancialAccountsCompanion
              .insert(
            serverId:
                Value(account.id),
            uuid: account.uuid,
            name: account.name,
            type: account.type,
            currencyServerId:
                account.currencyId,
            currencyCode:
                account.currencyCode,
            currencySymbol:
                account.currencySymbol,
            currencyDecimalPlaces:
                account
                    .currencyDecimalPlaces,
            openingBalanceMinor:
                account
                    .openingBalanceMinor,
            notes:
                Value(account.notes),
            isActive:
                account.isActive,
            updatedAt:
                Value(account.updatedAt),
          ),
        );
      }

      for (final category
          in data.categories) {
        await into(localCategories).insert(
          LocalCategoriesCompanion.insert(
            serverId:
                Value(category.id),
            uuid: category.uuid,
            name: category.name,
            type: category.type,
            notes:
                Value(category.notes),
            isActive:
                category.isActive,
            updatedAt:
                Value(category.updatedAt),
          ),
        );
      }
    });
  }

  Future<ReferenceDataModel>
      readReferenceData() async {
    final currenciesRows =
        await select(localCurrencies).get();

    final accountsRows =
        await select(
      localFinancialAccounts,
    ).get();

    final categoryRows =
        await select(localCategories).get();

    return ReferenceDataModel(
      currencies: currenciesRows
          .map(
            (row) => CurrencyModel(
              id: row.serverId,
              uuid: row.uuid,
              code: row.code,
              nameAr: row.nameAr,
              symbol: row.symbol,
              decimalPlaces:
                  row.decimalPlaces,
              isActive: row.isActive,
              updatedAt: row.updatedAt,
            ),
          )
          .toList(),
      financialAccounts: accountsRows
          .map(
            (row) =>
                FinancialAccountModel(
              id: row.serverId,
              uuid: row.uuid,
              name: row.name,
              type: row.type,
              currencyId:
                  row.currencyServerId,
              currencyCode:
                  row.currencyCode,
              currencySymbol:
                  row.currencySymbol,
              currencyDecimalPlaces:
                  row.currencyDecimalPlaces,
              openingBalanceMinor:
                  row.openingBalanceMinor,
              notes: row.notes,
              isActive: row.isActive,
              updatedAt: row.updatedAt,
            ),
          )
          .toList(),
      categories: categoryRows
          .map(
            (row) => CategoryModel(
              id: row.serverId,
              uuid: row.uuid,
              name: row.name,
              type: row.type,
              notes: row.notes,
              isActive: row.isActive,
              updatedAt: row.updatedAt,
            ),
          )
          .toList(),
    );
  }

  Future<void> upsertParties(
    List<PartyModel> parties,
  ) async {
    await transaction(() async {
      for (final party in parties) {
        await into(localParties)
            .insertOnConflictUpdate(
          LocalPartiesCompanion(
            serverId: Value(party.id),
            uuid: Value(party.uuid),
            type: Value(party.type),
            name: Value(party.name),
            phone: Value(party.phone),
            address: Value(party.address),
            notes: Value(party.notes),
            isActive:
                Value(party.isActive),
            version:
                Value(party.version),
            lastMovementAt:
                Value(party.lastMovementAt),
            createdAt:
                Value(party.createdAt),
            updatedAt:
                Value(party.updatedAt),
          ),
        );

        await (
          delete(
            localPartyOpeningBalances,
          )..where(
              (table) =>
                  table.partyServerId.equals(
                party.id,
              ),
            )
        ).go();

        for (final balance
            in party.openingBalances) {
          await into(
            localPartyOpeningBalances,
          ).insert(
            LocalPartyOpeningBalancesCompanion(
              serverId:
                  Value(balance.id),
              partyServerId:
                  Value(party.id),
              currencyServerId:
                  Value(balance.currencyId),
              currencyCode:
                  Value(balance.currencyCode),
              currencyNameAr:
                  Value(balance.currencyNameAr),
              currencySymbol:
                  Value(balance.currencySymbol),
              currencyDecimalPlaces:
                  Value(
                balance.currencyDecimalPlaces,
              ),
              balanceSide:
                  Value(balance.balanceSide),
              amountMinor:
                  Value(balance.amountMinor),
            ),
          );
        }
      }
    });
  }

  Future<List<PartyModel>> readParties({
    String? type,
    String? search,
  }) async {
    final partyRows =
        await select(localParties).get();

    final balanceRows =
        await select(
      localPartyOpeningBalances,
    ).get();

    final normalizedSearch =
        search?.trim().toLowerCase() ?? '';

    bool matchesType(
      LocalParty row,
    ) {
      if (type == null || type.isEmpty) {
        return true;
      }

      if (type == 'customer') {
        return row.type == 'customer' ||
            row.type == 'both';
      }

      if (type == 'supplier') {
        return row.type == 'supplier' ||
            row.type == 'both';
      }

      return row.type == type;
    }

    bool matchesSearch(
      LocalParty row,
    ) {
      if (normalizedSearch.isEmpty) {
        return true;
      }

      return row.name
              .toLowerCase()
              .contains(
                normalizedSearch,
              ) ||
          (row.phone ?? '')
              .toLowerCase()
              .contains(
                normalizedSearch,
              );
    }

    final filtered = partyRows
        .where(
          (row) =>
              matchesType(row) &&
              matchesSearch(row),
        )
        .toList()
      ..sort(
        (a, b) =>
            a.name.compareTo(b.name),
      );

    return filtered.map((row) {
      final balances = balanceRows
          .where(
            (balance) =>
                balance.partyServerId ==
                row.serverId,
          )
          .map(
            (balance) =>
                PartyOpeningBalanceModel(
              id: balance.serverId,
              currencyId:
                  balance.currencyServerId,
              currencyCode:
                  balance.currencyCode,
              currencyNameAr:
                  balance.currencyNameAr,
              currencySymbol:
                  balance.currencySymbol,
              currencyDecimalPlaces:
                  balance
                      .currencyDecimalPlaces,
              balanceSide:
                  balance.balanceSide,
              amountMinor:
                  balance.amountMinor,
            ),
          )
          .toList();

      return PartyModel(
        id: row.serverId,
        uuid: row.uuid,
        type: row.type,
        name: row.name,
        phone: row.phone,
        address: row.address,
        notes: row.notes,
        isActive: row.isActive,
        version: row.version,
        lastMovementAt:
            row.lastMovementAt,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
        openingBalances: balances,
      );
    }).toList();
  }


  Future<void> upsertWorkers(
    List<WorkerModel> workers,
  ) async {
    await transaction(() async {
      for (final worker in workers) {
        await into(localWorkers)
            .insertOnConflictUpdate(
          LocalWorkersCompanion(
            serverId: Value(worker.id),
            uuid: Value(worker.uuid),
            name: Value(worker.name),
            phone: Value(worker.phone),
            jobTitle:
                Value(worker.jobTitle),
            wageType:
                Value(worker.wageType),
            wageCurrencyServerId:
                Value(worker.wageCurrencyId),
            wageCurrencyCode:
                Value(worker.wageCurrencyCode),
            wageCurrencySymbol:
                Value(
              worker.wageCurrencySymbol,
            ),
            wageCurrencyDecimalPlaces:
                Value(
              worker
                  .wageCurrencyDecimalPlaces,
            ),
            wageAmountMinor:
                Value(worker.wageAmountMinor),
            hireDate:
                Value(worker.hireDate),
            notes:
                Value(worker.notes),
            isActive:
                Value(worker.isActive),
            version:
                Value(worker.version),
            createdAt:
                Value(worker.createdAt),
            updatedAt:
                Value(worker.updatedAt),
          ),
        );

        await (
          delete(
            localWorkerOpeningBalances,
          )..where(
              (table) =>
                  table.workerServerId
                      .equals(worker.id),
            )
        ).go();

        for (final balance
            in worker.openingBalances) {
          await into(
            localWorkerOpeningBalances,
          ).insert(
            LocalWorkerOpeningBalancesCompanion(
              serverId:
                  Value(balance.id),
              workerServerId:
                  Value(worker.id),
              currencyServerId:
                  Value(balance.currencyId),
              currencyCode:
                  Value(balance.currencyCode),
              currencyNameAr:
                  Value(balance.currencyNameAr),
              currencySymbol:
                  Value(balance.currencySymbol),
              currencyDecimalPlaces:
                  Value(
                balance.currencyDecimalPlaces,
              ),
              balanceSide:
                  Value(balance.balanceSide),
              amountMinor:
                  Value(balance.amountMinor),
            ),
          );
        }
      }
    });
  }

  Future<List<WorkerModel>> readWorkers({
    String? search,
  }) async {
    final workerRows =
        await select(localWorkers).get();

    final balanceRows =
        await select(
      localWorkerOpeningBalances,
    ).get();

    final normalizedSearch =
        search?.trim().toLowerCase() ?? '';

    final filtered = workerRows.where(
      (row) {
        if (normalizedSearch.isEmpty) {
          return true;
        }

        return row.name
                .toLowerCase()
                .contains(normalizedSearch) ||
            (row.phone ?? '')
                .toLowerCase()
                .contains(normalizedSearch) ||
            (row.jobTitle ?? '')
                .toLowerCase()
                .contains(normalizedSearch);
      },
    ).toList()
      ..sort(
        (a, b) =>
            a.name.compareTo(b.name),
      );

    return filtered.map(
      (row) {
        final balances = balanceRows
            .where(
              (balance) =>
                  balance.workerServerId ==
                  row.serverId,
            )
            .map(
              (balance) =>
                  WorkerOpeningBalanceModel(
                id: balance.serverId,
                currencyId:
                    balance.currencyServerId,
                currencyCode:
                    balance.currencyCode,
                currencyNameAr:
                    balance.currencyNameAr,
                currencySymbol:
                    balance.currencySymbol,
                currencyDecimalPlaces:
                    balance
                        .currencyDecimalPlaces,
                balanceSide:
                    balance.balanceSide,
                amountMinor:
                    balance.amountMinor,
              ),
            )
            .toList();

        return WorkerModel(
          id: row.serverId,
          uuid: row.uuid,
          name: row.name,
          phone: row.phone,
          jobTitle: row.jobTitle,
          wageType: row.wageType,
          wageCurrencyId:
              row.wageCurrencyServerId,
          wageCurrencyCode:
              row.wageCurrencyCode,
          wageCurrencySymbol:
              row.wageCurrencySymbol,
          wageCurrencyDecimalPlaces:
              row.wageCurrencyDecimalPlaces,
          wageAmountMinor:
              row.wageAmountMinor,
          hireDate: row.hireDate,
          notes: row.notes,
          isActive: row.isActive,
          version: row.version,
          createdAt: row.createdAt,
          updatedAt: row.updatedAt,
          openingBalances: balances,
        );
      },
    ).toList();
  }



  Future<void> upsertTransactions(
    List<AccountingTransactionModel> transactions,
  ) async {
    await transaction(() async {
      for (final item in transactions) {
        await into(
          localAccountingTransactions,
        ).insertOnConflictUpdate(
          LocalAccountingTransactionsCompanion(
            serverId: Value(item.id),
            uuid: Value(item.uuid),
            transactionNo:
                Value(item.transactionNo),
            type: Value(item.type),
            settlementMode:
                Value(item.settlementMode),
            currencyServerId:
                Value(item.currencyId),
            currencyCode:
                Value(item.currencyCode),
            currencySymbol:
                Value(item.currencySymbol),
            currencyDecimalPlaces:
                Value(item.currencyDecimalPlaces),
            amountMinor:
                Value(item.amountMinor),
            paidNowMinor:
                Value(item.paidNowMinor),
            costStatus:
                Value(item.costStatus),
            costTotalMinor:
                Value(item.costTotalMinor),
            grossProfitMinor:
                Value(item.grossProfitMinor),
            partyServerId:
                Value(item.partyId),
            partyName:
                Value(item.partyName),
            workerServerId:
                Value(item.workerId),
            workerName:
                Value(item.workerName),
            categoryServerId:
                Value(item.categoryId),
            categoryName:
                Value(item.categoryName),
            financialAccountServerId:
                Value(item.financialAccountId),
            financialAccountName:
                Value(item.financialAccountName),
            targetFinancialAccountServerId:
                Value(item.targetFinancialAccountId),
            targetFinancialAccountName:
                Value(item.targetFinancialAccountName),
            occurredAt:
                Value(item.occurredAt),
            description:
                Value(item.description),
            notes:
                Value(item.notes),
            status:
                Value(item.status),
            reversalOfServerId:
                Value(item.reversalOfId),
            createdByName:
                Value(item.createdByName),
          ),
        );

        await (
          delete(localTransactionItems)
            ..where(
              (table) =>
                  table.transactionServerId
                      .equals(item.id),
            )
        ).go();

        for (final line in item.items) {
          await into(
            localTransactionItems,
          ).insertOnConflictUpdate(
            LocalTransactionItemsCompanion(
              serverId: Value(line.id),
              transactionServerId:
                  Value(item.id),
              productServerId:
                  Value(line.productId),
              productName:
                  Value(line.productName),
              productSku:
                  Value(line.productSku),
              description:
                  Value(line.description),
              quantityMilli:
                  Value(line.quantityMilli),
              unit:
                  Value(line.unit),
              unitPriceMinor:
                  Value(line.unitPriceMinor),
              unitCostMinor:
                  Value(line.unitCostMinor),
              lineTotalMinor:
                  Value(line.lineTotalMinor),
              lineCostMinor:
                  Value(line.lineCostMinor),
              costSource:
                  Value(line.costSource),
            ),
          );
        }
      }
    });
  }

  Future<List<AccountingTransactionModel>>
      readTransactions() async {
    final rows = await (
      select(localAccountingTransactions)
        ..orderBy([
          (table) => OrderingTerm.desc(
                table.occurredAt,
              ),
          (table) => OrderingTerm.desc(
                table.serverId,
              ),
        ])
    ).get();

    final itemRows =
        await select(localTransactionItems).get();

    return rows
        .map(
          (row) {
            final items = itemRows
                .where(
                  (line) =>
                      line.transactionServerId ==
                      row.serverId,
                )
                .map(
                  (line) => TransactionItemModel(
                    id: line.serverId,
                    productId:
                        line.productServerId,
                    productName:
                        line.productName,
                    productSku:
                        line.productSku,
                    description:
                        line.description,
                    quantityMilli:
                        line.quantityMilli,
                    unit: line.unit,
                    unitPriceMinor:
                        line.unitPriceMinor,
                    unitCostMinor:
                        line.unitCostMinor,
                    lineTotalMinor:
                        line.lineTotalMinor,
                    lineCostMinor:
                        line.lineCostMinor,
                    costSource:
                        line.costSource,
                  ),
                )
                .toList();

            return AccountingTransactionModel(
              id: row.serverId,
              uuid: row.uuid,
              transactionNo: row.transactionNo,
              type: row.type,
              settlementMode: row.settlementMode,
              currencyId: row.currencyServerId,
              currencyCode: row.currencyCode,
              currencySymbol: row.currencySymbol,
              currencyDecimalPlaces:
                  row.currencyDecimalPlaces,
              amountMinor: row.amountMinor,
              paidNowMinor: row.paidNowMinor,
              costStatus: row.costStatus,
              costTotalMinor:
                  row.costTotalMinor,
              grossProfitMinor:
                  row.grossProfitMinor,
              partyId: row.partyServerId,
              partyName: row.partyName,
              workerId: row.workerServerId,
              workerName: row.workerName,
              categoryId: row.categoryServerId,
              categoryName: row.categoryName,
              financialAccountId:
                  row.financialAccountServerId,
              financialAccountName:
                  row.financialAccountName,
              targetFinancialAccountId:
                  row.targetFinancialAccountServerId,
              targetFinancialAccountName:
                  row.targetFinancialAccountName,
              occurredAt: row.occurredAt,
              description: row.description,
              notes: row.notes,
              status: row.status,
              reversalOfId:
                  row.reversalOfServerId,
              createdByName:
                  row.createdByName,
              items: items,
            );
          },
        )
        .toList();
  }

  Future<void> upsertProducts(
    List<ProductModel> products,
  ) async {
    await transaction(() async {
      for (final product in products) {
        await into(localProducts)
            .insertOnConflictUpdate(
          LocalProductsCompanion(
            serverId:
                Value(product.id),
            uuid:
                Value(product.uuid),
            sku:
                Value(product.sku),
            name:
                Value(product.name),
            productType:
                Value(product.productType),
            unit:
                Value(product.unit),
            currencyServerId:
                Value(product.currencyId),
            currencyCode:
                Value(product.currencyCode),
            currencyNameAr:
                Value(product.currencyNameAr),
            currencySymbol:
                Value(product.currencySymbol),
            currencyDecimalPlaces:
                Value(
              product.currencyDecimalPlaces,
            ),
            defaultSalePriceMinor:
                Value(
              product.defaultSalePriceMinor,
            ),
            stockQuantityMilli:
                Value(
              product.stockQuantityMilli,
            ),
            averageCostMinor:
                Value(product.averageCostMinor),
            isActive:
                Value(product.isActive),
            version:
                Value(product.version),
          ),
        );
      }
    });
  }

  Future<List<ProductModel>> readProducts({
    String? search,
    String? type,
    int? currencyId,
  }) async {
    final rows =
        await select(localProducts).get();

    final normalized =
        search?.trim().toLowerCase() ?? '';

    final filtered = rows.where(
      (row) {
        final searchOk =
            normalized.isEmpty ||
            row.name
                .toLowerCase()
                .contains(normalized) ||
            (row.sku ?? '')
                .toLowerCase()
                .contains(normalized);

        final typeOk =
            type == null ||
            type.isEmpty ||
            row.productType == type;

        final currencyOk =
            currencyId == null ||
            row.currencyServerId ==
                currencyId;

        return searchOk &&
            typeOk &&
            currencyOk;
      },
    ).toList()
      ..sort(
        (a, b) =>
            a.name.compareTo(b.name),
      );

    return filtered
        .map(
          (row) => ProductModel(
            id: row.serverId,
            uuid: row.uuid,
            sku: row.sku,
            name: row.name,
            productType: row.productType,
            unit: row.unit,
            currencyId:
                row.currencyServerId,
            currencyCode:
                row.currencyCode,
            currencyNameAr:
                row.currencyNameAr,
            currencySymbol:
                row.currencySymbol,
            currencyDecimalPlaces:
                row.currencyDecimalPlaces,
            defaultSalePriceMinor:
                row.defaultSalePriceMinor,
            stockQuantityMilli:
                row.stockQuantityMilli,
            averageCostMinor:
                row.averageCostMinor,
            isActive: row.isActive,
            version: row.version,
          ),
        )
        .toList();
  }


  Future<void> enqueueSyncOperation({
    required String operationUuid,
    required String operationType,
    required Map<String, dynamic> payload,
  }) async {
    final now = DateTime.now();

    await into(localSyncOperations)
        .insertOnConflictUpdate(
      LocalSyncOperationsCompanion(
        operationUuid:
            Value(operationUuid),
        operationType:
            Value(operationType),
        payloadJson:
            Value(jsonEncode(payload)),
        status: const Value(
          'pending_sync',
        ),
        attempts:
            const Value(0),
        lastError:
            const Value<String?>(null),
        createdAt:
            Value(now),
        updatedAt:
            Value(now),
      ),
    );
  }

  Future<List<SyncOperationModel>>
      readSyncOperations({
    bool includeFailed = true,
    int limit = 50,
  }) async {
    final query =
        select(localSyncOperations)
          ..where(
            (table) =>
                table.status.isIn(
                  includeFailed
                      ? [
                          'pending_sync',
                          'syncing',
                          'failed',
                        ]
                      : [
                          'pending_sync',
                          'syncing',
                        ],
                ),
          )
          ..orderBy([
            (table) =>
                OrderingTerm.asc(
              table.createdAt,
            ),
          ])
          ..limit(limit);

    final rows =
        await query.get();

    return rows
        .map(
          (row) =>
              SyncOperationModel(
            localId: row.id,
            operationUuid:
                row.operationUuid,
            operationType:
                row.operationType,
            payloadJson:
                row.payloadJson,
            status: row.status,
            attempts: row.attempts,
            lastError:
                row.lastError,
            createdAt:
                row.createdAt,
            updatedAt:
                row.updatedAt,
          ),
        )
        .toList();
  }

  Future<int> pendingSyncCount() async {
    final count = localSyncOperations.id.count();

    final query = selectOnly(
      localSyncOperations,
    )
      ..addColumns([count])
      ..where(
        localSyncOperations.status.isIn([
          'pending_sync',
          'syncing',
        ]),
      );

    final row =
        await query.getSingle();

    return row.read(count) ?? 0;
  }

  Future<int> failedSyncCount() async {
    final count = localSyncOperations.id.count();

    final query = selectOnly(
      localSyncOperations,
    )
      ..addColumns([count])
      ..where(
        localSyncOperations.status.equals(
          'failed',
        ),
      );

    final row =
        await query.getSingle();

    return row.read(count) ?? 0;
  }

  Future<void> markSyncing(
    List<SyncOperationModel> operations,
  ) async {
    await transaction(() async {
      for (final operation in operations) {
        await (
          update(localSyncOperations)
            ..where(
              (table) =>
                  table.operationUuid.equals(
                operation.operationUuid,
              ),
            )
        ).write(
          LocalSyncOperationsCompanion(
            status:
                const Value('syncing'),
            attempts:
                Value(
              operation.attempts + 1,
            ),
            lastError:
                const Value<String?>(null),
            updatedAt:
                Value(DateTime.now()),
          ),
        );
      }
    });
  }

  Future<void> markSyncPending({
    required String operationUuid,
    String? error,
  }) async {
    await (
      update(localSyncOperations)
        ..where(
          (table) =>
              table.operationUuid.equals(
            operationUuid,
          ),
        )
    ).write(
      LocalSyncOperationsCompanion(
        status:
            const Value(
          'pending_sync',
        ),
        lastError:
            Value(error),
        updatedAt:
            Value(DateTime.now()),
      ),
    );
  }

  Future<void> markSyncFailed({
    required String operationUuid,
    required String error,
  }) async {
    await (
      update(localSyncOperations)
        ..where(
          (table) =>
              table.operationUuid.equals(
            operationUuid,
          ),
        )
    ).write(
      LocalSyncOperationsCompanion(
        status:
            const Value('failed'),
        lastError:
            Value(error),
        updatedAt:
            Value(DateTime.now()),
      ),
    );
  }

  Future<bool> updatePendingTransactionPayload({
    required String operationUuid,
    required Map<String, dynamic> payload,
  }) async {
    final query = select(localSyncOperations)
      ..where(
        (table) =>
            table.operationUuid.equals(
          operationUuid,
        ),
      )
      ..limit(1);

    final row = await query.getSingleOrNull();

    if (row == null ||
        row.operationType !=
            'accounting_transaction' ||
        row.status == 'syncing') {
      return false;
    }

    final prepared =
        Map<String, dynamic>.from(payload);

    prepared['uuid'] = operationUuid;

    final oldPayload =
        Map<String, dynamic>.from(
      jsonDecode(row.payloadJson) as Map,
    );

    prepared['client_created_at'] ??=
        oldPayload['client_created_at'] ??
            row.createdAt.toIso8601String();

    await (update(localSyncOperations)
          ..where(
            (table) =>
                table.operationUuid.equals(
              operationUuid,
            ),
          ))
        .write(
      LocalSyncOperationsCompanion(
        payloadJson:
            Value(jsonEncode(prepared)),
        status:
            const Value('pending_sync'),
        attempts: const Value(0),
        lastError:
            const Value<String?>(null),
        updatedAt:
            Value(DateTime.now()),
      ),
    );

    return true;
  }

  Future<void> removeSyncOperation(
    String operationUuid,
  ) async {
    await (
      delete(localSyncOperations)
        ..where(
          (table) =>
              table.operationUuid.equals(
            operationUuid,
          ),
        )
    ).go();
  }

  Future<AccountingTransactionModel?>
      pendingTransactionByUuid(
    String operationUuid,
  ) async {
    final query =
        select(localSyncOperations)
          ..where(
            (table) =>
                table.operationUuid.equals(
              operationUuid,
            ),
          )
          ..limit(1);

    final row =
        await query.getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _pendingTransaction(
      row,
    );
  }

  Future<List<AccountingTransactionModel>>
      readPendingTransactions() async {
    final rows = await (
      select(localSyncOperations)
        ..where(
          (table) =>
              table.status.isIn([
            'pending_sync',
            'syncing',
            'failed',
          ]),
        )
        ..orderBy([
          (table) =>
              OrderingTerm.desc(
            table.createdAt,
          ),
        ])
    ).get();

    final result =
        <AccountingTransactionModel>[];

    for (final row in rows) {
      result.add(
        await _pendingTransaction(
          row,
        ),
      );
    }

    return result;
  }

  Future<List<AccountingTransactionModel>>
      readAllTransactions() async {
    final server =
        await readTransactions();

    final pending =
        await readPendingTransactions();

    final combined = [
      ...pending,
      ...server,
    ];

    combined.sort(
      (a, b) =>
          b.occurredAt.compareTo(
        a.occurredAt,
      ),
    );

    return combined;
  }

  Future<AccountingTransactionModel>
      _pendingTransaction(
    LocalSyncOperation row,
  ) async {
    final payload =
        Map<String, dynamic>.from(
      jsonDecode(
        row.payloadJson,
      ) as Map,
    );

    final operationType =
        row.operationType;

    final type =
        operationType ==
                'simple_sale' ||
            operationType ==
                'product_sale'
        ? 'sale'
        : operationType ==
                'purchase'
            ? 'purchase'
            : payload['type']
                    ?.toString() ??
                'unknown';

    final currencyId =
        (payload['currency_id']
                as num?)
            ?.toInt() ??
        0;

    final currency = await (
      select(localCurrencies)
        ..where(
          (table) =>
              table.serverId.equals(
            currencyId,
          ),
        )
        ..limit(1)
    ).getSingleOrNull();

    final partyId =
        (payload['party_id']
                as num?)
            ?.toInt();

    final workerId =
        (payload['worker_id']
                as num?)
            ?.toInt();

    final categoryId =
        (payload['category_id']
                as num?)
            ?.toInt();

    final financialAccountId =
        (payload[
                    'financial_account_id'
                ]
                as num?)
            ?.toInt();

    final targetFinancialAccountId =
        (payload[
                    'target_financial_account_id'
                ]
                as num?)
            ?.toInt();

    String? partyName;
    String? workerName;
    String? categoryName;
    String? financialAccountName;
    String? targetFinancialAccountName;

    if (partyId != null) {
      partyName = await _partyName(
        partyId,
      );
    }

    if (workerId != null) {
      workerName = await _workerName(
        workerId,
      );
    }

    if (categoryId != null) {
      categoryName =
          await _categoryName(
        categoryId,
      );
    }

    if (financialAccountId != null) {
      financialAccountName =
          await _financialAccountName(
        financialAccountId,
      );
    }

    if (
      targetFinancialAccountId !=
      null
    ) {
      targetFinancialAccountName =
          await _financialAccountName(
        targetFinancialAccountId,
      );
    }

    var amountMinor =
        (payload['amount_minor']
                as num?)
            ?.toInt() ??
        0;

    var paidNowMinor =
        (payload['paid_now_minor']
                as num?)
            ?.toInt() ??
        0;

    var settlementMode =
        'cash';

    final items =
        <TransactionItemModel>[];

    if (
      operationType ==
          'purchase' ||
      operationType ==
          'product_sale'
    ) {
      amountMinor = 0;

      final rawItems =
          payload['items']
                  as List<dynamic>? ??
              [];

      var index = 0;

      for (final raw in rawItems) {
        index++;

        final item =
            Map<String, dynamic>.from(
          raw as Map,
        );

        final productId =
            (item['product_id']
                    as num?)
                ?.toInt();

        final quantity =
            (item['quantity_milli']
                    as num?)
                ?.toInt() ??
            0;

        final unitPrice =
            (item['unit_price_minor']
                    as num?)
                ?.toInt() ??
            0;

        final lineTotal =
            (
              quantity * unitPrice +
              500
            ) ~/
            1000;

        amountMinor += lineTotal;

        String? productName;
        String? productSku;
        String unit = 'وحدة';

        if (productId != null) {
          final product = await (
            select(localProducts)
              ..where(
                (table) =>
                    table.serverId.equals(
                  productId,
                ),
              )
              ..limit(1)
          ).getSingleOrNull();

          productName =
              product?.name;

          productSku =
              product?.sku;

          unit =
              product?.unit ??
              unit;
        }

        items.add(
          TransactionItemModel(
            id:
                -(
                  row.id * 1000 +
                  index
                ),
            productId:
                productId,
            productName:
                productName,
            productSku:
                productSku,
            description:
                item['description']
                        ?.toString() ??
                    productName ??
                    'بند',
            quantityMilli:
                quantity,
            unit: unit,
            unitPriceMinor:
                unitPrice,
            lineTotalMinor:
                lineTotal,
          ),
        );
      }

      paidNowMinor =
          (payload[
                    'paid_now_minor'
                  ]
                  as num?)
              ?.toInt() ??
          0;
    }

    if (
      operationType ==
          'accounting_transaction'
    ) {
      final creditOnly = {
        'worker_salary_accrual',
      }.contains(type);

      paidNowMinor =
          creditOnly
              ? 0
              : amountMinor;
    }

    if (paidNowMinor <= 0) {
      settlementMode =
          'credit';
    } else if (
      paidNowMinor <
      amountMinor
    ) {
      settlementMode =
          'mixed';
    } else {
      settlementMode =
          'cash';
    }

    final occurredAt =
        DateTime.tryParse(
          payload['occurred_at']
                  ?.toString() ??
              '',
        ) ??
        row.createdAt;

    return AccountingTransactionModel(
      id: -row.id,
      uuid:
          row.operationUuid,
      transactionNo:
          row.status == 'failed'
              ? 'FAILED-${row.id}'
              : 'LOCAL-${row.id}',
      type: type,
      settlementMode:
          settlementMode,
      currencyId:
          currencyId,
      currencyCode:
          currency?.code ?? '?',
      currencySymbol:
          currency?.symbol ?? '',
      currencyDecimalPlaces:
          currency?.decimalPlaces ??
          2,
      amountMinor:
          amountMinor,
      paidNowMinor:
          paidNowMinor,
      costStatus:
          type == 'sale'
              ? 'incomplete'
              : 'not_applicable',
      occurredAt:
          occurredAt,
      status:
          row.status,
      items:
          items,
      partyId:
          partyId,
      partyName:
          partyName,
      workerId:
          workerId,
      workerName:
          workerName,
      categoryId:
          categoryId,
      categoryName:
          categoryName,
      financialAccountId:
          financialAccountId,
      financialAccountName:
          financialAccountName,
      targetFinancialAccountId:
          targetFinancialAccountId,
      targetFinancialAccountName:
          targetFinancialAccountName,
      description:
          payload['description']
              ?.toString(),
      notes:
          row.status == 'failed'
              ? row.lastError
              : payload['notes']
                  ?.toString(),
    );
  }

  Future<String?> _partyName(
    int serverId,
  ) async {
    final row = await (
      select(localParties)
        ..where(
          (table) =>
              table.serverId.equals(
            serverId,
          ),
        )
        ..limit(1)
    ).getSingleOrNull();

    return row?.name;
  }

  Future<String?> _workerName(
    int serverId,
  ) async {
    final row = await (
      select(localWorkers)
        ..where(
          (table) =>
              table.serverId.equals(
            serverId,
          ),
        )
        ..limit(1)
    ).getSingleOrNull();

    return row?.name;
  }

  Future<String?> _categoryName(
    int serverId,
  ) async {
    final row = await (
      select(localCategories)
        ..where(
          (table) =>
              table.serverId.equals(
            serverId,
          ),
        )
        ..limit(1)
    ).getSingleOrNull();

    return row?.name;
  }

  Future<String?>
      _financialAccountName(
    int serverId,
  ) async {
    final row = await (
      select(localFinancialAccounts)
        ..where(
          (table) =>
              table.serverId.equals(
            serverId,
          ),
        )
        ..limit(1)
    ).getSingleOrNull();

    return row?.name;
  }


  Future<void> enqueueAttachment({
    required String uuid,
    required String transactionUuid,
    required String originalName,
    required String mimeType,
    required List<int> bytes,
  }) async {
    final now = DateTime.now();

    await into(localAttachmentQueue)
        .insertOnConflictUpdate(
      LocalAttachmentQueueCompanion(
        uuid: Value(uuid),
        transactionUuid:
            Value(transactionUuid),
        originalName:
            Value(originalName),
        mimeType:
            Value(mimeType),
        sizeBytes:
            Value(bytes.length),
        bytesBase64:
            Value(base64Encode(bytes)),
        syncStatus:
            const Value(
          'pending_sync',
        ),
        createdAt:
            Value(now),
        updatedAt:
            Value(now),
      ),
    );
  }

  Future<List<AttachmentModel>>
      readLocalAttachments(
    String transactionUuid,
  ) async {
    final rows = await (
      select(localAttachmentQueue)
        ..where(
          (table) =>
              table.transactionUuid.equals(
            transactionUuid,
          ),
        )
        ..orderBy([
          (table) =>
              OrderingTerm.desc(
            table.createdAt,
          ),
        ])
    ).get();

    return rows
        .map(
          (row) =>
              AttachmentModel(
            id: row.transactionServerId,
            uuid: row.uuid,
            transactionId:
                row.transactionServerId,
            transactionUuid:
                row.transactionUuid,
            originalName:
                row.originalName,
            mimeType:
                row.mimeType,
            sizeBytes:
                row.sizeBytes,
            syncStatus:
                row.syncStatus,
            lastError:
                row.lastError,
          ),
        )
        .toList();
  }

  Future<List<LocalAttachmentQueueData>>
      pendingAttachments() {
    return (
      select(localAttachmentQueue)
        ..where(
          (table) =>
              table.syncStatus.isIn([
            'pending_sync',
            'failed',
          ]),
        )
        ..orderBy([
          (table) =>
              OrderingTerm.asc(
            table.createdAt,
          ),
        ])
    ).get();
  }

  Future<void> markAttachmentFailed({
    required String uuid,
    required String error,
  }) async {
    await (
      update(localAttachmentQueue)
        ..where(
          (table) =>
              table.uuid.equals(
            uuid,
          ),
        )
    ).write(
      LocalAttachmentQueueCompanion(
        syncStatus:
            const Value('failed'),
        lastError:
            Value(error),
        updatedAt:
            Value(DateTime.now()),
      ),
    );
  }

  Future<void> removeAttachmentQueue(
    String uuid,
  ) async {
    await (
      delete(localAttachmentQueue)
        ..where(
          (table) =>
              table.uuid.equals(
            uuid,
          ),
        )
    ).go();
  }

  Future<int> pendingAttachmentCount() async {
    final count =
        localAttachmentQueue.id.count();

    final query =
        selectOnly(
      localAttachmentQueue,
    )
          ..addColumns([count])
          ..where(
            localAttachmentQueue
                .syncStatus
                .isIn([
              'pending_sync',
              'failed',
            ]),
          );

    final row =
        await query.getSingle();

    return row.read(count) ?? 0;
  }

}
