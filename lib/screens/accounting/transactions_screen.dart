import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/accounting_transaction_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/auth_provider.dart';
import 'transaction_details_screen.dart';
import 'transaction_form_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() =>
      _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<AccountingProvider>().load(),
    );
  }

  Future<void> _add() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const TransactionFormScreen(),
      ),
    );

    if (changed == true && mounted) {
      await context.read<AccountingProvider>().load();
    }
  }

  bool _regularEditableType(String type) {
    return const {
      'customer_collection',
      'supplier_payment',
      'expense',
      'other_income',
      'worker_salary_accrual',
      'worker_salary_payment',
      'worker_advance',
      'worker_advance_recovery',
      'worker_deduction',
      'transfer',
    }.contains(type);
  }

  Future<void> _edit(
    AccountingTransactionModel item,
  ) async {
    if (!_regularEditableType(item.type)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'المبيعات والمشتريات التي تحتوي بنودًا لا تُعدّل من هذا النموذج. استخدم القيد العكسي ثم أعد إدخال العملية.',
          ),
        ),
      );
      return;
    }

    if (item.status == 'syncing') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'المزامنة جارية الآن. انتظر لحظة ثم اضغط تعديل مرة أخرى.',
          ),
        ),
      );
      return;
    }

    if (!const {
      'posted',
      'pending_sync',
      'failed',
    }.contains(item.status)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'لا يمكن تعديل الحركة في حالتها الحالية.',
          ),
        ),
      );
      return;
    }

    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionFormScreen(
          initialType: item.type,
          transaction: item,
        ),
      ),
    );

    if (changed == true && mounted) {
      await context.read<AccountingProvider>().load();
    }
  }

  Future<void> _reverse(
    AccountingTransactionModel item,
  ) async {
    final reasonController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('قيد عكسي'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'سيتم إنشاء قيد عكسي للحركة ${item.transactionNo}. لن يتم حذف الحركة الأصلية.',
              ),
              const SizedBox(height: 14),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'سبب العكس - اختياري',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(
                dialogContext,
                false,
              ),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(
                dialogContext,
                true,
              ),
              child: const Text('إنشاء القيد العكسي'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      reasonController.dispose();
      return;
    }

    final provider = context.read<AccountingProvider>();
    final success = await provider.reverse(
      transactionId: item.id,
      reason: reasonController.text,
    );

    reasonController.dispose();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'تم إنشاء القيد العكسي.'
              : provider.error ?? 'تعذر عكس الحركة.',
        ),
      ),
    );
  }

  String _typeLabel(String type) {
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

  String _related(AccountingTransactionModel item) {
    if (item.partyName != null) return item.partyName!;
    if (item.workerName != null) return item.workerName!;

    if (item.financialAccountName != null) {
      if (item.targetFinancialAccountName != null) {
        return '${item.financialAccountName} ← ${item.targetFinancialAccountName}';
      }
      return item.financialAccountName!;
    }

    return item.categoryName ?? '';
  }

  String _dateTime(DateTime value) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(value.day)}/${two(value.month)}/${value.year}  '
        '${two(value.hour)}:${two(value.minute)}';
  }

  String _statusText(AccountingTransactionModel item) {
    if (item.status == 'pending_sync') {
      return 'محفوظة محليًا - بانتظار المزامنة';
    }
    if (item.status == 'syncing') {
      return 'جارٍ المزامنة';
    }
    if (item.status == 'failed') {
      return 'فشلت المزامنة - يمكن تعديلها ثم إعادة المزامنة';
    }
    if (item.status == 'reversed') {
      return 'معكوسة';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AccountingProvider>();
    final user = context.watch<AuthProvider>().user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الحركات'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: provider.submitting ? null : _add,
        icon: const Icon(Icons.add),
        label: const Text('حركة جديدة'),
      ),
      body: RefreshIndicator(
        onRefresh: provider.load,
        child: Builder(
          builder: (context) {
            if (provider.loading && provider.transactions.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.error != null && provider.transactions.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const SizedBox(height: 70),
                  Text(
                    provider.error!,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }

            if (provider.transactions.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(24),
                children: const [
                  SizedBox(height: 70),
                  Icon(Icons.receipt_long_outlined, size: 60),
                  SizedBox(height: 12),
                  Text(
                    'لا توجد حركات محاسبية بعد.',
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
              itemCount: provider.transactions.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = provider.transactions[index];
                final amount = MoneyUtils.formatMinor(
                  item.amountMinor,
                  item.currencyDecimalPlaces,
                );

                final statusText = _statusText(item);
                final canReverse = user.isManager &&
                    item.status == 'posted' &&
                    item.type != 'reversal';
                final canShowEdit = user.isManager &&
                    item.type != 'reversal' &&
                    item.status != 'reversed';

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        ListTile(
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
                          leading: CircleAvatar(
                            child: Icon(
                              item.type == 'reversal'
                                  ? Icons.undo_outlined
                                  : Icons.receipt_long_outlined,
                            ),
                          ),
                          title: Text(
                            '${_typeLabel(item.type)} • $amount ${item.currencySymbol}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${_dateTime(item.occurredAt)}\n'
                            '${item.transactionNo}'
                            '${_related(item).isEmpty ? '' : '\n${_related(item)}'}'
                            '${item.items.isEmpty ? '' : '\n${item.items.length} بند'}'
                            '${statusText.isEmpty ? '' : '\n$statusText'}',
                          ),
                          isThreeLine: true,
                          trailing: const Icon(Icons.chevron_left),
                        ),
                        if (canShowEdit || canReverse)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Row(
                              children: [
                                if (canShowEdit)
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: provider.submitting
                                          ? null
                                          : () => _edit(item),
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        size: 18,
                                      ),
                                      label: const Text('تعديل'),
                                    ),
                                  ),
                                if (canShowEdit && canReverse)
                                  const SizedBox(width: 8),
                                if (canReverse)
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: provider.submitting
                                          ? null
                                          : () => _reverse(item),
                                      icon: const Icon(
                                        Icons.undo_outlined,
                                        size: 18,
                                      ),
                                      label: const Text('قيد عكسي'),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
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
