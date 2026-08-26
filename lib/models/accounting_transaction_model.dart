import 'transaction_item_model.dart';

class AccountingTransactionModel {
  final int id;
  final String uuid;
  final String transactionNo;
  final String type;
  final String settlementMode;

  final int currencyId;
  final String currencyCode;
  final String currencySymbol;
  final int currencyDecimalPlaces;

  final int amountMinor;
  final int paidNowMinor;

  final String costStatus;
  final int? costTotalMinor;
  final int? grossProfitMinor;

  final int? partyId;
  final String? partyName;
  final int? workerId;
  final String? workerName;
  final int? categoryId;
  final String? categoryName;

  final int? financialAccountId;
  final String? financialAccountName;

  final int? targetFinancialAccountId;
  final String? targetFinancialAccountName;

  final DateTime occurredAt;
  final String? description;
  final String? notes;

  final String status;
  final int? reversalOfId;
  final String? createdByName;

  final List<TransactionItemModel> items;

  const AccountingTransactionModel({
    required this.id,
    required this.uuid,
    required this.transactionNo,
    required this.type,
    required this.settlementMode,
    required this.currencyId,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyDecimalPlaces,
    required this.amountMinor,
    required this.paidNowMinor,
    required this.costStatus,
    required this.occurredAt,
    required this.status,
    required this.items,
    this.costTotalMinor,
    this.grossProfitMinor,
    this.partyId,
    this.partyName,
    this.workerId,
    this.workerName,
    this.categoryId,
    this.categoryName,
    this.financialAccountId,
    this.financialAccountName,
    this.targetFinancialAccountId,
    this.targetFinancialAccountName,
    this.description,
    this.notes,
    this.reversalOfId,
    this.createdByName,
  });

  factory AccountingTransactionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawItems =
        json['items'] as List<dynamic>? ?? [];

    return AccountingTransactionModel(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'].toString(),
      transactionNo:
          json['transaction_no'].toString(),
      type: json['type'].toString(),
      settlementMode:
          json['settlement_mode'].toString(),
      currencyId:
          (json['currency_id'] as num).toInt(),
      currencyCode:
          json['currency_code'].toString(),
      currencySymbol:
          json['currency_symbol'].toString(),
      currencyDecimalPlaces:
          (json['currency_decimal_places'] as num)
              .toInt(),
      amountMinor:
          (json['amount_minor'] as num).toInt(),
      paidNowMinor:
          (json['paid_now_minor'] as num).toInt(),
      costStatus:
          json['cost_status']?.toString() ??
              'not_applicable',
      costTotalMinor:
          (json['cost_total_minor'] as num?)
              ?.toInt(),
      grossProfitMinor:
          (json['gross_profit_minor'] as num?)
              ?.toInt(),
      partyId:
          (json['party_id'] as num?)?.toInt(),
      partyName:
          json['party_name']?.toString(),
      workerId:
          (json['worker_id'] as num?)?.toInt(),
      workerName:
          json['worker_name']?.toString(),
      categoryId:
          (json['category_id'] as num?)?.toInt(),
      categoryName:
          json['category_name']?.toString(),
      financialAccountId:
          (json['financial_account_id'] as num?)
              ?.toInt(),
      financialAccountName:
          json['financial_account_name']
              ?.toString(),
      targetFinancialAccountId:
          (json['target_financial_account_id']
                  as num?)
              ?.toInt(),
      targetFinancialAccountName:
          json['target_financial_account_name']
              ?.toString(),
      occurredAt: DateTime.parse(
        json['occurred_at'].toString(),
      ),
      description:
          json['description']?.toString(),
      notes: json['notes']?.toString(),
      status: json['status'].toString(),
      reversalOfId:
          (json['reversal_of_id'] as num?)
              ?.toInt(),
      createdByName:
          json['created_by_name']?.toString(),
      items: rawItems
          .map(
            (item) =>
                TransactionItemModel.fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList(),
    );
  }
}
