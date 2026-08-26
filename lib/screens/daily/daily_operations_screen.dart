import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/accounting_transaction_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/reference_data_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/sync_provider.dart';
import '../accounting/transaction_form_screen.dart';
import '../accounting/transactions_screen.dart';
import '../commerce/sale_purchase_form_screen.dart';
import '../commerce/simple_sale_screen.dart';

class DailyOperationsScreen
    extends StatefulWidget {
  const DailyOperationsScreen({
    super.key,
  });

  @override
  State<DailyOperationsScreen>
      createState() =>
          _DailyOperationsScreenState();
}

class _DailyOperationsScreenState
    extends State<DailyOperationsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) => _load(),
    );
  }

  Future<void> _load() async {
    await Future.wait([
      context
          .read<AccountingProvider>()
          .load(),
      context
          .read<ReferenceDataProvider>()
          .load(),
      context
          .read<SyncProvider>()
          .refreshCounts(),
    ]);
  }

  bool _isToday(
    DateTime value,
  ) {
    final now = DateTime.now();
    final local = value.toLocal();

    return local.year == now.year &&
        local.month == now.month &&
        local.day == now.day;
  }

  List<AccountingTransactionModel>
      _todayTransactions(
    List<AccountingTransactionModel>
        all,
  ) {
    return all
        .where(
          (item) =>
              _isToday(item.occurredAt),
        )
        .toList();
  }

  Map<int, _DailyCurrencySummary>
      _summaries(
    List<AccountingTransactionModel>
        transactions,
  ) {
    final result =
        <int, _DailyCurrencySummary>{};

    for (final item in transactions) {
      final summary =
          result.putIfAbsent(
        item.currencyId,
        () => _DailyCurrencySummary(
          currencyId: item.currencyId,
          code: item.currencyCode,
          symbol: item.currencySymbol,
          decimalPlaces:
              item.currencyDecimalPlaces,
        ),
      );

      if (
        item.status == 'reversed' ||
        item.status == 'failed'
      ) {
        continue;
      }

      switch (item.type) {
        case 'sale':
          summary.sales +=
              item.amountMinor;
          summary.cashIn +=
              item.paidNowMinor;
          break;

        case 'purchase':
          summary.purchases +=
              item.amountMinor;
          summary.cashOut +=
              item.paidNowMinor;
          break;

        case 'customer_collection':
          summary.collections +=
              item.amountMinor;
          summary.cashIn +=
              item.amountMinor;
          break;

        case 'supplier_payment':
          summary.supplierPayments +=
              item.amountMinor;
          summary.cashOut +=
              item.amountMinor;
          break;

        case 'expense':
          summary.expenses +=
              item.amountMinor;
          summary.cashOut +=
              item.amountMinor;
          break;

        case 'other_income':
          summary.otherIncome +=
              item.amountMinor;
          summary.cashIn +=
              item.amountMinor;
          break;

        case 'worker_salary_payment':
          summary.workerPayments +=
              item.amountMinor;
          summary.cashOut +=
              item.amountMinor;
          break;

        case 'worker_advance':
          summary.workerAdvances +=
              item.amountMinor;
          summary.cashOut +=
              item.amountMinor;
          break;

        case 'worker_advance_recovery':
          summary.advanceRecovery +=
              item.amountMinor;
          summary.cashIn +=
              item.amountMinor;
          break;

        // Internal transfers and accrual-only entries
        // are intentionally excluded from business
        // cash in/out totals.
        case 'transfer':
        case 'worker_salary_accrual':
        case 'worker_deduction':
        case 'customer_opening_balance':
        case 'supplier_opening_balance':
        case 'worker_opening_payable':
        case 'worker_opening_advance':
        case 'financial_account_opening_balance':
        case 'inventory_opening_balance':
        case 'reversal':
          break;
      }
    }

    return result;
  }

  Future<void> _openTransaction(
    String type,
  ) async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            TransactionFormScreen(
          initialType: type,
        ),
      ),
    );

    if (
      changed == true &&
      mounted
    ) {
      await _load();
    }
  }

  Future<void> _openSale() async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const SimpleSaleScreen(),
      ),
    );

    if (
      changed == true &&
      mounted
    ) {
      await _load();
    }
  }

  Future<void> _openPurchase() async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const SalePurchaseFormScreen(
          isSale: false,
        ),
      ),
    );

    if (
      changed == true &&
      mounted
    ) {
      await _load();
    }
  }

  Future<void> _syncNow() async {
    final result =
        await context
            .read<SyncProvider>()
            .syncNow(
              includeFailed: true,
            );

    if (
      (result.synced > 0 || result.failed > 0) &&
      mounted
    ) {
      await context
          .read<AccountingProvider>()
          .load();

      if (mounted) {
        await context
            .read<ProductProvider>()
            .load();
      }
    }

    if (!mounted) {
      return;
    }

    final message =
        context
            .read<SyncProvider>()
            .lastMessage;

    if (
      message != null &&
      message.isNotEmpty
    ) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  String _typeLabel(
    String type,
  ) {
    switch (type) {
      case 'sale':
        return 'بيع';
      case 'purchase':
        return 'شراء';
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
      case 'transfer':
        return 'تحويل داخلي';
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

    if (item.categoryName != null) {
      return item.categoryName!;
    }

    if (
      item.financialAccountName !=
      null
    ) {
      return item.financialAccountName!;
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    final accounting =
        context.watch<
            AccountingProvider>();

    final sync =
        context.watch<
            SyncProvider>();

    final today =
        _todayTransactions(
      accounting.transactions,
    );

    final summaries =
        _summaries(today)
            .values
            .toList()
          ..sort(
            (a, b) =>
                a.code.compareTo(
                  b.code,
                ),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الحركات اليومية',
        ),
        actions: [
          IconButton(
            tooltip:
                sync.attentionCount > 0
                    ? 'مزامنة ${sync.attentionCount} حركة'
                    : 'مزامنة',
            onPressed:
                sync.syncing
                    ? null
                    : _syncNow,
            icon: Icon(
              sync.failed > 0
                  ? Icons
                      .sync_problem_outlined
                  : Icons.sync,
            ),
          ),
          IconButton(
            tooltip:
                'كل الحركات',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      const TransactionsScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons
                  .receipt_long_outlined,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding:
              const EdgeInsets.all(
            16,
          ),
          children: [
            if (sync.attentionCount > 0) ...[
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    14,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        sync.failed > 0
                            ? Icons
                                .sync_problem_outlined
                            : Icons
                                .cloud_upload_outlined,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          sync.failed > 0
                              ? '${sync.pending} بانتظار المزامنة • ${sync.failed} تحتاج إعادة محاولة'
                              : '${sync.pending} حركة محفوظة محليًا بانتظار المزامنة',
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed:
                            sync.syncing
                                ? null
                                : _syncNow,
                        child: Text(
                          sync.syncing
                              ? 'جارٍ...'
                              : 'مزامنة',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],

            Text(
              'إضافة سريعة',
              style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
            ),

            const SizedBox(
              height: 12,
            ),

            GridView.count(
              crossAxisCount:
                  MediaQuery.sizeOf(
                                context,
                              )
                              .width >
                          700
                      ? 4
                      : 2,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.7,
              children: [
                _QuickAction(
                  icon: Icons
                      .point_of_sale_outlined,
                  title: 'بيع',
                  subtitle:
                      'بدون أصناف',
                  onTap: _openSale,
                ),
                _QuickAction(
                  icon: Icons
                      .payments_outlined,
                  title: 'مصروف',
                  subtitle:
                      'مصروف يومي',
                  onTap: () =>
                      _openTransaction(
                    'expense',
                  ),
                ),
                _QuickAction(
                  icon: Icons
                      .person_pin_circle_outlined,
                  title:
                      'تحصيل عميل',
                  subtitle:
                      'تخفيض المديونية',
                  onTap: () =>
                      _openTransaction(
                    'customer_collection',
                  ),
                ),
                _QuickAction(
                  icon: Icons
                      .local_shipping_outlined,
                  title: 'دفع مورد',
                  subtitle:
                      'تسديد ذمة مورد',
                  onTap: () =>
                      _openTransaction(
                    'supplier_payment',
                  ),
                ),
                _QuickAction(
                  icon: Icons
                      .shopping_cart_outlined,
                  title: 'شراء',
                  subtitle:
                      'شراء بضاعة',
                  onTap:
                      _openPurchase,
                ),
                _QuickAction(
                  icon: Icons
                      .add_card_outlined,
                  title: 'دخل آخر',
                  subtitle:
                      'دخل غير البيع',
                  onTap: () =>
                      _openTransaction(
                    'other_income',
                  ),
                ),
                _QuickAction(
                  icon: Icons
                      .badge_outlined,
                  title: 'دفع راتب',
                  subtitle:
                      'دفع للعامل',
                  onTap: () =>
                      _openTransaction(
                    'worker_salary_payment',
                  ),
                ),
                _QuickAction(
                  icon: Icons
                      .money_off_csred_outlined,
                  title: 'سلفة عامل',
                  subtitle:
                      'سلفة جديدة',
                  onTap: () =>
                      _openTransaction(
                    'worker_advance',
                  ),
                ),
                _QuickAction(
                  icon: Icons
                      .request_quote_outlined,
                  title:
                      'استحقاق راتب',
                  subtitle:
                      'تسجيل المستحق',
                  onTap: () =>
                      _openTransaction(
                    'worker_salary_accrual',
                  ),
                ),
                _QuickAction(
                  icon: Icons
                      .swap_horiz_outlined,
                  title: 'تحويل',
                  subtitle:
                      'بين الحسابات',
                  onTap: () =>
                      _openTransaction(
                    'transfer',
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            Text(
              'ملخص اليوم',
              style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
            ),

            const SizedBox(
              height: 10,
            ),

            if (
              accounting.loading &&
              accounting
                  .transactions
                  .isEmpty
            )
              const Center(
                child:
                    CircularProgressIndicator(),
              )
            else if (
              summaries.isEmpty
            )
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(
                    18,
                  ),
                  child: Text(
                    'لا توجد حركة مالية مسجلة اليوم.',
                    textAlign:
                        TextAlign.center,
                  ),
                ),
              )
            else
              ...summaries.map(
                (summary) =>
                    Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child:
                      _SummaryCard(
                    summary: summary,
                  ),
                ),
              ),

            const SizedBox(
              height: 18,
            ),

            Row(
              children: [
                Expanded(
                  child: Text(
                    'آخر حركات اليوم',
                    style:
                        Theme.of(
                          context,
                        )
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const TransactionsScreen(),
                      ),
                    );
                  },
                  child:
                      const Text(
                    'عرض الكل',
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),

            if (today.isEmpty)
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(
                    16,
                  ),
                  child: Text(
                    'لا توجد حركات اليوم.',
                  ),
                ),
              )
            else
              ...today
                  .take(12)
                  .map(
                    (item) =>
                        Card(
                      margin:
                          const EdgeInsets
                              .only(
                        bottom: 8,
                      ),
                      child:
                          ListTile(
                        leading:
                            CircleAvatar(
                          child:
                              Icon(
                            item.type ==
                                    'expense'
                                ? Icons
                                    .arrow_upward
                                : Icons
                                    .receipt_long_outlined,
                          ),
                        ),
                        title: Text(
                          '${_typeLabel(item.type)} • '
                          '${MoneyUtils.formatMinor(item.amountMinor, item.currencyDecimalPlaces)} '
                          '${item.currencySymbol}',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        subtitle: Text(
                          '${item.transactionNo}'
                          '${_related(item).isEmpty ? '' : '\n${_related(item)}'}'
                          '${item.status == 'pending_sync' || item.status == 'syncing' ? '\nمحفوظة محليًا - بانتظار المزامنة' : ''}'
                          '${item.status == 'failed' ? '\nفشلت المزامنة - افتح سجل الحركات للتفاصيل' : ''}',
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        child: Padding(
          padding:
              const EdgeInsets.all(
            12,
          ),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(icon),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          Theme.of(
                            context,
                          )
                              .textTheme
                              .bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard
    extends StatelessWidget {
  final _DailyCurrencySummary
      summary;

  const _SummaryCard({
    required this.summary,
  });

  String _money(
    int value,
  ) {
    return '${MoneyUtils.formatMinor(value, summary.decimalPlaces)} ${summary.symbol}';
  }

  @override
  Widget build(BuildContext context) {
    final net =
        summary.cashIn -
        summary.cashOut;

    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            Text(
              summary.code,
              style:
                  const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            _SummaryRow(
              title:
                  'الدخل النقدي',
              value:
                  _money(
                summary.cashIn,
              ),
            ),
            _SummaryRow(
              title:
                  'الخروج النقدي',
              value:
                  _money(
                summary.cashOut,
              ),
            ),
            const Divider(),
            _SummaryRow(
              title:
                  'صافي الحركة النقدية',
              value: _money(net),
              bold: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MiniValue(
                  label: 'المبيعات',
                  value:
                      _money(
                    summary.sales,
                  ),
                ),
                _MiniValue(
                  label:
                      'التحصيلات',
                  value:
                      _money(
                    summary.collections,
                  ),
                ),
                _MiniValue(
                  label:
                      'المصروفات',
                  value:
                      _money(
                    summary.expenses,
                  ),
                ),
                _MiniValue(
                  label:
                      'المشتريات',
                  value:
                      _money(
                    summary.purchases,
                  ),
                ),
                _MiniValue(
                  label:
                      'دفع الموردين',
                  value:
                      _money(
                    summary.supplierPayments,
                  ),
                ),
                _MiniValue(
                  label:
                      'دفعات العمال',
                  value:
                      _money(
                    summary.workerPayments,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow
    extends StatelessWidget {
  final String title;
  final String value;
  final bool bold;

  const _SummaryRow({
    required this.title,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: bold
                  ? const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    )
                  : null,
            ),
          ),
          Text(
            value,
            style: bold
                ? const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _MiniValue
    extends StatelessWidget {
  final String label;
  final String value;

  const _MiniValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        '$label: $value',
      ),
    );
  }
}

class _DailyCurrencySummary {
  final int currencyId;
  final String code;
  final String symbol;
  final int decimalPlaces;

  int cashIn = 0;
  int cashOut = 0;

  int sales = 0;
  int purchases = 0;
  int collections = 0;
  int supplierPayments = 0;
  int expenses = 0;
  int otherIncome = 0;
  int workerPayments = 0;
  int workerAdvances = 0;
  int advanceRecovery = 0;

  _DailyCurrencySummary({
    required this.currencyId,
    required this.code,
    required this.symbol,
    required this.decimalPlaces,
  });
}
