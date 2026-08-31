import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/config/app_config.dart';
import '../../core/utils/money_utils.dart';
import '../../models/home_financial_summary_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/reference_data_provider.dart';
import '../../providers/sync_provider.dart';
import '../accounting/transactions_screen.dart';
import '../admin/system_admin_screen.dart';
import '../admin/account_requests_screen.dart';
import '../commerce/sale_purchase_form_screen.dart';
import '../commerce/simple_sale_screen.dart';
import '../daily/daily_operations_screen.dart';
import '../dashboard/manager_dashboard_screen.dart';
import '../parties/parties_screen.dart';
import '../products/products_screen.dart';
import '../reports/reports_screen.dart';
import '../reports/report_requests_screen.dart';
import '../settings/accounting_settings_screen.dart';
import '../workers/workers_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  static const _background =
      Color(0xFFF8F9FA);

  static const _onBackground =
      Color(0xFF191C1D);

  static const _onSurfaceVariant =
      Color(0xFF464552);

  static const _primary =
      Color(0xFF5152B9);

  static const _primaryContainer =
      Color(0xFF8E8FFA);

  static const _outlineVariant =
      Color(0xFFC7C5D4);

  Timer? _syncTimer;

  int? _selectedCurrencyId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) async {
        await context
            .read<
                ReferenceDataProvider>()
            .load();

        if (!mounted) {
          return;
        }

        await context
            .read<SyncProvider>()
            .refreshCounts();

        if (!mounted) {
          return;
        }

        await _autoSync();

        _syncTimer =
            Timer.periodic(
          const Duration(
            seconds: 30,
          ),
          (_) {
            _autoSync();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshDashboard() async {
    if (!mounted) {
      return;
    }

    final user =
        context
            .read<AuthProvider>()
            .user;

    final canSeeFinancialSummary =
        user?.isManager == true ||
        user?.role == 'accountant';

    if (!canSeeFinancialSummary) {
      return;
    }

    await context
        .read<DashboardProvider>()
        .load();

    if (!mounted) {
      return;
    }

    final summaries =
        context
            .read<DashboardProvider>()
            .summaries;

    if (
      summaries.isNotEmpty &&
      !summaries.any(
        (item) =>
            item.currencyId ==
            _selectedCurrencyId,
      )
    ) {
      setState(() {
        _selectedCurrencyId =
            summaries.first.currencyId;
      });
    }
  }

  Future<void> _autoSync() async {
    if (!mounted) {
      return;
    }

    final result =
        await context
            .read<SyncProvider>()
            .syncNow(
              silent: true,
            );

    if (!mounted) {
      return;
    }

    if (
      result.synced > 0 ||
      result.failed > 0
    ) {
      await context
          .read<AccountingProvider>()
          .load();

      if (!mounted) {
        return;
      }

      await context
          .read<ProductProvider>()
          .load();
    }

    if (mounted) {
      await _refreshDashboard();
    }
  }

  Future<void> _manualSync() async {
    final result =
        await context
            .read<SyncProvider>()
            .syncNow(
              includeFailed: true,
            );

    if (!mounted) {
      return;
    }

    if (
      result.synced > 0 ||
      result.failed > 0
    ) {
      await context
          .read<AccountingProvider>()
          .load();

      if (!mounted) {
        return;
      }

      await context
          .read<ProductProvider>()
          .load();
    }

    if (!mounted) {
      return;
    }

    await _refreshDashboard();

    if (!mounted) {
      return;
    }

    final sync =
        context.read<SyncProvider>();

    final message =
        sync.lastMessage;

    if (
      message != null &&
      message.isNotEmpty
    ) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(message),
        ),
      );
    }
  }

  Future<void> _open(
    Widget screen, {
    bool refreshDashboard = true,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );

    if (
      mounted &&
      refreshDashboard
    ) {
      await _refreshDashboard();
    }
  }

  HomeFinancialSummaryModel?
      _selectedSummary(
    List<HomeFinancialSummaryModel>
        summaries,
  ) {
    if (summaries.isEmpty) {
      return null;
    }

    final selectedId =
        _selectedCurrencyId ??
        summaries.first.currencyId;

    for (final item in summaries) {
      if (
        item.currencyId ==
        selectedId
      ) {
        return item;
      }
    }

    return summaries.first;
  }

  String _money(
    int value,
    HomeFinancialSummaryModel
        summary,
  ) {
    return '${MoneyUtils.formatMinor(value, summary.decimalPlaces)} ${summary.currencySymbol}';
  }

  @override
  Widget build(BuildContext context) {
    final auth =
        context.watch<AuthProvider>();

    final reference =
        context.watch<
            ReferenceDataProvider>();

    final sync =
        context.watch<SyncProvider>();

    final dashboard =
        context.watch<
            DashboardProvider>();

    final user = auth.user!;

    final summary =
        _selectedSummary(
      dashboard.summaries,
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
        scrolledUnderElevation: 0,
        title: const Row(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            Flexible(
              child:
                  Text(
                AppConfig.appName,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width:
                  8,
            ),
            _VersionBadge(),
          ],
        ),
        actions: [
          _SyncIconButton(
            syncing:
                sync.syncing,
            pending:
                sync.pending,
            failed:
                sync.failed,
            onPressed:
                sync.syncing
                    ? null
                    : _manualSync,
          ),
          IconButton(
            tooltip:
                'تسجيل الخروج',
            color: _primary,
            onPressed:
                auth.isLoading
                    ? null
                    : () {
                        context
                            .read<
                                AuthProvider>()
                            .logout();
                      },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _manualSync();

          if (mounted) {
            await _refreshDashboard();
          }
        },
        child: ListView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            16,
            20,
            36,
          ),
          children: [
            _SurfaceCard(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Text(
                    'مرحبًا ${user.name}',
                    style:
                        const TextStyle(
                      color: _primary,
                      fontSize: 22,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    user.isManager
                        ? 'الصلاحية: مدير المحل'
                        : 'الصلاحية: محاسب الدكان',
                    style:
                        const TextStyle(
                      color:
                          _onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            if (
              user.isManager ||
              user.role == 'accountant'
            ) ...[
              const SizedBox(
                height: 22,
              ),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'الملخص المالي',
                      style:
                          TextStyle(
                        color:
                            _onBackground,
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),

                  if (
                    dashboard
                        .summaries
                        .isNotEmpty
                  )
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
                            BorderRadius
                                .circular(
                          999,
                        ),
                        border:
                            Border.all(
                          color:
                              _outlineVariant
                                  .withValues(
                            alpha: 0.45,
                          ),
                        ),
                      ),
                      child:
                          DropdownButtonHideUnderline(
                        child:
                            DropdownButton<
                                int>(
                          value:
                              summary
                                  ?.currencyId,
                          borderRadius:
                              BorderRadius
                                  .circular(
                            12,
                          ),
                          icon:
                              const Icon(
                            Icons
                                .keyboard_arrow_down,
                            color:
                                _primary,
                          ),
                          items:
                              dashboard
                                  .summaries
                                  .map(
                                    (
                                      item,
                                    ) =>
                                        DropdownMenuItem<
                                            int>(
                                      value:
                                          item
                                              .currencyId,
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

                            setState(
                              () {
                                _selectedCurrencyId =
                                    value;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              if (
                dashboard.loading &&
                summary == null
              )
                const _SurfaceCard(
                  child: Center(
                    child:
                        Padding(
                      padding:
                          EdgeInsets
                              .all(
                        16,
                      ),
                      child:
                          CircularProgressIndicator(),
                    ),
                  ),
                )
              else if (
                summary != null
              ) ...[
                LayoutBuilder(
                  builder:
                      (
                    context,
                    constraints,
                  ) {
                    final wide =
                        constraints
                                .maxWidth >=
                            720;

                    final cards = [
                      _FinancialMetricCard(
                        icon: Icons
                            .south_west_rounded,
                        title: 'الوارد',
                        value:
                            _money(
                          summary
                              .incomingMinor,
                          summary,
                        ),
                        subtitle:
                            'كل الأموال التي دخلت فعليًا للحسابات',
                      ),
                      _FinancialMetricCard(
                        icon: Icons
                            .north_east_rounded,
                        title: 'الصادر',
                        value:
                            _money(
                          summary
                              .outgoingMinor,
                          summary,
                        ),
                        subtitle:
                            'كل الأموال التي خرجت فعليًا من الحسابات',
                      ),
                      _FinancialMetricCard(
                        icon: Icons
                            .account_balance_wallet_outlined,
                        title: 'الأرباح',
                        value:
                            _money(
                          summary
                              .cashResultMinor,
                          summary,
                        ),
                        subtitle:
                            'الوارد − الصادر',
                      ),
                    ];

                    if (wide) {
                      return Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .stretch,
                        children: [
                          Expanded(
                            child:
                                cards[0],
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child:
                                cards[1],
                          ),
                          const SizedBox(
                            width: 12,
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

                _SurfaceCard(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .stretch,
                    children: [
                      const Text(
                        'تفاصيل الحساب',
                        style:
                            TextStyle(
                          color:
                              _onBackground,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      _DetailRow(
                        title:
                            'مشتريات البضاعة',
                        value:
                            _money(
                          summary
                              .purchasesTotalMinor,
                          summary,
                        ),
                      ),

                      _DetailRow(
                        title:
                            'المدفوع للموردين',
                        value:
                            _money(
                          summary
                              .supplierPaidMinor,
                          summary,
                        ),
                      ),

                      _DetailRow(
                        title:
                            'إجمالي المبيعات',
                        value:
                            _money(
                          summary
                              .salesTotalMinor,
                          summary,
                        ),
                      ),

                      _DetailRow(
                        title:
                            'المقبوض مباشرة من المبيعات',
                        value:
                            _money(
                          summary
                              .salesReceivedMinor,
                          summary,
                        ),
                      ),

                      _DetailRow(
                        title:
                            'تحصيلات العملاء',
                        value:
                            _money(
                          summary
                              .customerCollectionsMinor,
                          summary,
                        ),
                      ),

                      _DetailRow(
                        title:
                            'المصاريف',
                        value:
                            _money(
                          summary
                              .expensesMinor,
                          summary,
                        ),
                      ),

                      _DetailRow(
                        title:
                            'رواتب مدفوعة',
                        value:
                            _money(
                          summary
                              .workerSalaryPaymentsMinor,
                          summary,
                        ),
                      ),

                      _DetailRow(
                        title:
                            'سلف عمال مدفوعة',
                        value:
                            _money(
                          summary
                              .workerAdvancesMinor,
                          summary,
                        ),
                        showDivider:
                            false,
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        padding:
                            const EdgeInsets
                                .all(
                          12,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              _primaryContainer
                                  .withValues(
                            alpha: 0.12,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            10,
                          ),
                        ),
                        child:
                            const Text(
                          'الأرباح هنا حسب طلبك = الوارد النقدي − الصادر النقدي. المشتريات الآجلة تظهر في مشتريات البضاعة، لكنها لا تدخل الصادر إلا عند الدفع للمورد.',
                          style:
                              TextStyle(
                            color:
                                _onSurfaceVariant,
                            height:
                                1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (
                  dashboard.fromLocal
                ) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  const _StatusCard(
                    icon: Icons
                        .offline_bolt_outlined,
                    text:
                        'الملخص المالي محسوب حاليًا من البيانات المحفوظة على هذا الجهاز.',
                  ),
                ],
              ] else
                const _SurfaceCard(
                  child: Text(
                    'لا توجد بيانات مالية حتى الآن.',
                    textAlign:
                        TextAlign.center,
                  ),
                ),
            ],

            if (
              auth.localTrustedSession ||
              reference.fromLocal
            ) ...[
              const SizedBox(
                height: 12,
              ),
              const _StatusCard(
                icon: Icons
                    .offline_bolt_outlined,
                text:
                    'التطبيق يستخدم البيانات المحلية المتاحة على هذا الجهاز.',
              ),
            ],

            if (
              sync.attentionCount > 0
            ) ...[
              const SizedBox(
                height: 12,
              ),
              _SurfaceCard(
                child: Row(
                  children: [
                    Icon(
                      sync.failed > 0
                          ? Icons
                              .sync_problem_outlined
                          : Icons
                              .cloud_upload_outlined,
                      color:
                          _primary,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        sync.failed > 0
                            ? 'بانتظار المزامنة: ${sync.pending} • تحتاج انتباه: ${sync.failed}'
                            : 'يوجد ${sync.pending} حركة محفوظة محليًا بانتظار المزامنة.',
                        style:
                            const TextStyle(
                          color:
                              _onSurfaceVariant,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed:
                          sync.syncing
                              ? null
                              : _manualSync,
                      child:
                          const Text(
                        'مزامنة',
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(
              height: 18,
            ),

            _HomeActionCard(
              icon:
                  Icons.flash_on_outlined,
              title:
                  'الحركات اليومية',
              subtitle:
                  'بيع، مصروف، تحصيل، دفع مورد، رواتب وسلف بسرعة',
              onTap: () =>
                  _open(
                const DailyOperationsScreen(),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 2,
              ),
              child: Text(
                'السجلات المالية',
                style: TextStyle(
                  color:
                      _onBackground,
                  fontSize: 21,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),

            _HomeActionCard(
              icon:
                  Icons.people_outline,
              title:
                  'العملاء',
              subtitle:
                  'إضافة أسماء العملاء ومتابعة حركاتهم لاحقًا',
              onTap: () =>
                  _open(
                const PartiesScreen(
                  initialFilter:
                      'customer',
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _HomeActionCard(
              icon:
                  Icons.local_shipping_outlined,
              title:
                  'الموردون',
              subtitle:
                  'إضافة أسماء الموردين ومتابعة حركاتهم لاحقًا',
              onTap: () =>
                  _open(
                const PartiesScreen(
                  initialFilter:
                      'supplier',
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _HomeActionCard(
              icon:
                  Icons.badge_outlined,
              title:
                  'العمال',
              subtitle:
                  'الأجور والسلف والمستحقات والدفعات',
              onTap: () =>
                  _open(
                const WorkersScreen(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _HomeActionCard(
              icon:
                  Icons.inventory_2_outlined,
              title:
                  'الأصناف والخدمات',
              subtitle:
                  'المخزون والأسعار ومتوسط التكلفة',
              onTap: () =>
                  _open(
                const ProductsScreen(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _HomeActionCard(
              icon:
                  Icons.point_of_sale_outlined,
              title:
                  'عملية بيع',
              subtitle:
                  'بيع مباشر بدون أصناف: نقدي أو آجل أو مختلط',
              onTap: () =>
                  _open(
                const SimpleSaleScreen(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _HomeActionCard(
              icon:
                  Icons.shopping_cart_outlined,
              title:
                  'عملية شراء',
              subtitle:
                  'إدخال البضاعة وتسجيل ما تم دفعه للمورد',
              onTap: () =>
                  _open(
                const SalePurchaseFormScreen(
                  isSale: false,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _HomeActionCard(
              icon:
                  Icons.receipt_long_outlined,
              title:
                  'الحركات المحاسبية',
              subtitle:
                  'عرض جميع الحركات والحالات والمزامنة',
              onTap: () =>
                  _open(
                const TransactionsScreen(),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            _HomeActionCard(
              icon:
                  Icons.mark_email_unread_outlined,
              title:
                  'طلبات التقارير',
              subtitle:
                  user.isManager
                      ? 'اطلب تقريرًا من المحاسب واستقبل التقرير بعد إرساله'
                      : 'استقبل طلب المدير وحدد من تاريخ إلى تاريخ ثم أرسل التقرير',
              onTap: () =>
                  _open(
                const ReportRequestsScreen(),
                refreshDashboard:
                    false,
              ),
            ),

            if (
              user.isManager ||
              user.isAccountant
            ) ...[
              const SizedBox(
                height: 10,
              ),

              _HomeActionCard(
                icon:
                    Icons.dashboard_outlined,
                title:
                    'لوحة المدير الكاملة',
                subtitle:
                    'أرصدة، ديون، وارد، صادر، مبيعات، مصروفات وفلاتر زمنية',
                onTap: () =>
                    _open(
                  const ManagerDashboardScreen(),
                  refreshDashboard:
                      true,
                ),
              ),
            ],

            if (
              user.isManager
            ) ...[
              const SizedBox(
                height: 10,
              ),

              _HomeActionCard(
                icon:
                    Icons.assessment_outlined,
                title:
                    'التقارير والتصدير',
                subtitle:
                    'تقارير حسب الفترة + كشف عميل ومورد وعامل + PDF وExcel',
                onTap: () =>
                    _open(
                  const ReportsScreen(),
                  refreshDashboard:
                      false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              const Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                child: Text(
                  'النظام',
                  style:
                      TextStyle(
                    color:
                        _onBackground,
                    fontSize:
                        21,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              _HomeActionCard(
                icon:
                    Icons.how_to_reg_outlined,
                title:
                    'طلبات إنشاء الحسابات',
                subtitle:
                    'قبول أو رفض طلبات المدير والمحاسب قبل السماح بتسجيل الدخول',
                onTap: () =>
                    _open(
                  const AccountRequestsScreen(),
                  refreshDashboard:
                      false,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              _HomeActionCard(
                icon:
                    Icons.security_outlined,
                title:
                    'الأمان والنسخ الاحتياطية',
                subtitle:
                    'سجل النشاط + إنشاء وتنزيل واستعادة النسخ الاحتياطية',
                onTap: () =>
                    _open(
                  const SystemAdminScreen(),
                  refreshDashboard:
                      false,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              _HomeActionCard(
                icon:
                    Icons.settings_outlined,
                title:
                    'الإعدادات المحاسبية',
                subtitle:
                    'العملات والحسابات المالية والتصنيفات',
                onTap: () =>
                    _open(
                  const AccountingSettingsScreen(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FinancialMetricCard
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
  final String subtitle;

  const _FinancialMetricCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
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
              shape: BoxShape.circle,
              color:
                  _primaryContainer
                      .withValues(
                alpha: 0.30,
              ),
            ),
            alignment:
                Alignment.center,
            child: Icon(
              icon,
              color:
                  _primary,
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        _onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  value,
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      const TextStyle(
                    color:
                        _onBackground,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      const TextStyle(
                    color:
                        _onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow
    extends StatelessWidget {
  static const _onBackground =
      Color(0xFF191C1D);

  static const _onSurfaceVariant =
      Color(0xFF464552);

  static const _outlineVariant =
      Color(0xFFC7C5D4);

  final String title;
  final String value;
  final bool showDivider;

  const _DetailRow({
    required this.title,
    required this.value,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets
                  .symmetric(
            vertical: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    color:
                        _onSurfaceVariant,
                  ),
                ),
              ),
              Text(
                value,
                style:
                    const TextStyle(
                  color:
                      _onBackground,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            color:
                _outlineVariant
                    .withValues(
              alpha: 0.38,
            ),
          ),
      ],
    );
  }
}

class _StatusCard
    extends StatelessWidget {
  static const _primary =
      Color(0xFF5152B9);

  static const _onSurfaceVariant =
      Color(0xFF464552);

  final IconData icon;
  final String text;

  const _StatusCard({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Row(
        children: [
          Icon(
            icon,
            color:
                _primary,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              text,
              style:
                  const TextStyle(
                color:
                    _onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SurfaceCard
    extends StatelessWidget {
  static const _outlineVariant =
      Color(0xFFC7C5D4);

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
              _outlineVariant
                  .withValues(
            alpha: 0.30,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black
                    .withValues(
              alpha: 0.04,
            ),
            blurRadius: 20,
            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _HomeActionCard
    extends StatelessWidget {
  static const _primary =
      Color(0xFF5152B9);

  static const _primaryContainer =
      Color(0xFF8E8FFA);

  static const _onBackground =
      Color(0xFF191C1D);

  static const _onSurfaceVariant =
      Color(0xFF464552);

  static const _outlineVariant =
      Color(0xFFC7C5D4);

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        child: Ink(
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
                  _outlineVariant
                      .withValues(
                alpha: 0.30,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black
                        .withValues(
                  alpha: 0.04,
                ),
                blurRadius: 20,
                offset:
                    const Offset(
                  0,
                  4,
                ),
              ),
            ],
          ),
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
                    alpha: 0.30,
                  ),
                ),
                alignment:
                    Alignment.center,
                child: Icon(
                  icon,
                  color:
                      _primary,
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(
                        color:
                            _onBackground,
                        fontSize:
                            17,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      subtitle,
                      style:
                          const TextStyle(
                        color:
                            _onSurfaceVariant,
                        fontSize:
                            13,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_left,
                color:
                    _onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VersionBadge
    extends StatelessWidget {
  const _VersionBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal:
            8,
        vertical:
            3,
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
          const Text(
        AppConfig.releaseLabel,
        style:
            TextStyle(
          color:
              Color(
            0xFF5152B9,
          ),
          fontSize:
              11,
          fontWeight:
              FontWeight.w700,
        ),
      ),
    );
  }
}

class _SyncIconButton
    extends StatelessWidget {
  static const _primary =
      Color(0xFF5152B9);

  final bool syncing;
  final int pending;
  final int failed;
  final VoidCallback? onPressed;

  const _SyncIconButton({
    required this.syncing,
    required this.pending,
    required this.failed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final count =
        pending + failed;

    return IconButton(
      tooltip: count > 0
          ? 'مزامنة $count حركة'
          : 'مزامنة',
      onPressed:
          onPressed,
      color:
          _primary,
      icon: Stack(
        clipBehavior:
            Clip.none,
        children: [
          Icon(
            syncing
                ? Icons.sync
                : failed > 0
                    ? Icons
                        .sync_problem_outlined
                    : Icons.sync,
          ),
          if (count > 0)
            Positioned(
              left: -7,
              top: -7,
              child: Container(
                constraints:
                    const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 4,
                ),
                alignment:
                    Alignment.center,
                decoration:
                    BoxDecoration(
                  color:
                      Theme.of(
                    context,
                  )
                          .colorScheme
                          .error,
                  borderRadius:
                      BorderRadius
                          .circular(
                    10,
                  ),
                ),
                child: Text(
                  count > 99
                      ? '99+'
                      : '$count',
                  style:
                      const TextStyle(
                    fontSize: 10,
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
