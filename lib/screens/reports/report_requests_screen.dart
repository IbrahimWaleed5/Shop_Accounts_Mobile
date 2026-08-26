import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/report_request_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/reference_data_provider.dart';
import '../../providers/report_request_provider.dart';

class ReportRequestsScreen
    extends StatefulWidget {
  const ReportRequestsScreen({
    super.key,
  });

  @override
  State<ReportRequestsScreen>
      createState() =>
          _ReportRequestsScreenState();
}

class _ReportRequestsScreenState
    extends State<
        ReportRequestsScreen> {
  static const _background =
      Color(0xFFF8F9FA);

  static const _primary =
      Color(0xFF5152B9);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) async {
        final auth =
            context
                .read<AuthProvider>();

        final provider =
            context
                .read<
                    ReportRequestProvider>();

        await provider.load();

        if (
          auth.user?.isManager ==
          true
        ) {
          await provider
              .loadAccountants();
        }

        if (mounted) {
          await context
              .read<
                  ReferenceDataProvider>()
              .load();
        }
      },
    );
  }

  Future<void> _createRequest() async {
    final provider =
        context.read<
            ReportRequestProvider>();

    if (
      provider.accountants.isEmpty
    ) {
      await provider
          .loadAccountants();
    }

    if (
      !mounted
    ) {
      return;
    }

    if (
      provider.accountants.isEmpty
    ) {
      _message(
        provider.error ??
            'لا يوجد محاسب نشط لإرسال الطلب إليه.',
      );

      return;
    }

    final result =
        await showDialog<
            _CreateRequestResult>(
      context:
          context,
      builder:
          (dialogContext) =>
              _CreateRequestDialog(
        accountants:
            provider.accountants,
      ),
    );

    if (
      result == null ||
      !mounted
    ) {
      return;
    }

    final message =
        await provider.create(
      accountantId:
          result.accountantId,
      reportType:
          result.reportType,
      managerNote:
          result.managerNote,
    );

    if (!mounted) {
      return;
    }

    _message(
      message ??
          provider.error ??
          'تعذر إرسال الطلب.',
    );
  }

  Future<void> _submitReport(
    ReportRequestModel item,
  ) async {
    final result =
        await showModalBottomSheet<
            _SubmitReportResult>(
      context:
          context,
      isScrollControlled:
          true,
      backgroundColor:
          Colors.transparent,
      builder:
          (_) =>
              _SubmitReportSheet(
        item:
            item,
      ),
    );

    if (
      result == null ||
      !mounted
    ) {
      return;
    }

    final provider =
        context.read<
            ReportRequestProvider>();

    final message =
        await provider.submit(
      requestId:
          item.id,
      from:
          result.from,
      to:
          result.to,
      currencyId:
          result.currencyId,
      accountantNote:
          result.note,
    );

    if (!mounted) {
      return;
    }

    _message(
      message ??
          provider.error ??
          'تعذر إرسال التقرير.',
    );
  }

  void _message(
    String value,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content:
            Text(value),
      ),
    );
  }

  String _dateTime(
    DateTime value,
  ) {
    final local =
        value.toLocal();

    String two(int n) =>
        n
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '${local.year}-'
        '${two(local.month)}-'
        '${two(local.day)} '
        '${two(local.hour)}:'
        '${two(local.minute)}';
  }

  String _date(
    DateTime? value,
  ) {
    if (value == null) {
      return '—';
    }

    String two(int n) =>
        n
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '${value.year}-'
        '${two(value.month)}-'
        '${two(value.day)}';
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final auth =
        context.watch<
            AuthProvider>();

    final provider =
        context.watch<
            ReportRequestProvider>();

    final isManager =
        auth.user?.isManager ==
        true;

    return Scaffold(
      backgroundColor:
          _background,
      appBar:
          AppBar(
        backgroundColor:
            _background,
        elevation:
            0,
        scrolledUnderElevation:
            0,
        title:
            Text(
          isManager
              ? 'طلبات التقارير'
              : 'تقارير مطلوبة مني',
          style:
              const TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton:
          isManager
              ? FloatingActionButton
                  .extended(
                  onPressed:
                      provider.working
                          ? null
                          : _createRequest,
                  icon:
                      const Icon(
                    Icons
                        .add_chart_outlined,
                  ),
                  label:
                      const Text(
                    'طلب تقرير',
                  ),
                )
              : null,
      body:
          RefreshIndicator(
        onRefresh:
            () =>
                provider.load(
          keepCurrentFilter:
              true,
        ),
        child:
            ListView(
          padding:
              const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            100,
          ),
          children: [
            _SurfaceCard(
              child:
                  Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .stretch,
                children: [
                  Text(
                    isManager
                        ? 'المدير يرسل طلبًا للمحاسب، وبعد الإرسال يظهر التقرير هنا.'
                        : 'لا ترسل تقريرًا إلا بناءً على طلب المدير. اختر الفترة ثم أرسل.',
                    style:
                        const TextStyle(
                      fontSize:
                          15,
                    ),
                  ),
                  const SizedBox(
                    height:
                        12,
                  ),
                  Wrap(
                    spacing:
                        8,
                    runSpacing:
                        8,
                    children: [
                      ChoiceChip(
                        label:
                            const Text(
                          'الكل',
                        ),
                        selected:
                            provider.statusFilter ==
                            null,
                        onSelected:
                            (_) =>
                                provider.load(),
                      ),
                      ChoiceChip(
                        label:
                            const Text(
                          'بانتظار الإرسال',
                        ),
                        selected:
                            provider.statusFilter ==
                            'pending',
                        onSelected:
                            (_) =>
                                provider.load(
                          status:
                              'pending',
                        ),
                      ),
                      ChoiceChip(
                        label:
                            const Text(
                          'تم الإرسال',
                        ),
                        selected:
                            provider.statusFilter ==
                            'submitted',
                        onSelected:
                            (_) =>
                                provider.load(
                          status:
                              'submitted',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (
              provider.loading
            ) ...[
              const SizedBox(
                height:
                    10,
              ),
              const LinearProgressIndicator(),
            ],
            if (
              provider.error !=
              null
            ) ...[
              const SizedBox(
                height:
                    10,
              ),
              _SurfaceCard(
                child:
                    Text(
                  provider.error!,
                ),
              ),
            ],
            const SizedBox(
              height:
                  10,
            ),
            if (
              !provider.loading &&
              provider.items.isEmpty
            )
              const _SurfaceCard(
                child:
                    Column(
                  children: [
                    Icon(
                      Icons
                          .mark_email_unread_outlined,
                      size:
                          48,
                      color:
                          _primary,
                    ),
                    SizedBox(
                      height:
                          8,
                    ),
                    Text(
                      'لا توجد طلبات تقارير في هذه القائمة.',
                      textAlign:
                          TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...provider.items.map(
                (item) =>
                    Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom:
                        10,
                  ),
                  child:
                      _requestCard(
                    item:
                        item,
                    isManager:
                        isManager,
                    provider:
                        provider,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _requestCard({
    required ReportRequestModel item,
    required bool isManager,
    required ReportRequestProvider provider,
  }) {
    return _SurfaceCard(
      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment
                .stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    const Color(
                      0xFF8E8FFA,
                    ).withValues(
                  alpha:
                      .28,
                ),
                child:
                    Icon(
                  item.isSubmitted
                      ? Icons
                          .mark_email_read_outlined
                      : Icons
                          .pending_actions_outlined,
                  color:
                      _primary,
                ),
              ),
              const SizedBox(
                width:
                    10,
              ),
              Expanded(
                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      _reportType(
                        item.reportType,
                      ),
                      style:
                          const TextStyle(
                        fontSize:
                            17,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                    Text(
                      isManager
                          ? 'إلى: ${item.accountantName ?? 'المحاسب'}'
                          : 'من: ${item.requestedByName ?? 'المدير'}',
                    ),
                  ],
                ),
              ),
              _StatusBadge(
                submitted:
                    item.isSubmitted,
              ),
            ],
          ),
          const SizedBox(
            height:
                10,
          ),
          Text(
            'تاريخ الطلب: ${_dateTime(item.createdAt)}',
          ),
          if (
            item.managerNote !=
                null &&
            item.managerNote!
                .trim()
                .isNotEmpty
          ) ...[
            const SizedBox(
              height:
                  6,
            ),
            Text(
              'ملاحظة المدير: ${item.managerNote}',
            ),
          ],
          if (
            item.isPending &&
            !isManager
          ) ...[
            const SizedBox(
              height:
                  12,
            ),
            FilledButton.icon(
              onPressed:
                  provider.working
                      ? null
                      : () =>
                          _submitReport(
                        item,
                      ),
              icon:
                  const Icon(
                Icons
                    .send_outlined,
              ),
              label:
                  const Text(
                'إعداد وإرسال التقرير',
              ),
            ),
          ],
          if (
            item.isSubmitted
          ) ...[
            const SizedBox(
              height:
                  10,
            ),
            const Divider(),
            _InfoRow(
              title:
                  'الفترة',
              value:
                  '${_date(item.reportFrom)} → ${_date(item.reportTo)}',
            ),
            _InfoRow(
              title:
                  'العملة',
              value:
                  item.currencyCode ??
                      'كل العملات - بدون جمع',
            ),
            _InfoRow(
              title:
                  'وقت الإرسال',
              value:
                  item.submittedAt ==
                          null
                      ? '—'
                      : _dateTime(
                          item.submittedAt!,
                        ),
            ),
            if (
              item.accountantNote !=
                  null &&
              item.accountantNote!
                  .trim()
                  .isNotEmpty
            )
              _InfoRow(
                title:
                    'ملاحظة المحاسب',
                value:
                    item.accountantNote!,
              ),
            if (
              item.snapshot !=
              null
            )
              _SnapshotView(
                snapshot:
                    item.snapshot!,
              ),
          ],
        ],
      ),
    );
  }

  static String _reportType(
    String type,
  ) {
    const labels = {
      'all':
          'تقرير شامل',
      'incoming':
          'تقرير الوارد',
      'outgoing':
          'تقرير الصادر',
      'sales':
          'تقرير المبيعات',
      'purchases':
          'تقرير المشتريات',
      'expenses':
          'تقرير المصروفات',
      'collections':
          'تقرير تحصيلات العملاء',
      'supplier_payments':
          'تقرير دفعات الموردين',
    };

    return labels[type] ??
        type;
  }
}

class _CreateRequestResult {
  final int accountantId;
  final String reportType;
  final String? managerNote;

  const _CreateRequestResult({
    required this.accountantId,
    required this.reportType,
    this.managerNote,
  });
}

class _CreateRequestDialog
    extends StatefulWidget {
  final List<
          ReportRequestAccountantModel>
      accountants;

  const _CreateRequestDialog({
    required this.accountants,
  });

  @override
  State<_CreateRequestDialog>
      createState() =>
          _CreateRequestDialogState();
}

class _CreateRequestDialogState
    extends State<
        _CreateRequestDialog> {
  late int _accountantId;

  String _reportType =
      'all';

  final _noteController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _accountantId =
        widget.accountants
            .first.id;
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          const Text(
        'طلب تقرير من المحاسب',
      ),
      content:
          SizedBox(
        width:
            420,
        child:
            SingleChildScrollView(
          child:
              Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              DropdownButtonFormField<
                  int>(
                initialValue:
                    _accountantId,
                decoration:
                    const InputDecoration(
                  labelText:
                      'المحاسب',
                ),
                items:
                    widget
                        .accountants
                        .map(
                          (item) =>
                              DropdownMenuItem<
                                  int>(
                            value:
                                item.id,
                            child:
                                Text(
                              '${item.name} - ${item.email}',
                            ),
                          ),
                        )
                        .toList(),
                onChanged:
                    (value) {
                  if (
                    value != null
                  ) {
                    setState(() {
                      _accountantId =
                          value;
                    });
                  }
                },
              ),
              const SizedBox(
                height:
                    12,
              ),
              DropdownButtonFormField<
                  String>(
                initialValue:
                    _reportType,
                decoration:
                    const InputDecoration(
                  labelText:
                      'نوع التقرير',
                ),
                items:
                    const [
                  DropdownMenuItem(
                    value:
                        'all',
                    child:
                        Text(
                      'تقرير شامل',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'incoming',
                    child:
                        Text(
                      'الوارد',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'outgoing',
                    child:
                        Text(
                      'الصادر',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'sales',
                    child:
                        Text(
                      'المبيعات',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'purchases',
                    child:
                        Text(
                      'المشتريات',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'expenses',
                    child:
                        Text(
                      'المصروفات',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'collections',
                    child:
                        Text(
                      'تحصيلات العملاء',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'supplier_payments',
                    child:
                        Text(
                      'دفعات الموردين',
                    ),
                  ),
                ],
                onChanged:
                    (value) {
                  if (
                    value != null
                  ) {
                    setState(() {
                      _reportType =
                          value;
                    });
                  }
                },
              ),
              const SizedBox(
                height:
                    12,
              ),
              TextField(
                controller:
                    _noteController,
                maxLines:
                    3,
                maxLength:
                    1500,
                decoration:
                    const InputDecoration(
                  labelText:
                      'ملاحظة للمحاسب - اختياري',
                  hintText:
                      'مثال: أرسل تقرير حركة الدكان للفترة المطلوبة.',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed:
              () =>
                  Navigator.pop(
            context,
          ),
          child:
              const Text(
            'إلغاء',
          ),
        ),
        FilledButton.icon(
          onPressed:
              () {
            final note =
                _noteController.text
                    .trim();

            Navigator.pop(
              context,
              _CreateRequestResult(
                accountantId:
                    _accountantId,
                reportType:
                    _reportType,
                managerNote:
                    note.isEmpty
                        ? null
                        : note,
              ),
            );
          },
          icon:
              const Icon(
            Icons
                .send_outlined,
          ),
          label:
              const Text(
            'إرسال الطلب',
          ),
        ),
      ],
    );
  }
}

class _SubmitReportResult {
  final DateTime from;
  final DateTime to;
  final int? currencyId;
  final String? note;

  const _SubmitReportResult({
    required this.from,
    required this.to,
    this.currencyId,
    this.note,
  });
}

class _SubmitReportSheet
    extends StatefulWidget {
  final ReportRequestModel item;

  const _SubmitReportSheet({
    required this.item,
  });

  @override
  State<_SubmitReportSheet>
      createState() =>
          _SubmitReportSheetState();
}

class _SubmitReportSheetState
    extends State<
        _SubmitReportSheet> {
  late DateTime _from;
  late DateTime _to;

  int _currencyId =
      0;

  final _noteController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    final now =
        DateTime.now();

    _from =
        DateTime(
      now.year,
      now.month,
      1,
    );

    _to =
        DateTime(
      now.year,
      now.month,
      now.day,
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickFrom() async {
    final value =
        await showDatePicker(
      context:
          context,
      initialDate:
          _from,
      firstDate:
          DateTime(2020),
      lastDate:
          DateTime(2100),
    );

    if (
      value == null ||
      !mounted
    ) {
      return;
    }

    setState(() {
      _from =
          value;

      if (
        _to.isBefore(
          value,
        )
      ) {
        _to =
            value;
      }
    });
  }

  Future<void> _pickTo() async {
    final value =
        await showDatePicker(
      context:
          context,
      initialDate:
          _to,
      firstDate:
          _from,
      lastDate:
          DateTime(2100),
    );

    if (
      value == null ||
      !mounted
    ) {
      return;
    }

    setState(() {
      _to =
          value;
    });
  }

  String _date(
    DateTime value,
  ) {
    String two(int n) =>
        n
            .toString()
            .padLeft(
              2,
              '0',
            );

    return '${value.year}-'
        '${two(value.month)}-'
        '${two(value.day)}';
  }

  @override
  Widget build(BuildContext context) {
    final reference =
        context.watch<
            ReferenceDataProvider>();

    return Container(
      decoration:
          const BoxDecoration(
        color:
            Colors.white,
        borderRadius:
            BorderRadius.vertical(
          top:
              Radius.circular(
            22,
          ),
        ),
      ),
      padding:
          EdgeInsets.fromLTRB(
        20,
        20,
        20,
        20 +
            MediaQuery.viewInsetsOf(
              context,
            ).bottom,
      ),
      child:
          SafeArea(
        top:
            false,
        child:
            SingleChildScrollView(
          child:
              Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .stretch,
            mainAxisSize:
                MainAxisSize.min,
            children: [
              Text(
                'إرسال ${_ReportRequestsScreenState._reportType(widget.item.reportType)}',
                style:
                    const TextStyle(
                  fontSize:
                      20,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
              const SizedBox(
                height:
                    6,
              ),
              const Text(
                'حدد الفترة التي يريدها التقرير ثم أرسله للمدير.',
              ),
              const SizedBox(
                height:
                    16,
              ),
              Row(
                children: [
                  Expanded(
                    child:
                        _DateButton(
                      title:
                          'من تاريخ',
                      value:
                          _date(
                        _from,
                      ),
                      onTap:
                          _pickFrom,
                    ),
                  ),
                  const SizedBox(
                    width:
                        10,
                  ),
                  Expanded(
                    child:
                        _DateButton(
                      title:
                          'إلى تاريخ',
                      value:
                          _date(
                        _to,
                      ),
                      onTap:
                          _pickTo,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height:
                    12,
              ),
              DropdownButtonFormField<
                  int>(
                initialValue:
                    _currencyId,
                decoration:
                    const InputDecoration(
                  labelText:
                      'العملة',
                ),
                items: [
                  const DropdownMenuItem<
                      int>(
                    value:
                        0,
                    child:
                        Text(
                      'كل العملات - بدون جمع',
                    ),
                  ),
                  ...reference
                      .activeCurrencies
                      .map(
                        (item) =>
                            DropdownMenuItem<
                                int>(
                          value:
                              item.id,
                          child:
                              Text(
                            '${item.code} - ${item.symbol}',
                          ),
                        ),
                      ),
                ],
                onChanged:
                    (value) {
                  if (
                    value != null
                  ) {
                    setState(() {
                      _currencyId =
                          value;
                    });
                  }
                },
              ),
              const SizedBox(
                height:
                    12,
              ),
              TextField(
                controller:
                    _noteController,
                maxLines:
                    3,
                maxLength:
                    1500,
                decoration:
                    const InputDecoration(
                  labelText:
                      'ملاحظة للمدير - اختياري',
                ),
              ),
              const SizedBox(
                height:
                    8,
              ),
              FilledButton.icon(
                onPressed:
                    () {
                  final note =
                      _noteController
                          .text
                          .trim();

                  Navigator.pop(
                    context,
                    _SubmitReportResult(
                      from:
                          _from,
                      to:
                          _to,
                      currencyId:
                          _currencyId ==
                                  0
                              ? null
                              : _currencyId,
                      note:
                          note.isEmpty
                              ? null
                              : note,
                    ),
                  );
                },
                icon:
                    const Icon(
                  Icons
                      .send_outlined,
                ),
                label:
                    const Text(
                  'إرسال التقرير للمدير',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SnapshotView
    extends StatelessWidget {
  final ReportRequestSnapshotModel
      snapshot;

  const _SnapshotView({
    required this.snapshot,
  });

  String _money(
    int minor,
    int decimals,
    String symbol,
  ) {
    return '${MoneyUtils.formatMinor(minor, decimals)} $symbol';
  }

  String _type(
    String value,
  ) {
    const labels = {
      'sale':
          'بيع',
      'purchase':
          'شراء',
      'customer_collection':
          'تحصيل عميل',
      'supplier_payment':
          'دفع مورد',
      'expense':
          'مصروف',
      'other_income':
          'دخل آخر',
      'worker_salary_accrual':
          'استحقاق راتب',
      'worker_salary_payment':
          'دفع راتب',
      'worker_advance':
          'سلفة عامل',
      'worker_advance_recovery':
          'استرداد سلفة',
      'worker_deduction':
          'خصم عامل',
      'transfer':
          'تحويل',
    };

    return labels[value] ??
        value;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding:
          EdgeInsets.zero,
      childrenPadding:
          EdgeInsets.zero,
      title:
          const Text(
        'فتح التقرير المستلم',
        style:
            TextStyle(
          fontWeight:
              FontWeight.w700,
          color:
              Color(
            0xFF5152B9,
          ),
        ),
      ),
      subtitle:
          Text(
        '${snapshot.rowsCount} حركة',
      ),
      children: [
        ...snapshot.totals.map(
          (item) =>
              Padding(
            padding:
                const EdgeInsets.only(
              bottom:
                  8,
            ),
            child:
                Container(
              padding:
                  const EdgeInsets.all(
                12,
              ),
              decoration:
                  BoxDecoration(
                color:
                    const Color(
                      0xFFF3F3FB,
                    ),
                borderRadius:
                    BorderRadius.circular(
                  10,
                ),
              ),
              child:
                  Column(
                children: [
                  _InfoRow(
                    title:
                        'العملة',
                    value:
                        item.currencyCode,
                  ),
                  _InfoRow(
                    title:
                        'إجمالي التقرير',
                    value:
                        _money(
                      item.reportTotalMinor,
                      item.decimalPlaces,
                      item.currencySymbol,
                    ),
                  ),
                  _InfoRow(
                    title:
                        'الوارد النقدي',
                    value:
                        _money(
                      item.cashInMinor,
                      item.decimalPlaces,
                      item.currencySymbol,
                    ),
                  ),
                  _InfoRow(
                    title:
                        'الصادر النقدي',
                    value:
                        _money(
                      item.cashOutMinor,
                      item.decimalPlaces,
                      item.currencySymbol,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (
          snapshot.rows.isEmpty
        )
          const Padding(
            padding:
                EdgeInsets.all(
              12,
            ),
            child:
                Text(
              'لا توجد حركات في الفترة المحددة.',
            ),
          )
        else
          ...snapshot.rows
              .take(
                50,
              )
              .map(
                (row) =>
                    ListTile(
                  contentPadding:
                      EdgeInsets.zero,
                  dense:
                      true,
                  title:
                      Text(
                    '${_type(row.type)} • '
                    '${_money(row.reportAmountMinor, row.decimalPlaces, row.currencySymbol)}',
                  ),
                  subtitle:
                      Text(
                    row.partyName ??
                        row.workerName ??
                        row.description ??
                        row.transactionNo,
                  ),
                ),
              ),
        if (
          snapshot.rows.length >
          50
        )
          Padding(
            padding:
                const EdgeInsets.only(
              bottom:
                  8,
            ),
            child:
                Text(
              'تم عرض أول 50 حركة هنا من أصل ${snapshot.rowsCount}.',
            ),
          ),
        if (
          snapshot.truncated
        )
          const Padding(
            padding:
                EdgeInsets.only(
              bottom:
                  8,
            ),
            child:
                Text(
              'تنبيه: التقرير المحفوظ محدود بأول 2000 حركة.',
            ),
          ),
      ],
    );
  }
}

class _StatusBadge
    extends StatelessWidget {
  final bool submitted;

  const _StatusBadge({
    required this.submitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal:
            9,
        vertical:
            5,
      ),
      decoration:
          BoxDecoration(
        color:
            const Color(
              0xFF5152B9,
            ).withValues(
          alpha:
              .10,
        ),
        borderRadius:
            BorderRadius.circular(
          999,
        ),
      ),
      child:
          Text(
        submitted
            ? 'تم الإرسال'
            : 'مطلوب',
        style:
            const TextStyle(
          color:
              Color(
            0xFF5152B9,
          ),
          fontWeight:
              FontWeight.w600,
          fontSize:
              12,
        ),
      ),
    );
  }
}

class _InfoRow
    extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical:
            4,
      ),
      child:
          Row(
        crossAxisAlignment:
            CrossAxisAlignment
                .start,
        children: [
          SizedBox(
            width:
                112,
            child:
                Text(
              title,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child:
                Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateButton
    extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _DateButton({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed:
          onTap,
      style:
          OutlinedButton.styleFrom(
        padding:
            const EdgeInsets.all(
          12,
        ),
      ),
      child:
          Column(
        children: [
          Text(
            title,
          ),
          const SizedBox(
            height:
                4,
          ),
          Text(
            value,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SurfaceCard
    extends StatelessWidget {
  final Widget child;

  const _SurfaceCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.all(
        16,
      ),
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
              const Color(
                0xFFC7C5D4,
              ).withValues(
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
