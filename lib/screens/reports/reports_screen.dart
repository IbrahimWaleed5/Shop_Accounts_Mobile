import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/report_model.dart';
import '../../providers/party_provider.dart';
import '../../providers/reference_data_provider.dart';
import '../../providers/report_provider.dart';
import '../../providers/worker_provider.dart';
import '../../services/report_export_service.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  static const _background = Color(0xFFF8F9FA);
  static const _primary = Color(0xFF5152B9);

  String _type = 'all';
  late DateTime _from;
  late DateTime _to;
  int _currencyId = 0;
  int _partyId = 0;
  int _workerId = 0;
  bool _exporting = false;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    _from = DateTime(now.year, now.month, 1);
    _to = DateTime(now.year, now.month, now.day);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        context.read<ReferenceDataProvider>().load(),
        context.read<PartyProvider>().load(),
        context.read<WorkerProvider>().load(),
      ]);

      if (mounted) {
        await _generate();
      }
    });
  }

  bool get _partyReport =>
      _type == 'customer_statement' ||
      _type == 'supplier_statement';

  bool get _workerReport =>
      _type == 'worker_statement';

  Future<void> _pickFrom() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _from,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (value == null || !mounted) {
      return;
    }

    setState(() {
      _from = value;
      if (_to.isBefore(value)) {
        _to = value;
      }
    });
  }

  Future<void> _pickTo() async {
    final value = await showDatePicker(
      context: context,
      initialDate: _to,
      firstDate: _from,
      lastDate: DateTime(2100),
    );

    if (value == null || !mounted) {
      return;
    }

    setState(() => _to = value);
  }

  Future<void> _generate() async {
    if (_partyReport && _partyId == 0) {
      _msg(
        _type == 'customer_statement'
            ? 'اختر العميل.'
            : 'اختر المورد.',
      );
      return;
    }

    if (_workerReport && _workerId == 0) {
      _msg('اختر العامل.');
      return;
    }

    final provider = context.read<ReportProvider>();

    final ok = await provider.generate(
      reportType: _type,
      from: _from,
      to: _to,
      currencyId: _currencyId == 0 ? null : _currencyId,
      partyId: _partyReport ? _partyId : null,
      workerId: _workerReport ? _workerId : null,
    );

    if (mounted && !ok) {
      _msg(provider.error ?? 'تعذر إنشاء التقرير.');
    }
  }

  Future<void> _export(
    String kind,
  ) async {
    final report =
        context.read<ReportProvider>().report;

    if (report == null) {
      _msg('أنشئ التقرير أولاً.');
      return;
    }

    setState(() => _exporting = true);

    try {
      if (kind == 'pdf') {
        await ReportExportService.sharePdf(report);
      } else if (kind == 'print') {
        await ReportExportService.printPdf(report);
      } else {
        await ReportExportService.shareExcel(report);
      }
    } catch (_) {
      if (mounted) {
        _msg(
          kind == 'excel'
              ? 'تعذر إنشاء أو مشاركة Excel.'
              : 'تعذر إنشاء PDF. أول استخدام يحتاج اتصال لتحميل الخط العربي.',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _exporting = false);
      }
    }
  }

  void _msg(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  String _date(DateTime value) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${value.year}-${two(value.month)}-${two(value.day)}';
  }

  String _money(
    int minor,
    int decimals,
    String symbol,
  ) {
    return '${MoneyUtils.formatMinor(minor, decimals)} $symbol';
  }

  String _typeLabel(String value) {
    const labels = {
      'sale': 'بيع',
      'purchase': 'شراء',
      'customer_collection': 'تحصيل عميل',
      'supplier_payment': 'دفع مورد',
      'expense': 'مصروف',
      'other_income': 'دخل آخر',
      'worker_salary_accrual': 'استحقاق راتب',
      'worker_salary_payment': 'دفع راتب',
      'worker_advance': 'سلفة عامل',
      'worker_advance_recovery': 'استرداد سلفة',
      'worker_deduction': 'خصم عامل',
      'customer_opening_balance': 'رصيد افتتاحي عميل',
      'supplier_opening_balance': 'رصيد افتتاحي مورد',
      'worker_opening_payable': 'رصيد افتتاحي عامل',
      'worker_opening_advance': 'سلفة افتتاحية',
      'financial_account_opening_balance':
          'رصيد افتتاحي حساب',
      'transfer': 'تحويل',
    };

    return labels[value] ?? value;
  }

  @override
  Widget build(BuildContext context) {
    final reports = context.watch<ReportProvider>();
    final reference =
        context.watch<ReferenceDataProvider>();
    final parties =
        context.watch<PartyProvider>().parties;
    final workers =
        context.watch<WorkerProvider>().workers;

    final selectableParties = _type ==
            'customer_statement'
        ? parties.where((item) => item.isCustomer).toList()
        : _type == 'supplier_statement'
            ? parties.where((item) => item.isSupplier).toList()
            : <dynamic>[];

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'التقارير والتصدير',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          18,
          10,
          18,
          36,
        ),
        children: [
          _Card(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  decoration: const InputDecoration(
                    labelText: 'نوع التقرير',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'all',
                      child: Text('التقرير الشامل'),
                    ),
                    DropdownMenuItem(
                      value: 'incoming',
                      child: Text('الوارد'),
                    ),
                    DropdownMenuItem(
                      value: 'outgoing',
                      child: Text('الصادر'),
                    ),
                    DropdownMenuItem(
                      value: 'sales',
                      child: Text('المبيعات'),
                    ),
                    DropdownMenuItem(
                      value: 'purchases',
                      child: Text('المشتريات'),
                    ),
                    DropdownMenuItem(
                      value: 'expenses',
                      child: Text('المصروفات'),
                    ),
                    DropdownMenuItem(
                      value: 'collections',
                      child: Text('تحصيلات العملاء'),
                    ),
                    DropdownMenuItem(
                      value: 'supplier_payments',
                      child: Text('دفعات الموردين'),
                    ),
                    DropdownMenuItem(
                      value: 'customer_statement',
                      child: Text('كشف حساب عميل'),
                    ),
                    DropdownMenuItem(
                      value: 'supplier_statement',
                      child: Text('كشف حساب مورد'),
                    ),
                    DropdownMenuItem(
                      value: 'worker_statement',
                      child: Text('كشف حساب عامل'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;

                    setState(() {
                      _type = value;
                      _partyId = 0;
                      _workerId = 0;
                    });

                    context
                        .read<ReportProvider>()
                        .clear();
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _DateBox(
                        label: 'من',
                        value: _date(_from),
                        onTap: _pickFrom,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _DateBox(
                        label: 'إلى',
                        value: _date(_to),
                        onTap: _pickTo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  initialValue: _currencyId,
                  decoration: const InputDecoration(
                    labelText: 'العملة',
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 0,
                      child: Text(
                        'كل العملات - بدون جمع',
                      ),
                    ),
                    ...reference.activeCurrencies.map(
                      (item) => DropdownMenuItem(
                        value: item.id,
                        child: Text(
                          '${item.code} - ${item.symbol}',
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _currencyId = value);
                    }
                  },
                ),
                if (_partyReport) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: _partyId,
                    decoration: InputDecoration(
                      labelText:
                          _type == 'customer_statement'
                              ? 'العميل'
                              : 'المورد',
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: Text(
                          _type == 'customer_statement'
                              ? 'اختر العميل'
                              : 'اختر المورد',
                        ),
                      ),
                      ...selectableParties.map(
                        (item) => DropdownMenuItem<int>(
                          value: item.id as int,
                          child: Text(item.name as String),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _partyId = value);
                      }
                    },
                  ),
                ],
                if (_workerReport) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: _workerId,
                    decoration: const InputDecoration(
                      labelText: 'العامل',
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 0,
                        child: Text('اختر العامل'),
                      ),
                      ...workers.map(
                        (item) => DropdownMenuItem(
                          value: item.id,
                          child: Text(item.name),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _workerId = value);
                      }
                    },
                  ),
                ],
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed:
                        reports.loading ? null : _generate,
                    icon: const Icon(
                      Icons.assessment_outlined,
                    ),
                    label: Text(
                      reports.loading
                          ? 'جاري التحميل...'
                          : 'إنشاء التقرير',
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (reports.loading) ...[
            const SizedBox(height: 10),
            const LinearProgressIndicator(),
          ],
          if (reports.error != null) ...[
            const SizedBox(height: 10),
            _Card(
              child: Text(reports.error!),
            ),
          ],
          if (reports.report != null) ...[
            const SizedBox(height: 14),
            _result(reports.report!),
            const SizedBox(height: 10),
            _Card(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'تصدير ومشاركة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton.icon(
                        onPressed: _exporting
                            ? null
                            : () => _export('pdf'),
                        icon: const Icon(
                          Icons.picture_as_pdf_outlined,
                        ),
                        label:
                            const Text('PDF / مشاركة'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _exporting
                            ? null
                            : () => _export('print'),
                        icon:
                            const Icon(Icons.print_outlined),
                        label:
                            const Text('طباعة PDF'),
                      ),
                      OutlinedButton.icon(
                        onPressed: _exporting
                            ? null
                            : () => _export('excel'),
                        icon: const Icon(
                          Icons.table_chart_outlined,
                        ),
                        label: const Text(
                          'Excel / مشاركة',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _result(ReportModel report) {
    return Column(
      children: [
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                report.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_date(report.from)} → ${_date(report.to)}',
              ),
              if (report.entityName != null)
                Text(report.entityName!),
            ],
          ),
        ),
        if (report.totals.isNotEmpty) ...[
          const SizedBox(height: 10),
          ...report.totals.map(
            (item) => Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: _Card(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      item.currencyCode,
                      style: const TextStyle(
                        color: _primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _Info(
                      title: 'عدد الحركات',
                      value: '${item.rowsCount}',
                    ),
                    _Info(
                      title: 'إجمالي التقرير',
                      value: _money(
                        item.reportTotalMinor,
                        item.decimalPlaces,
                        item.currencySymbol,
                      ),
                    ),
                    _Info(
                      title: 'الوارد النقدي',
                      value: _money(
                        item.cashInMinor,
                        item.decimalPlaces,
                        item.currencySymbol,
                      ),
                    ),
                    _Info(
                      title: 'الصادر النقدي',
                      value: _money(
                        item.cashOutMinor,
                        item.decimalPlaces,
                        item.currencySymbol,
                      ),
                      divider: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        if (report.balances.isNotEmpty) ...[
          const SizedBox(height: 2),
          _Card(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'أرصدة كشف الحساب',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                ...report.balances.map(
                  (item) => _balance(item),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 10),
        _Card(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'الحركات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (report.rows.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'لا توجد حركات في الفترة المحددة.',
                  ),
                )
              else
                ...report.rows.map(
                  (row) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color(0xFF8E8FFA)
                                  .withValues(alpha: .30),
                          child: const Icon(
                            Icons.receipt_long_outlined,
                            color: _primary,
                          ),
                        ),
                        title: Text(
                          '${_typeLabel(row.type)} • ${_money(row.reportAmountMinor, row.decimalPlaces, row.currencySymbol)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          '${row.partyName ?? row.workerName ?? row.description ?? row.transactionNo}\n${_date(row.occurredAt.toLocal())}',
                        ),
                        isThreeLine: true,
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ),
              if (report.truncated)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'تنبيه: تم عرض أول 3000 حركة فقط.',
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _balance(ReportBalanceModel item) {
    final worker =
        item.openingWorkerPayableMinor != 0 ||
        item.closingWorkerPayableMinor != 0 ||
        item.openingWorkerAdvanceMinor != 0 ||
        item.closingWorkerAdvanceMinor != 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Text(
            item.currencyCode,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (worker) ...[
            _Info(
              title: 'مستحق للعامل أول المدة',
              value: _money(
                item.openingWorkerPayableMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
            ),
            _Info(
              title: 'مستحق للعامل آخر المدة',
              value: _money(
                item.closingWorkerPayableMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
            ),
            _Info(
              title: 'سلف العامل أول المدة',
              value: _money(
                item.openingWorkerAdvanceMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
            ),
            _Info(
              title: 'سلف العامل آخر المدة',
              value: _money(
                item.closingWorkerAdvanceMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
              divider: false,
            ),
          ] else ...[
            _Info(
              title: 'مديونية أول المدة',
              value: _money(
                item.openingReceivableMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
            ),
            _Info(
              title: 'مديونية آخر المدة',
              value: _money(
                item.closingReceivableMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
            ),
            _Info(
              title: 'استحقاق للمورد أول المدة',
              value: _money(
                item.openingPayableMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
            ),
            _Info(
              title: 'استحقاق للمورد آخر المدة',
              value: _money(
                item.closingPayableMinor,
                item.decimalPlaces,
                item.currencySymbol,
              ),
              divider: false,
            ),
          ],
        ],
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateBox({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(value),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String title;
  final String value;
  final bool divider;

  const _Info({
    required this.title,
    required this.value,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Row(
            children: [
              Expanded(child: Text(title)),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (divider) const Divider(height: 1),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _Card({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC7C5D4)
              .withValues(alpha: .30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: .04,
            ),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
