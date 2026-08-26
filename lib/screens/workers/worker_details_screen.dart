import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/ledger_balance_model.dart';
import '../../models/worker_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/ledger_provider.dart';
import '../../providers/worker_provider.dart';
import 'worker_form_screen.dart';

class WorkerDetailsScreen
    extends StatefulWidget {
  final WorkerModel worker;

  const WorkerDetailsScreen({
    super.key,
    required this.worker,
  });

  @override
  State<WorkerDetailsScreen>
      createState() =>
          _WorkerDetailsScreenState();
}

class _WorkerDetailsScreenState
    extends State<WorkerDetailsScreen> {
  WorkerModel get worker =>
      widget.worker;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<LedgerProvider>()
          .loadWorker(worker.id);
    });
  }

  String _wageText() {
    if (worker.wageType == 'none' ||
        worker.wageAmountMinor == null ||
        worker.wageCurrencyDecimalPlaces ==
            null) {
      return 'بدون أجر ثابت';
    }

    final amount =
        MoneyUtils.formatMinor(
      worker.wageAmountMinor!,
      worker
          .wageCurrencyDecimalPlaces!,
    );

    final type =
        worker.wageType == 'monthly'
            ? 'شهري'
            : 'يومي';

    return '$amount ${worker.wageCurrencySymbol ?? ''} ($type)';
  }

  Future<void> _edit() async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            WorkerFormScreen(
          worker: worker,
        ),
      ),
    );

    if (changed == true &&
        mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _toggle() async {
    final provider =
        context.read<WorkerProvider>();

    final ok =
        await provider.setStatus(
      workerId: worker.id,
      isActive: !worker.isActive,
    );

    if (!mounted) {
      return;
    }

    if (ok) {
      Navigator.pop(context, true);
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          provider.error ??
              'تعذر تعديل العامل.',
        ),
      ),
    );
  }

  Widget _balanceCard({
    required String title,
    required List<
            LedgerBalanceModel>
        balances,
  }) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style:
                  const TextStyle(
                fontSize: 17,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
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
    final user =
        context.watch<AuthProvider>().user!;

    final ledgerProvider =
        context.watch<LedgerProvider>();

    final ledger =
        ledgerProvider.workerLedger(
      worker.id,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(worker.name),
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
                            .loadWorker(
                              worker.id,
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
                  const EdgeInsets.all(
                18,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    worker.name,
                    style:
                        const TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    worker.jobTitle ??
                        'عامل',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'الأجر: ${_wageText()}',
                  ),
                  if (worker.phone !=
                      null) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'الهاتف: ${worker.phone}',
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 18,
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
            _balanceCard(
              title:
                  'مستحقات العامل',
              balances:
                  ledger.payable,
            ),
            const SizedBox(
              height: 10,
            ),
            _balanceCard(
              title:
                  'السلف القائمة على العامل',
              balances:
                  ledger.advances,
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
            height: 18,
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

          if (worker
              .openingBalances
              .isEmpty)
            const Card(
              child: Padding(
                padding:
                    EdgeInsets.all(
                  16,
                ),
                child: Text(
                  'لا يوجد رصيد افتتاحي.',
                ),
              ),
            )
          else
            ...worker.openingBalances.map(
              (balance) => Card(
                child: ListTile(
                  title: Text(
                    balance.balanceSide ==
                            'payable'
                        ? 'مستحق افتتاحي للعامل'
                        : 'سلفة افتتاحية على العامل',
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
                'الراتب المستحق والدفع والسلف والاسترداد والخصومات كلها أصبحت حركات محاسبية تُحسب من دفتر الأستاذ.',
              ),
            ),
          ),

          if (user.isManager) ...[
            const SizedBox(
              height: 18,
            ),
            OutlinedButton.icon(
              onPressed: _toggle,
              icon: Icon(
                worker.isActive
                    ? Icons.block
                    : Icons
                        .check_circle_outline,
              ),
              label: Text(
                worker.isActive
                    ? 'تعطيل العامل'
                    : 'تفعيل العامل',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
