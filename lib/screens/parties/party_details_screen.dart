import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/ledger_balance_model.dart';
import '../../models/party_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/ledger_provider.dart';
import '../../providers/party_provider.dart';
import 'party_form_screen.dart';

class PartyDetailsScreen
    extends StatefulWidget {
  final PartyModel party;

  const PartyDetailsScreen({
    super.key,
    required this.party,
  });

  @override
  State<PartyDetailsScreen>
      createState() =>
          _PartyDetailsScreenState();
}

class _PartyDetailsScreenState
    extends State<PartyDetailsScreen> {
  PartyModel get party =>
      widget.party;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<LedgerProvider>()
          .loadParty(party.id);
    });
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

  Future<void> _edit() async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PartyFormScreen(
          initialType: party.type,
          party: party,
        ),
      ),
    );

    if (changed == true &&
        mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _toggleStatus() async {
    final provider =
        context.read<PartyProvider>();

    final success =
        await provider.setStatus(
      partyId: party.id,
      isActive: !party.isActive,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.pop(context, true);
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          provider.error ??
              'تعذر تعديل الحساب.',
        ),
      ),
    );
  }

  Widget _balanceList({
    required String title,
    required List<
            LedgerBalanceModel>
        balances,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style:
                        const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (balances.isEmpty)
              const Text(
                'لا يوجد رصيد مرحّل.',
              )
            else
              ...balances.map(
                (balance) =>
                    Padding(
                  padding:
                      const EdgeInsets
                          .only(
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          balance
                              .currencyCode,
                        ),
                      ),
                      Text(
                        '${MoneyUtils.formatMinor(balance.balanceMinor, balance.decimalPlaces)} ${balance.currencySymbol}',
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,
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

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.watch<AuthProvider>().user!;

    final ledgerProvider =
        context.watch<LedgerProvider>();

    final ledger =
        ledgerProvider.partyLedger(
      party.id,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(party.name),
        actions: [
          IconButton(
            tooltip:
                'تحديث الرصيد',
            onPressed:
                ledgerProvider.loading
                    ? null
                    : () {
                        context
                            .read<
                                LedgerProvider>()
                            .loadParty(
                              party.id,
                            );
                      },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
          IconButton(
            tooltip: 'تعديل',
            onPressed: _edit,
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(20),
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
                    party.name,
                    style:
                        const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '${_typeLabel()} • ${party.isActive ? 'فعال' : 'معطل'}',
                  ),
                  if (party.phone != null &&
                      party.phone!
                          .isNotEmpty) ...[
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'الهاتف: ${party.phone}',
                    ),
                  ],
                  if (party.address !=
                          null &&
                      party.address!
                          .isNotEmpty) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'العنوان: ${party.address}',
                    ),
                  ],
                  if (party.notes != null &&
                      party.notes!
                          .isNotEmpty) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'ملاحظات: ${party.notes}',
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'الرصيد الحالي',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
              if (ledgerProvider.loading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child:
                      CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
            ],
          ),

          const SizedBox(
            height: 8,
          ),

          if (ledger != null) ...[
            if (party.isCustomer)
              _balanceList(
                title:
                    'المبالغ المستحقة على العميل',
                balances:
                    ledger.receivable,
                icon: Icons
                    .arrow_downward_rounded,
              ),

            if (party.isCustomer &&
                party.isSupplier)
              const SizedBox(
                height: 10,
              ),

            if (party.isSupplier)
              _balanceList(
                title:
                    'المبالغ المستحقة للمورد',
                balances:
                    ledger.payable,
                icon: Icons
                    .arrow_upward_rounded,
              ),
          ] else if (
            ledgerProvider.error !=
                null
          )
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  16,
                ),
                child: Text(
                  ledgerProvider.error!,
                ),
              ),
            )
          else
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(16),
                child: Text(
                  'جارٍ تحميل الرصيد...',
                ),
              ),
            ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            'الأرصدة الافتتاحية الأصلية',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          if (party.openingBalances.isEmpty)
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(16),
                child: Text(
                  'لا يوجد رصيد افتتاحي.',
                ),
              ),
            )
          else
            ...party.openingBalances.map(
              (balance) => Card(
                child: ListTile(
                  title: Text(
                    balance.balanceSide ==
                            'receivable'
                        ? 'افتتاحي على العميل'
                        : 'افتتاحي للمورد',
                  ),
                  subtitle: Text(
                    balance.currencyCode,
                  ),
                  trailing: Text(
                    '${MoneyUtils.formatMinor(balance.amountMinor, balance.currencyDecimalPlaces)} ${balance.currencySymbol}',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          const SizedBox(
            height: 18,
          ),

          const Card(
            child: Padding(
              padding:
                  EdgeInsets.all(16),
              child: Text(
                'الرصيد الحالي يُحسب من دفتر الأستاذ والقيود المحاسبية، وليس من حقل يدوي قابل للتعديل.',
              ),
            ),
          ),

          if (currentUser.isManager) ...[
            const SizedBox(
              height: 20,
            ),
            OutlinedButton.icon(
              onPressed:
                  _toggleStatus,
              icon: Icon(
                party.isActive
                    ? Icons.block
                    : Icons
                        .check_circle_outline,
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
    );
  }
}
