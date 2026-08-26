import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/accounting_transaction_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/auth_provider.dart';
import 'transaction_form_screen.dart';
import 'transaction_details_screen.dart';

class TransactionsScreen
    extends StatefulWidget {
  const TransactionsScreen({
    super.key,
  });

  @override
  State<TransactionsScreen>
      createState() =>
          _TransactionsScreenState();
}

class _TransactionsScreenState
    extends State<TransactionsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) => context
          .read<AccountingProvider>()
          .load(),
    );
  }

  Future<void> _add() async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const TransactionFormScreen(),
      ),
    );

    if (changed == true &&
        mounted) {
      await context
          .read<AccountingProvider>()
          .load();
    }
  }

  Future<void> _reverse(
    AccountingTransactionModel item,
  ) async {
    final reasonController =
        TextEditingController();

    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'عكس الحركة',
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Text(
                'سيتم إنشاء قيد عكسي للحركة ${item.transactionNo}. لن يتم حذفها.',
              ),
              const SizedBox(
                height: 14,
              ),
              TextField(
                controller:
                    reasonController,
                maxLines: 3,
                decoration:
                    const InputDecoration(
                  labelText:
                      'سبب العكس - اختياري',
                  border:
                      OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                dialogContext,
                false,
              ),
              child:
                  const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.pop(
                dialogContext,
                true,
              ),
              child:
                  const Text('عكس'),
            ),
          ],
        );
      },
    );

    if (confirmed != true ||
        !mounted) {
      reasonController.dispose();
      return;
    }

    final provider =
        context.read<
            AccountingProvider>();

    final success =
        await provider.reverse(
      transactionId: item.id,
      reason:
          reasonController.text,
    );

    reasonController.dispose();

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'تم إنشاء القيد العكسي.'
              : provider.error ??
                  'تعذر عكس الحركة.',
        ),
      ),
    );
  }

  String _typeLabel(
    String type,
  ) {
    switch (type) {
      case 'sale':
        return 'بيع';
      case 'purchase':
        return 'شراء';
      case 'inventory_opening_balance':
        return 'مخزون افتتاحي';
      case 'customer_collection':
        return 'تحصيل عميل';
      case 'supplier_payment':
        return 'دفع مورد';
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
      case 'customer_opening_balance':
        return 'رصيد افتتاحي عميل';
      case 'supplier_opening_balance':
        return 'رصيد افتتاحي مورد';
      case 'worker_opening_payable':
        return 'مستحق افتتاحي عامل';
      case 'worker_opening_advance':
        return 'سلفة افتتاحية عامل';
      case 'financial_account_opening_balance':
        return 'رصيد افتتاحي حساب مالي';
      case 'transfer':
        return 'تحويل';
      case 'reversal':
        return 'قيد عكسي';
      default:
        return type;
    }
  }

  String _related(
    AccountingTransactionModel item,
  ) {
    if (item.partyName != null) {
      return item.partyName!;
    }

    if (item.workerName != null) {
      return item.workerName!;
    }

    if (item.financialAccountName !=
        null) {
      if (
        item.targetFinancialAccountName !=
            null
      ) {
        return '${item.financialAccountName} ← ${item.targetFinancialAccountName}';
      }

      return item.financialAccountName!;
    }

    return item.categoryName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<
            AccountingProvider>();

    final user =
        context.watch<AuthProvider>().user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سجل الحركات',
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            provider.submitting
                ? null
                : _add,
        icon: const Icon(
          Icons.add,
        ),
        label:
            const Text('حركة جديدة'),
      ),
      body: RefreshIndicator(
        onRefresh: provider.load,
        child: Builder(
          builder: (context) {
            if (provider.loading &&
                provider
                    .transactions
                    .isEmpty) {
              return const Center(
                child:
                    CircularProgressIndicator(),
              );
            }

            if (provider.error !=
                    null &&
                provider
                    .transactions
                    .isEmpty) {
              return ListView(
                padding:
                    const EdgeInsets.all(
                  24,
                ),
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    provider.error!,
                    textAlign:
                        TextAlign.center,
                  ),
                ],
              );
            }

            if (provider
                .transactions
                .isEmpty) {
              return ListView(
                padding:
                    const EdgeInsets.all(
                  24,
                ),
                children: const [
                  SizedBox(
                    height: 70,
                  ),
                  Icon(
                    Icons
                        .receipt_long_outlined,
                    size: 60,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'لا توجد حركات محاسبية بعد.',
                    textAlign:
                        TextAlign.center,
                  ),
                ],
              );
            }

            return ListView.separated(
              padding:
                  const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                100,
              ),
              itemCount: provider
                  .transactions
                  .length,
              separatorBuilder:
                  (_, _) =>
                      const SizedBox(
                height: 8,
              ),
              itemBuilder:
                  (context, index) {
                final item =
                    provider
                            .transactions[
                        index];

                final amount =
                    MoneyUtils
                        .formatMinor(
                  item.amountMinor,
                  item
                      .currencyDecimalPlaces,
                );

                final reversed =
                    item.status ==
                        'reversed';

                final pending =
                    item.status ==
                            'pending_sync' ||
                        item.status ==
                            'syncing';

                final failed =
                    item.status ==
                        'failed';

                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              TransactionDetailsScreen(
                            transaction: item,
                          ),
                        ),
                      );
                    },
                    leading:
                        CircleAvatar(
                      child: Icon(
                        item.type ==
                                'reversal'
                            ? Icons
                                .undo_outlined
                            : Icons
                                .receipt_long_outlined,
                      ),
                    ),
                    title: Text(
                      '${_typeLabel(item.type)} • $amount ${item.currencySymbol}',
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${item.transactionNo}'
                      '${_related(item).isEmpty ? '' : '\n${_related(item)}'}'
                      '${item.items.isEmpty ? '' : '\n${item.items.length} بند'}'
                      '${item.type == 'sale' && item.grossProfitMinor != null ? '\nربح إجمالي: ${MoneyUtils.formatMinor(item.grossProfitMinor!, item.currencyDecimalPlaces)} ${item.currencySymbol}' : ''}'
                      '${item.type == 'sale' && item.costStatus == 'incomplete' ? '\nالربح: بيانات التكلفة غير مكتملة' : ''}'
                      '${pending ? '\nمحفوظة محليًا - بانتظار المزامنة' : ''}'
                      '${failed ? '\nفشلت المزامنة - اضغط لعرض الخطأ' : ''}'
                      '${reversed ? '\nمعكوسة' : ''}',
                    ),
                    isThreeLine: true,
                    trailing:
                        user.isManager &&
                                item.status ==
                                    'posted' &&
                                item.type !=
                                    'reversal'
                            ? IconButton(
                                tooltip:
                                    'عكس الحركة',
                                onPressed:
                                    provider.submitting
                                        ? null
                                        : () => _reverse(item),
                                icon:
                                    const Icon(
                                  Icons
                                      .undo_outlined,
                                ),
                              )
                            : Icon(
                                failed
                                    ? Icons
                                        .sync_problem_outlined
                                    : pending
                                        ? Icons
                                            .cloud_upload_outlined
                                        : reversed
                                            ? Icons
                                                .block
                                            : Icons
                                                .chevron_left,
                              ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
