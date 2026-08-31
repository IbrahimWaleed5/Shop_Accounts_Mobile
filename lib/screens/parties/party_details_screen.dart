import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/accounting_transaction_model.dart';
import '../../models/ledger_balance_model.dart';
import '../../models/party_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/ledger_provider.dart';
import '../../providers/party_provider.dart';
import 'party_form_screen.dart';

class PartyDetailsScreen extends StatefulWidget {
  final PartyModel party;

  const PartyDetailsScreen({
    super.key,
    required this.party,
  });

  @override
  State<PartyDetailsScreen> createState() =>
      _PartyDetailsScreenState();
}

class _PartyDetailsScreenState extends State<PartyDetailsScreen> {
  PartyModel get party => widget.party;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshAll();
    });
  }

  Future<void> _refreshAll() async {
    await Future.wait([
      context.read<LedgerProvider>().loadParty(party.id),
      context.read<AccountingProvider>().loadPartyStatement(party.id),
    ]);
  }

  String _typeLabel() {
    switch (party.type) {
      case 'customer':
        return 'عميل';
      case 'supplier':
        return 'مورد';
      default:
        return 'عميل ومورد';
    }
  }

  String _movementLabel(String type) {
    switch (type) {
      case 'sale':
        return 'مبيعات';
      case 'purchase':
        return 'مشتريات';
      case 'customer_collection':
        return 'تحصيل من العميل';
      case 'supplier_payment':
        return 'تسديد للمورد';
      case 'customer_opening_balance':
        return 'رصيد افتتاحي على العميل';
      case 'supplier_opening_balance':
        return 'رصيد افتتاحي للمورد';
      case 'reversal':
        return 'قيد عكسي';
      default:
        return type;
    }
  }

  String _dateTime(DateTime value) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(value.day)}/${two(value.month)}/${value.year}  '
        '${two(value.hour)}:${two(value.minute)}';
  }

  Future<void> _edit() async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PartyFormScreen(
          initialType: party.type,
          party: party,
        ),
      ),
    );

    if (changed == true && mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _toggleStatus() async {
    final provider = context.read<PartyProvider>();
    final success = await provider.setStatus(
      partyId: party.id,
      isActive: !party.isActive,
    );

    if (!mounted) return;

    if (success) {
      Navigator.pop(context, true);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          provider.error ?? 'تعذر تعديل الحساب.',
        ),
      ),
    );
  }

  Widget _balanceList({
    required String title,
    required List<LedgerBalanceModel> balances,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (balances.isEmpty)
              const Text('لا يوجد رصيد مرحّل.')
            else
              ...balances.map(
                (balance) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(child: Text(balance.currencyCode)),
                      Text(
                        '${MoneyUtils.formatMinor(balance.balanceMinor, balance.decimalPlaces)} ${balance.currencySymbol}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  int _customerEffect(
    AccountingTransactionModel tx,
    Map<int, AccountingTransactionModel> byId,
  ) {
    switch (tx.type) {
      case 'customer_opening_balance':
        return tx.amountMinor;
      case 'sale':
        return tx.amountMinor - tx.paidNowMinor;
      case 'customer_collection':
        return -tx.amountMinor;
      case 'reversal':
        final original = tx.reversalOfId == null
            ? null
            : byId[tx.reversalOfId];
        return original == null
            ? 0
            : -_customerEffect(original, const {});
      default:
        return 0;
    }
  }

  int _supplierEffect(
    AccountingTransactionModel tx,
    Map<int, AccountingTransactionModel> byId,
  ) {
    switch (tx.type) {
      case 'supplier_opening_balance':
        return tx.amountMinor;
      case 'purchase':
        return tx.amountMinor - tx.paidNowMinor;
      case 'supplier_payment':
        return -tx.amountMinor;
      case 'reversal':
        final original = tx.reversalOfId == null
            ? null
            : byId[tx.reversalOfId];
        return original == null
            ? 0
            : -_supplierEffect(original, const {});
      default:
        return 0;
    }
  }

  List<_StatementRow> _statementRows(
    List<AccountingTransactionModel> source,
  ) {
    final items = source
        .where(
          (item) =>
              item.partyId == party.id &&
              item.status != 'reversed_pending',
        )
        .toList()
      ..sort((a, b) {
        final date = a.occurredAt.compareTo(b.occurredAt);
        if (date != 0) return date;
        return a.id.compareTo(b.id);
      });

    final byId = <int, AccountingTransactionModel>{
      for (final item in items)
        if (item.id > 0) item.id: item,
    };

    var customerBalance = 0;
    var supplierBalance = 0;
    final result = <_StatementRow>[];

    for (final item in items) {
      customerBalance += _customerEffect(item, byId);
      supplierBalance += _supplierEffect(item, byId);

      result.add(
        _StatementRow(
          transaction: item,
          customerBalanceMinor: customerBalance,
          supplierBalanceMinor: supplierBalance,
        ),
      );
    }

    return result.reversed.toList();
  }

  String _statusLabel(AccountingTransactionModel tx) {
    switch (tx.status) {
      case 'pending_sync':
        return 'Offline - بانتظار المزامنة';
      case 'syncing':
        return 'جارٍ المزامنة';
      case 'failed':
        return 'تحتاج إعادة مزامنة';
      case 'reversed':
        return 'تم عكسها';
      case 'reversed_pending':
        return 'تم تسجيل عكس/تصحيح محليًا';
      default:
        return 'مرحلة';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AuthProvider>().user!;
    final ledgerProvider = context.watch<LedgerProvider>();
    final accounting = context.watch<AccountingProvider>();
    final ledger = ledgerProvider.partyLedger(party.id);
    final rows = _statementRows(
      accounting.partyStatement(party.id),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(party.name),
        actions: [
          IconButton(
            tooltip: 'تحديث كامل',
            onPressed: ledgerProvider.loading || accounting.loading
                ? null
                : _refreshAll,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'تعديل بيانات الشخص',
            onPressed: _edit,
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshAll,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      party.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${_typeLabel()} • ${party.isActive ? 'فعال' : 'معطل'}',
                    ),
                    if (party.phone != null &&
                        party.phone!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text('الهاتف: ${party.phone}'),
                    ],
                    if (party.address != null &&
                        party.address!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text('العنوان: ${party.address}'),
                    ],
                    if (party.notes != null &&
                        party.notes!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text('ملاحظات: ${party.notes}'),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'الرصيد الحالي',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (ledgerProvider.loading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            if (ledger != null) ...[
              if (party.isCustomer)
                _balanceList(
                  title: 'المبالغ المستحقة على العميل',
                  balances: ledger.receivable,
                  icon: Icons.arrow_downward_rounded,
                ),
              if (party.isCustomer && party.isSupplier)
                const SizedBox(height: 10),
              if (party.isSupplier)
                _balanceList(
                  title: 'المبالغ المستحقة للمورد',
                  balances: ledger.payable,
                  icon: Icons.arrow_upward_rounded,
                ),
            ] else if (ledgerProvider.error != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(ledgerProvider.error!),
                ),
              ),

            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'كشف الحساب الكامل',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (accounting.loading)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              accounting.fromLocal
                  ? 'يعرض الآن الحركات المحفوظة على هذا الجهاز (Offline).'
                  : 'يشمل المبيعات والمشتريات والآجل والتحصيلات والتسديدات والقيود العكسية.',
            ),
            const SizedBox(height: 10),

            if (accounting.error != null && rows.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(accounting.error!),
                ),
              )
            else if (rows.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'لا توجد حركات لهذا الشخص حتى الآن.',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...rows.map((row) {
                final tx = row.transaction;
                final amount = MoneyUtils.formatMinor(
                  tx.amountMinor,
                  tx.currencyDecimalPlaces,
                );
                final credit = tx.amountMinor - tx.paidNowMinor;

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                _movementLabel(tx.type),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '$amount ${tx.currencySymbol}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(_dateTime(tx.occurredAt)),
                        Text('رقم الحركة: ${tx.transactionNo}'),
                        if ((tx.type == 'sale' || tx.type == 'purchase') &&
                            credit > 0)
                          Text(
                            'المبلغ الآجل: ${MoneyUtils.formatMinor(credit, tx.currencyDecimalPlaces)} ${tx.currencySymbol}',
                          ),
                        if (tx.description != null &&
                            tx.description!.trim().isNotEmpty)
                          Text('البيان: ${tx.description}'),
                        const SizedBox(height: 8),
                        Text(
                          _statusLabel(tx),
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Divider(height: 18),
                        if (party.isCustomer)
                          Text(
                            'رصيد العميل بعد الحركة: ${MoneyUtils.formatMinor(row.customerBalanceMinor, tx.currencyDecimalPlaces)} ${tx.currencySymbol}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (party.isSupplier)
                          Text(
                            'رصيد المورد بعد الحركة: ${MoneyUtils.formatMinor(row.supplierBalanceMinor, tx.currencyDecimalPlaces)} ${tx.currencySymbol}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),

            if (currentUser.isManager) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _toggleStatus,
                icon: Icon(
                  party.isActive
                      ? Icons.block
                      : Icons.check_circle_outline,
                ),
                label: Text(
                  party.isActive
                      ? 'تعطيل السجل'
                      : 'تفعيل السجل',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatementRow {
  final AccountingTransactionModel transaction;
  final int customerBalanceMinor;
  final int supplierBalanceMinor;

  const _StatementRow({
    required this.transaction,
    required this.customerBalanceMinor,
    required this.supplierBalanceMinor,
  });
}
