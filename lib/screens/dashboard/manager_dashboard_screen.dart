import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/manager_dashboard_model.dart';
import '../../providers/manager_dashboard_provider.dart';

class ManagerDashboardScreen
    extends StatefulWidget {
  const ManagerDashboardScreen({
    super.key,
  });

  @override
  State<ManagerDashboardScreen>
      createState() =>
          _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState
    extends State<
        ManagerDashboardScreen> {
  static const _background =
      Color(0xFFF8F9FA);

  static const _primary =
      Color(0xFF5152B9);

  static const _primaryContainer =
      Color(0xFF8E8FFA);

  static const _onBackground =
      Color(0xFF191C1D);

  static const _outlineVariant =
      Color(0xFFC7C5D4);

  String _preset =
      'month';

  DateTime? _customStart;
  DateTime? _customEnd;

  int? _currencyId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) => _load(),
    );
  }

  Future<void> _load() async {
    await context
        .read<
            ManagerDashboardProvider>()
        .load(
          preset: _preset,
          startDate:
              _customStart,
          endDate:
              _customEnd,
        );

    if (!mounted) {
      return;
    }

    final dashboard =
        context
            .read<
                ManagerDashboardProvider>()
            .dashboard;

    if (
      dashboard != null &&
      dashboard.currencies.isNotEmpty &&
      !dashboard.currencies.any(
        (item) =>
            item.currencyId ==
            _currencyId,
      )
    ) {
      setState(() {
        _currencyId =
            dashboard
                .currencies
                .first
                .currencyId;
      });
    }
  }

  Future<void> _setPreset(
    String value,
  ) async {
    if (value == 'custom') {
      final now = DateTime.now();

      final start =
          await showDatePicker(
        context: context,
        initialDate:
            _customStart ??
            DateTime(
              now.year,
              now.month,
              1,
            ),
        firstDate:
            DateTime(2020),
        lastDate:
            DateTime(2100),
      );

      if (
        start == null ||
        !mounted
      ) {
        return;
      }

      final end =
          await showDatePicker(
        context: context,
        initialDate:
            _customEnd ?? now,
        firstDate: start,
        lastDate:
            DateTime(2100),
      );

      if (
        end == null ||
        !mounted
      ) {
        return;
      }

      setState(() {
        _preset =
            'custom';
        _customStart =
            start;
        _customEnd =
            end;
      });

      await _load();
      return;
    }

    setState(() {
      _preset =
          value;
    });

    await _load();
  }

  ManagerDashboardCurrencyModel?
      _currency(
    ManagerDashboardModel? dashboard,
  ) {
    if (
      dashboard == null ||
      dashboard.currencies.isEmpty
    ) {
      return null;
    }

    final selectedId =
        _currencyId ??
        dashboard
            .currencies
            .first
            .currencyId;

    for (
      final item
      in dashboard.currencies
    ) {
      if (
        item.currencyId ==
        selectedId
      ) {
        return item;
      }
    }

    return dashboard
        .currencies
        .first;
  }

  String _money(
    int value,
    ManagerDashboardCurrencyModel
        currency,
  ) {
    return '${MoneyUtils.formatMinor(value, currency.decimalPlaces)} '
        '${currency.currencySymbol}';
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
      case 'worker_salary_payment':
        return 'دفع راتب';
      case 'worker_advance':
        return 'سلفة عامل';
      case 'transfer':
        return 'تحويل';
      default:
        return type;
    }
  }

  String _date(
    DateTime value,
  ) {
    String two(int n) =>
        n.toString().padLeft(
          2,
          '0',
        );

    return '${value.year}-'
        '${two(value.month)}-'
        '${two(value.day)}';
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<
            ManagerDashboardProvider>();

    final dashboard =
        provider.dashboard;

    final currency =
        _currency(
      dashboard,
    );

    return Scaffold(
      backgroundColor:
          _background,
      appBar: AppBar(
        backgroundColor:
            _background,
        foregroundColor:
            _onBackground,
        elevation: 0,
        scrolledUnderElevation:
            0,
        title:
            const Text(
          'لوحة المدير',
          style:
              TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'تحديث',
            onPressed:
                provider.loading
                    ? null
                    : _load,
            icon:
                const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding:
              const EdgeInsets.fromLTRB(
            18,
            10,
            18,
            36,
          ),
          children: [
            _FilterCard(
              preset:
                  _preset,
              customLabel:
                  _preset ==
                          'custom' &&
                      _customStart !=
                          null &&
                      _customEnd !=
                          null
                  ? '${_date(_customStart!)} → ${_date(_customEnd!)}'
                  : null,
              onSelected:
                  _setPreset,
            ),

            const SizedBox(
              height: 14,
            ),

            if (
              provider.loading &&
              dashboard == null
            )
              const SizedBox(
                height: 280,
                child:
                    Center(
                  child:
                      CircularProgressIndicator(),
                ),
              )
            else if (
              provider.error !=
                  null &&
              dashboard == null
            )
              _SurfaceCard(
                child: Column(
                  children: [
                    const Icon(
                      Icons
                          .cloud_off_outlined,
                      size: 44,
                      color:
                          _primary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      provider.error!,
                      textAlign:
                          TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    FilledButton(
                      onPressed:
                          _load,
                      child:
                          const Text(
                        'إعادة المحاولة',
                      ),
                    ),
                  ],
                ),
              )
            else if (
              dashboard != null &&
              currency != null
            ) ...[
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'نظرة عامة',
                      style:
                          TextStyle(
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 12,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        999,
                      ),
                      border:
                          Border.all(
                        color:
                            _outlineVariant
                                .withValues(
                          alpha: .45,
                        ),
                      ),
                    ),
                    child:
                        DropdownButtonHideUnderline(
                      child:
                          DropdownButton<int>(
                        value:
                            currency.currencyId,
                        icon:
                            const Icon(
                          Icons
                              .keyboard_arrow_down,
                          color:
                              _primary,
                        ),
                        items:
                            dashboard
                                .currencies
                                .map(
                                  (item) =>
                                      DropdownMenuItem<int>(
                                    value:
                                        item.currencyId,
                                    child:
                                        Text(
                                      item.currencyCode,
                                      style:
                                          const TextStyle(
                                        color:
                                            _primary,
                                        fontWeight:
                                            FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (value) {
                          if (
                            value ==
                            null
                          ) {
                            return;
                          }

                          setState(() {
                            _currencyId =
                                value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              LayoutBuilder(
                builder:
                    (
                  context,
                  constraints,
                ) {
                  final wide =
                      constraints
                              .maxWidth >=
                          760;

                  final cards = [
                    _MetricCard(
                      icon: Icons
                          .south_west_rounded,
                      title: 'الوارد',
                      value:
                          _money(
                        currency.incomingMinor,
                        currency,
                      ),
                    ),
                    _MetricCard(
                      icon: Icons
                          .north_east_rounded,
                      title: 'الصادر',
                      value:
                          _money(
                        currency.outgoingMinor,
                        currency,
                      ),
                    ),
                    _MetricCard(
                      icon: Icons
                          .account_balance_wallet_outlined,
                      title: 'الأرباح',
                      value:
                          _money(
                        currency.cashResultMinor,
                        currency,
                      ),
                    ),
                  ];

                  if (wide) {
                    return Row(
                      children: [
                        Expanded(
                          child:
                              cards[0],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child:
                              cards[1],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child:
                              cards[2],
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      cards[0],
                      const SizedBox(
                        height: 10,
                      ),
                      cards[1],
                      const SizedBox(
                        height: 10,
                      ),
                      cards[2],
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 12,
              ),

              LayoutBuilder(
                builder:
                    (
                  context,
                  constraints,
                ) {
                  final wide =
                      constraints
                              .maxWidth >=
                          760;

                  final cards = [
                    _MetricCard(
                      icon: Icons
                          .account_balance_outlined,
                      title:
                          'رصيد الحسابات',
                      value:
                          _money(
                        currency
                            .financialBalanceTotalMinor,
                        currency,
                      ),
                    ),
                    _MetricCard(
                      icon: Icons
                          .people_outline,
                      title:
                          'ديون العملاء',
                      value:
                          _money(
                        currency
                            .customerDebtTotalMinor,
                        currency,
                      ),
                      subtitle:
                          '${currency.debtorCount} عميل',
                    ),
                    _MetricCard(
                      icon: Icons
                          .local_shipping_outlined,
                      title:
                          'ديون الموردين',
                      value:
                          _money(
                        currency
                            .supplierDebtTotalMinor,
                        currency,
                      ),
                      subtitle:
                          '${currency.supplierDueCount} مورد',
                    ),
                  ];

                  if (wide) {
                    return Row(
                      children: [
                        Expanded(
                          child:
                              cards[0],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child:
                              cards[1],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child:
                              cards[2],
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      cards[0],
                      const SizedBox(
                        height: 10,
                      ),
                      cards[1],
                      const SizedBox(
                        height: 10,
                      ),
                      cards[2],
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 18,
              ),

              const _SectionTitle(
                title:
                    'تفاصيل الفترة',
              ),

              const SizedBox(
                height: 10,
              ),

              _SurfaceCard(
                child: Column(
                  children: [
                    _DetailRow(
                      title:
                          'إجمالي المبيعات',
                      value:
                          _money(
                        currency.salesTotalMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'المقبوض من المبيعات',
                      value:
                          _money(
                        currency.salesReceivedMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'تحصيلات العملاء',
                      value:
                          _money(
                        currency
                            .customerCollectionsMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'مشتريات البضاعة',
                      value:
                          _money(
                        currency
                            .purchasesTotalMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'المدفوع للموردين',
                      value:
                          _money(
                        currency
                            .supplierPaidMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'المصروفات',
                      value:
                          _money(
                        currency.expensesMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'الدخل الآخر',
                      value:
                          _money(
                        currency.otherIncomeMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'الرواتب المدفوعة',
                      value:
                          _money(
                        currency
                            .workerSalaryPaymentsMinor,
                        currency,
                      ),
                    ),
                    _DetailRow(
                      title:
                          'سلف العمال',
                      value:
                          _money(
                        currency
                            .workerAdvancesMinor,
                        currency,
                      ),
                      divider:
                          false,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              const _SectionTitle(
                title:
                    'أرصدة الحسابات المالية',
              ),

              const SizedBox(
                height: 10,
              ),

              _SurfaceCard(
                child:
                    currency
                            .financialAccounts
                            .isEmpty
                        ? const Text(
                            'لا توجد أرصدة حسابات لهذه العملة.',
                          )
                        : Column(
                            children:
                                currency
                                    .financialAccounts
                                    .map(
                                      (account) =>
                                          _DetailRow(
                                        title:
                                            account.name,
                                        value:
                                            _money(
                                          account.balanceMinor,
                                          currency,
                                        ),
                                        divider:
                                            account !=
                                            currency
                                                .financialAccounts
                                                .last,
                                      ),
                                    )
                                    .toList(),
                          ),
              ),

              const SizedBox(
                height: 18,
              ),

              LayoutBuilder(
                builder:
                    (
                  context,
                  constraints,
                ) {
                  final wide =
                      constraints
                              .maxWidth >=
                          760;

                  final debtors =
                      _PartyRankingCard(
                    title:
                        'أعلى ديون العملاء',
                    emptyText:
                        'لا توجد ديون عملاء.',
                    rows:
                        currency.topDebtors,
                    currency:
                        currency,
                  );

                  final suppliers =
                      _PartyRankingCard(
                    title:
                        'أعلى ديون الموردين',
                    emptyText:
                        'لا توجد ديون موردين.',
                    rows:
                        currency.topSuppliers,
                    currency:
                        currency,
                  );

                  if (wide) {
                    return Row(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Expanded(
                          child:
                              debtors,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child:
                              suppliers,
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      debtors,
                      const SizedBox(
                        height: 10,
                      ),
                      suppliers,
                    ],
                  );
                },
              ),

              const SizedBox(
                height: 18,
              ),

              const _SectionTitle(
                title:
                    'آخر الحركات في الفترة',
              ),

              const SizedBox(
                height: 10,
              ),

              if (
                dashboard
                    .recentTransactions
                    .isEmpty
              )
                const _SurfaceCard(
                  child:
                      Text(
                    'لا توجد حركات في هذه الفترة.',
                  ),
                )
              else
                ...dashboard
                    .recentTransactions
                    .map(
                      (item) =>
                          Padding(
                        padding:
                            const EdgeInsets
                                .only(
                          bottom: 8,
                        ),
                        child:
                            _SurfaceCard(
                          padding:
                              EdgeInsets.zero,
                          child:
                              ListTile(
                            leading:
                                CircleAvatar(
                              backgroundColor:
                                  _primaryContainer
                                      .withValues(
                                alpha:
                                    .30,
                              ),
                              child:
                                  const Icon(
                                Icons
                                    .receipt_long_outlined,
                                color:
                                    _primary,
                              ),
                            ),
                            title:
                                Text(
                              '${_typeLabel(item.type)} • '
                              '${MoneyUtils.formatMinor(item.amountMinor, item.decimalPlaces)} '
                              '${item.currencySymbol}',
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                            subtitle:
                                Text(
                              '${item.partyName ?? item.workerName ?? item.financialAccountName ?? item.description ?? item.transactionNo}\n'
                              '${_date(item.occurredAt.toLocal())}',
                            ),
                            isThreeLine:
                                true,
                          ),
                        ),
                      ),
                    ),
            ],

            if (
              provider.loading &&
              dashboard != null
            ) ...[
              const SizedBox(
                height: 12,
              ),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}

class _FilterCard
    extends StatelessWidget {
  static const _primary =
      Color(0xFF5152B9);

  final String preset;
  final String? customLabel;
  final Future<void> Function(
    String value,
  ) onSelected;

  const _FilterCard({
    required this.preset,
    required this.onSelected,
    this.customLabel,
  });

  @override
  Widget build(BuildContext context) {
    const options = [
      ('today', 'اليوم'),
      ('week', 'الأسبوع'),
      ('month', 'الشهر'),
      ('custom', 'مخصص'),
    ];

    return _SurfaceCard(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'الفترة',
            style:
                TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                options
                    .map(
                      (item) =>
                          ChoiceChip(
                        label:
                            Text(
                          item.$2,
                        ),
                        selected:
                            preset ==
                            item.$1,
                        selectedColor:
                            _primary
                                .withValues(
                          alpha:
                              .14,
                        ),
                        onSelected:
                            (_) {
                          onSelected(
                            item.$1,
                          );
                        },
                      ),
                    )
                    .toList(),
          ),
          if (
            customLabel != null
          ) ...[
            const SizedBox(
              height: 10,
            ),
            Text(
              customLabel!,
              style:
                  const TextStyle(
                color:
                    _primary,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MetricCard
    extends StatelessWidget {
  static const _primary =
      Color(0xFF5152B9);

  static const _primaryContainer =
      Color(0xFF8E8FFA);

  static const _onBackground =
      Color(0xFF191C1D);

  static const _onSurfaceVariant =
      Color(0xFF464552);

  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;

  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,
              color:
                  _primaryContainer
                      .withValues(
                alpha:
                    .30,
              ),
            ),
            alignment:
                Alignment.center,
            child:
                Icon(
              icon,
              color:
                  _primary,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child:
                Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        _onSurfaceVariant,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style:
                      const TextStyle(
                    color:
                        _onBackground,
                    fontSize:
                        21,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
                if (
                  subtitle != null
                ) ...[
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    subtitle!,
                    style:
                        const TextStyle(
                      color:
                          _onSurfaceVariant,
                      fontSize:
                          12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PartyRankingCard
    extends StatelessWidget {
  final String title;
  final String emptyText;

  final List<
      ManagerDashboardPartyBalance>
      rows;

  final ManagerDashboardCurrencyModel
      currency;

  const _PartyRankingCard({
    required this.title,
    required this.emptyText,
    required this.rows,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (rows.isEmpty)
            Text(
              emptyText,
            )
          else
            ...rows.asMap().entries.map(
              (entry) {
                final item =
                    entry.value;

                return Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 8,
                      ),
                      child:
                          Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            child:
                                Text(
                              '${entry.key + 1}',
                              style:
                                  const TextStyle(
                                fontSize:
                                    11,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child:
                                Text(
                              item.partyName,
                            ),
                          ),
                          Text(
                            '${MoneyUtils.formatMinor(item.balanceMinor, currency.decimalPlaces)} '
                            '${currency.currencySymbol}',
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (
                      entry.key !=
                      rows.length - 1
                    )
                      const Divider(
                        height: 1,
                      ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _SectionTitle
    extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          const TextStyle(
        fontSize: 20,
        fontWeight:
            FontWeight.w600,
      ),
    );
  }
}

class _DetailRow
    extends StatelessWidget {
  static const _outlineVariant =
      Color(0xFFC7C5D4);

  final String title;
  final String value;
  final bool divider;

  const _DetailRow({
    required this.title,
    required this.value,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child:
              Row(
            children: [
              Expanded(
                child:
                    Text(
                  title,
                ),
              ),
              Text(
                value,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (divider)
          Divider(
            height: 1,
            color:
                _outlineVariant
                    .withValues(
              alpha:
                  .38,
            ),
          ),
      ],
    );
  }
}

class _SurfaceCard
    extends StatelessWidget {
  static const _outlineVariant =
      Color(0xFFC7C5D4);

  final Widget child;
  final EdgeInsetsGeometry padding;

  const _SurfaceCard({
    required this.child,
    this.padding =
        const EdgeInsets.all(
      16,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding,
      decoration:
          BoxDecoration(
        color:
            Colors.white,
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        border:
            Border.all(
          color:
              _outlineVariant
                  .withValues(
            alpha:
                .30,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black
                    .withValues(
              alpha:
                  .04,
            ),
            blurRadius:
                20,
            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child:
          child,
    );
  }
}
