import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/account_request_model.dart';
import '../../providers/account_request_provider.dart';

class AccountRequestsScreen
    extends StatefulWidget {
  const AccountRequestsScreen({
    super.key,
  });

  @override
  State<AccountRequestsScreen>
      createState() =>
          _AccountRequestsScreenState();
}

class _AccountRequestsScreenState
    extends State<
        AccountRequestsScreen> {
  static const _background =
      Color(0xFFF8F9FA);

  static const _primary =
      Color(0xFF5152B9);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) =>
          context
              .read<
                  AccountRequestProvider>()
              .load(
                status:
                    'pending',
              ),
    );
  }

  Future<void> _changeStatus(
    String status,
  ) async {
    await context
        .read<
            AccountRequestProvider>()
        .load(
          status:
              status,
        );
  }

  Future<void> _approve(
    AccountRequestModel item,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context:
          context,
      builder:
          (dialogContext) =>
              AlertDialog(
        title:
            const Text(
          'قبول طلب الحساب',
        ),
        content:
            Text(
          'هل تريد تفعيل حساب ${item.name} كـ ${_role(item.role)}؟',
        ),
        actions: [
          TextButton(
            onPressed:
                () =>
                    Navigator.pop(
              dialogContext,
              false,
            ),
            child:
                const Text(
              'إلغاء',
            ),
          ),
          FilledButton(
            onPressed:
                () =>
                    Navigator.pop(
              dialogContext,
              true,
            ),
            child:
                const Text(
              'قبول وتفعيل',
            ),
          ),
        ],
      ),
    );

    if (
      confirmed != true ||
      !mounted
    ) {
      return;
    }

    final provider =
        context.read<
            AccountRequestProvider>();

    final message =
        await provider.approve(
      item.id,
    );

    if (!mounted) {
      return;
    }

    _message(
      message ??
          provider.error ??
          'تعذر قبول الطلب.',
    );
  }

  Future<void> _reject(
    AccountRequestModel item,
  ) async {
    final controller =
        TextEditingController();

    final confirmed =
        await showDialog<bool>(
      context:
          context,
      builder:
          (dialogContext) =>
              AlertDialog(
        title:
            const Text(
          'رفض طلب الحساب',
        ),
        content:
            Column(
          mainAxisSize:
              MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment
                  .stretch,
          children: [
            Text(
              'سيتم رفض طلب ${item.name}.',
            ),
            const SizedBox(
              height:
                  12,
            ),
            TextField(
              controller:
                  controller,
              maxLines:
                  3,
              maxLength:
                  500,
              decoration:
                  const InputDecoration(
                labelText:
                    'سبب الرفض - اختياري',
                border:
                    OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed:
                () =>
                    Navigator.pop(
              dialogContext,
              false,
            ),
            child:
                const Text(
              'إلغاء',
            ),
          ),
          FilledButton(
            onPressed:
                () =>
                    Navigator.pop(
              dialogContext,
              true,
            ),
            child:
                const Text(
              'رفض الطلب',
            ),
          ),
        ],
      ),
    );

    final reason =
        controller.text.trim();

    controller.dispose();

    if (
      confirmed != true ||
      !mounted
    ) {
      return;
    }

    final provider =
        context.read<
            AccountRequestProvider>();

    final message =
        await provider.reject(
      item.id,
      reason:
          reason.isEmpty
              ? null
              : reason,
    );

    if (!mounted) {
      return;
    }

    _message(
      message ??
          provider.error ??
          'تعذر رفض الطلب.',
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

  static String _role(
    String value,
  ) {
    return value == 'manager'
        ? 'مدير'
        : 'محاسب';
  }

  String _date(
    DateTime? value,
  ) {
    if (value == null) {
      return '—';
    }

    final local =
        value.toLocal();

    String two(int number) =>
        number
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

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<
            AccountRequestProvider>();

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
            const Text(
          'طلبات إنشاء الحسابات',
          style:
              TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
      body:
          RefreshIndicator(
        onRefresh:
            () =>
                provider.load(),
        child:
            ListView(
          padding:
              const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            36,
          ),
          children: [
            _SurfaceCard(
              child:
                  Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .stretch,
                children: [
                  const Text(
                    'الحسابات المسموحة',
                    style:
                        TextStyle(
                      fontSize:
                          18,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height:
                        6,
                  ),
                  const Text(
                    'مدير أو محاسب فقط. أي حساب جديد يبقى معلقًا حتى يتم قبوله من المدير.',
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
                          'بانتظار الموافقة',
                        ),
                        selected:
                            provider.status ==
                            'pending',
                        onSelected:
                            (_) =>
                                _changeStatus(
                          'pending',
                        ),
                      ),
                      ChoiceChip(
                        label:
                            const Text(
                          'تمت الموافقة',
                        ),
                        selected:
                            provider.status ==
                            'active',
                        onSelected:
                            (_) =>
                                _changeStatus(
                          'active',
                        ),
                      ),
                      ChoiceChip(
                        label:
                            const Text(
                          'مرفوضة',
                        ),
                        selected:
                            provider.status ==
                            'rejected',
                        onSelected:
                            (_) =>
                                _changeStatus(
                          'rejected',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height:
                  12,
            ),
            if (
              provider.loading
            )
              const LinearProgressIndicator(),
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
            if (
              !provider.loading &&
              provider.items.isEmpty
            ) ...[
              const SizedBox(
                height:
                    10,
              ),
              const _SurfaceCard(
                child:
                    Column(
                  children: [
                    Icon(
                      Icons
                          .inbox_outlined,
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
                      'لا توجد طلبات في هذه القائمة.',
                      textAlign:
                          TextAlign.center,
                    ),
                  ],
                ),
              ),
            ] else
              ...provider.items.map(
                (item) =>
                    Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom:
                        8,
                  ),
                  child:
                      _requestCard(
                    provider,
                    item,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _requestCard(
    AccountRequestProvider provider,
    AccountRequestModel item,
  ) {
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
                      .30,
                ),
                child:
                    const Icon(
                  Icons
                      .person_outline,
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
                      item.name,
                      style:
                          const TextStyle(
                        fontSize:
                            17,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                    Text(
                      item.email,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal:
                      10,
                  vertical:
                      5,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      _primary.withValues(
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
                  _role(
                    item.role,
                  ),
                  style:
                      const TextStyle(
                    color:
                        _primary,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height:
                12,
          ),
          Text(
            item.isPending
                ? 'تاريخ الطلب: ${_date(item.requestedAt)}'
                : 'تاريخ المراجعة: ${_date(item.reviewedAt)}',
          ),
          if (
            item.reviewedByName !=
            null
          )
            Text(
              'راجعه: ${item.reviewedByName}',
            ),
          if (
            item.isRejected &&
            item.rejectionReason !=
                null &&
            item.rejectionReason!
                .trim()
                .isNotEmpty
          ) ...[
            const SizedBox(
              height:
                  6,
            ),
            Text(
              'سبب الرفض: ${item.rejectionReason}',
            ),
          ],
          if (
            item.isPending
          ) ...[
            const SizedBox(
              height:
                  12,
            ),
            Row(
              children: [
                Expanded(
                  child:
                      FilledButton.icon(
                    onPressed:
                        provider.working
                            ? null
                            : () =>
                                _approve(
                              item,
                            ),
                    icon:
                        const Icon(
                      Icons
                          .check_circle_outline,
                    ),
                    label:
                        const Text(
                      'قبول',
                    ),
                  ),
                ),
                const SizedBox(
                  width:
                      8,
                ),
                Expanded(
                  child:
                      OutlinedButton.icon(
                    onPressed:
                        provider.working
                            ? null
                            : () =>
                                _reject(
                              item,
                            ),
                    icon:
                        const Icon(
                      Icons
                          .cancel_outlined,
                    ),
                    label:
                        const Text(
                      'رفض',
                    ),
                  ),
                ),
              ],
            ),
          ],
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
                Colors.black.withValues(
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
