import 'package:flutter/material.dart';

import '../../core/utils/money_utils.dart';
import '../../core/utils/quantity_utils.dart';
import '../../models/accounting_transaction_model.dart';
import '../attachments/transaction_attachments_screen.dart';

class TransactionDetailsScreen
    extends StatelessWidget {
  final AccountingTransactionModel transaction;

  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  String _typeLabel() {
    switch (transaction.type) {
      case 'sale':
        return 'بيع';
      case 'purchase':
        return 'شراء';
      case 'customer_collection':
        return 'تحصيل من عميل';
      case 'supplier_payment':
        return 'دفع لمورد';
      case 'expense':
        return 'مصروف';
      case 'other_income':
        return 'دخل آخر';
      case 'worker_salary_accrual':
        return 'استحقاق راتب';
      case 'worker_salary_payment':
        return 'دفع راتب';
      case 'worker_advance':
        return 'سلفة عامل';
      case 'worker_advance_recovery':
        return 'استرداد سلفة';
      case 'worker_deduction':
        return 'خصم عامل';
      case 'inventory_opening_balance':
        return 'مخزون افتتاحي';
      case 'reversal':
        return 'قيد عكسي';
      default:
        return transaction.type;
    }
  }

  String _settlementLabel() {
    switch (transaction.settlementMode) {
      case 'cash':
        return 'مدفوع بالكامل';
      case 'credit':
        return 'آجل بالكامل';
      case 'mixed':
        return 'مختلط';
      default:
        return transaction.settlementMode;
    }
  }

  String _statusLabel() {
    switch (transaction.status) {
      case 'posted':
        return 'مرحلة على الخادم';
      case 'pending_sync':
      case 'syncing':
        return 'محفوظة على الجهاز - بانتظار المزامنة';
      case 'failed':
        return 'فشلت المزامنة وتحتاج إعادة محاولة';
      case 'reversed':
        return 'معكوسة';
      default:
        return transaction.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount =
        MoneyUtils.formatMinor(
      transaction.amountMinor,
      transaction.currencyDecimalPlaces,
    );

    final paid =
        MoneyUtils.formatMinor(
      transaction.paidNowMinor,
      transaction.currencyDecimalPlaces,
    );

    final remaining =
        MoneyUtils.formatMinor(
      transaction.amountMinor -
          transaction.paidNowMinor,
      transaction.currencyDecimalPlaces,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          transaction.transactionNo,
        ),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(18),
        children: [
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    _typeLabel(),
                    style:
                        const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'الإجمالي: $amount ${transaction.currencySymbol}',
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'التسوية: ${_settlementLabel()}',
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'المدفوع: $paid ${transaction.currencySymbol}',
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'المتبقي: $remaining ${transaction.currencySymbol}',
                  ),
                  if (transaction.partyName !=
                      null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'الطرف: ${transaction.partyName}',
                    ),
                  ],
                  if (transaction
                          .financialAccountName !=
                      null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'الحساب المالي: ${transaction.financialAccountName}',
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    'الحالة: ${_statusLabel()}',
                  ),
                ],
              ),
            ),
          ),

          if (transaction.items.isNotEmpty) ...[
            const SizedBox(height: 18),
            const Text(
              'البنود',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...transaction.items.map(
              (item) {
                final line =
                    MoneyUtils.formatMinor(
                  item.lineTotalMinor,
                  transaction
                      .currencyDecimalPlaces,
                );

                final price =
                    MoneyUtils.formatMinor(
                  item.unitPriceMinor,
                  transaction
                      .currencyDecimalPlaces,
                );

                return Card(
                  child: ListTile(
                    title: Text(
                      item.productName ??
                          item.description,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${QuantityUtils.formatMilli(item.quantityMilli)} ${item.unit}'
                      ' × $price ${transaction.currencySymbol}',
                    ),
                    trailing: Text(
                      '$line ${transaction.currencySymbol}',
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],

          if (transaction.type ==
              'sale') ...[
            const SizedBox(height: 18),
            const Text(
              'الربح',
              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(16),
                child: transaction
                            .grossProfitMinor !=
                        null
                    ? Text(
                        'الربح الإجمالي: '
                        '${MoneyUtils.formatMinor(transaction.grossProfitMinor!, transaction.currencyDecimalPlaces)} '
                        '${transaction.currencySymbol}\n'
                        'التكلفة: '
                        '${MoneyUtils.formatMinor(transaction.costTotalMinor ?? 0, transaction.currencyDecimalPlaces)} '
                        '${transaction.currencySymbol}',
                      )
                    : const Text(
                        'بيانات التكلفة غير مكتملة، لذلك لا يتم عرض ربح تقديري غير موثوق.',
                      ),
              ),
            ),
          ],

          const SizedBox(height: 18),

          Card(
            child: ListTile(
              leading:
                  const CircleAvatar(
                child: Icon(
                  Icons.attach_file,
                ),
              ),
              title:
                  const Text(
                'المرفقات',
                style:
                    TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              subtitle:
                  const Text(
                'صور الفواتير والإيصالات وملفات PDF',
              ),
              trailing:
                  const Icon(
                Icons.chevron_left,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        TransactionAttachmentsScreen(
                      transaction:
                          transaction,
                    ),
                  ),
                );
              },
            ),
          ),

          if (transaction.description !=
                  null ||
              transaction.notes != null) ...[
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    if (transaction
                            .description !=
                        null)
                      Text(
                        'البيان: ${transaction.description}',
                      ),
                    if (transaction.notes !=
                        null) ...[
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'ملاحظات: ${transaction.notes}',
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
