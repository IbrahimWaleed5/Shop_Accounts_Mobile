import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/audit_log_model.dart';
import '../../models/system_backup_model.dart';
import '../../providers/system_admin_provider.dart';

class SystemAdminScreen
    extends StatefulWidget {
  const SystemAdminScreen({
    super.key,
  });

  @override
  State<SystemAdminScreen>
      createState() =>
          _SystemAdminScreenState();
}

class _SystemAdminScreenState
    extends State<SystemAdminScreen> {
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
                  SystemAdminProvider>()
              .loadAll(),
    );
  }

  Future<void> _createBackup() async {
    final provider =
        context.read<
            SystemAdminProvider>();

    final ok =
        await provider.createBackup();

    if (!mounted) {
      return;
    }

    _message(
      ok
          ? 'تم إنشاء النسخة الاحتياطية.'
          : provider.error ??
              'تعذر إنشاء النسخة.',
    );
  }

  Future<void> _shareBackup(
    SystemBackupModel backup,
  ) async {
    final provider =
        context.read<
            SystemAdminProvider>();

    final bytes =
        await provider.downloadBackup(
      backup.id,
    );

    if (
      !mounted ||
      bytes == null
    ) {
      if (mounted) {
        _message(
          provider.error ??
              'تعذر تنزيل النسخة.',
        );
      }

      return;
    }

    await SharePlus.instance.share(
      ShareParams(
        title:
            'نسخة احتياطية',
        text:
            backup.fileName,
        files: [
          XFile.fromData(
            bytes,
            mimeType:
                'application/json',
          ),
        ],
        fileNameOverrides: [
          backup.fileName,
        ],
      ),
    );
  }

  Future<void> _restore(
    SystemBackupModel backup,
  ) async {
    final controller =
        TextEditingController();

    final confirmed =
        await showDialog<bool>(
      context:
          context,
      barrierDismissible:
          false,
      builder:
          (dialogContext) =>
              AlertDialog(
        title:
            const Text(
          'استعادة نسخة احتياطية',
        ),
        content:
            Column(
          mainAxisSize:
              MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            const Text(
              'هذه العملية تستبدل بيانات النظام بالبيانات الموجودة في النسخة المحددة.',
            ),
            const SizedBox(
              height:
                  8,
            ),
            const Text(
              'سيتم إنشاء نسخة أمان تلقائيًا قبل الاستعادة.',
              style:
                  TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            const SizedBox(
              height:
                  12,
            ),
            const Text(
              'للتأكيد اكتب بالضبط:',
            ),
            const SelectableText(
              'RESTORE_BACKUP',
              style:
                  TextStyle(
                fontWeight:
                    FontWeight.w700,
                color:
                    _primary,
              ),
            ),
            const SizedBox(
              height:
                  8,
            ),
            TextField(
              controller:
                  controller,
              autofocus:
                  true,
              decoration:
                  const InputDecoration(
                labelText:
                    'كلمة التأكيد',
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
                () {
              Navigator.pop(
                dialogContext,
                controller.text
                        .trim() ==
                    'RESTORE_BACKUP',
              );
            },
            child:
                const Text(
              'استعادة',
            ),
          ),
        ],
      ),
    );

    controller.dispose();

    if (
      confirmed != true ||
      !mounted
    ) {
      if (
        confirmed == false &&
        mounted
      ) {
        _message(
          'لم يتم تنفيذ الاستعادة.',
        );
      }

      return;
    }

    final provider =
        context.read<
            SystemAdminProvider>();

    final message =
        await provider.restoreBackup(
      backup.id,
    );

    if (!mounted) {
      return;
    }

    _message(
      message ??
          provider.error ??
          'تعذر الاستعادة.',
    );
  }

  Future<void> _delete(
    SystemBackupModel backup,
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
          'حذف النسخة',
        ),
        content:
            Text(
          'هل تريد حذف ${backup.fileName}؟',
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
              'حذف',
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
            SystemAdminProvider>();

    final ok =
        await provider.deleteBackup(
      backup.id,
    );

    if (!mounted) {
      return;
    }

    _message(
      ok
          ? 'تم حذف النسخة.'
          : provider.error ??
              'تعذر حذف النسخة.',
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

  String _size(
    int bytes,
  ) {
    if (bytes < 1024) {
      return '$bytes B';
    }

    if (
      bytes <
      1024 * 1024
    ) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }

    return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
  }

  String _dateTime(
    DateTime value,
  ) {
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

  String _action(
    String value,
  ) {
    const labels = {
      'create':
          'إضافة',
      'update':
          'تعديل',
      'delete':
          'حذف',
      'reverse':
          'عكس حركة',
      'sync_push':
          'مزامنة',
      'upload_attachment':
          'رفع مرفق',
      'delete_attachment':
          'حذف مرفق',
      'create_backup':
          'إنشاء نسخة',
      'restore_backup':
          'استعادة نسخة',
      'logout':
          'تسجيل خروج',
    };

    return labels[value] ??
        value;
  }

  String _pretty(
    Map<String, dynamic>? value,
  ) {
    if (
      value == null ||
      value.isEmpty
    ) {
      return '—';
    }

    return const JsonEncoder
        .withIndent('  ')
        .convert(
          value,
        );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:
          2,
      child:
          Scaffold(
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
            'الأمان والنسخ الاحتياطية',
            style:
                TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),
          bottom:
              const TabBar(
            tabs: [
              Tab(
                icon:
                    Icon(
                  Icons
                      .history_outlined,
                ),
                text:
                    'سجل النشاط',
              ),
              Tab(
                icon:
                    Icon(
                  Icons
                      .backup_outlined,
                ),
                text:
                    'النسخ الاحتياطية',
              ),
            ],
          ),
        ),
        body:
            TabBarView(
          children: [
            _auditTab(),
            _backupTab(),
          ],
        ),
      ),
    );
  }

  Widget _auditTab() {
    final provider =
        context.watch<
            SystemAdminProvider>();

    if (
      provider.loadingAudit &&
      provider.auditLogs.isEmpty
    ) {
      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh:
          provider.loadAuditLogs,
      child:
          provider.auditLogs.isEmpty
              ? ListView(
                  padding:
                      const EdgeInsets.all(
                    24,
                  ),
                  children:
                      const [
                    SizedBox(
                      height:
                          80,
                    ),
                    Icon(
                      Icons
                          .history_outlined,
                      size:
                          58,
                    ),
                    SizedBox(
                      height:
                          12,
                    ),
                    Text(
                      'لا يوجد نشاط مسجل بعد.',
                      textAlign:
                          TextAlign.center,
                    ),
                  ],
                )
              : ListView.separated(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),
                  itemCount:
                      provider
                          .auditLogs
                          .length,
                  separatorBuilder:
                      (_, _) =>
                          const SizedBox(
                    height:
                        8,
                  ),
                  itemBuilder:
                      (
                    context,
                    index,
                  ) {
                    final item =
                        provider
                            .auditLogs[
                        index
                    ];

                    return _auditCard(
                      item,
                    );
                  },
                ),
    );
  }

  Widget _auditCard(
    AuditLogModel item,
  ) {
    return _SurfaceCard(
      padding:
          EdgeInsets.zero,
      child:
          ExpansionTile(
        leading:
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
                .manage_history_outlined,
            color:
                _primary,
          ),
        ),
        title:
            Text(
          '${_action(item.action)}'
          '${item.entityType == null ? '' : ' • ${item.entityType}'}',
          style:
              const TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),
        subtitle:
            Text(
          '${item.userName ?? 'مستخدم غير معروف'}'
          ' • '
          '${_dateTime(item.createdAt)}'
          '\n'
          '${item.method} ${item.route}',
        ),
        childrenPadding:
            const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          16,
        ),
        children: [
          _detail(
            'الحالة',
            '${item.responseStatus ?? '—'}',
          ),
          _detail(
            'معرف السجل',
            item.entityId ?? '—',
          ),
          _codeBlock(
            'قبل',
            _pretty(
              item.beforeValues,
            ),
          ),
          _codeBlock(
            'بعد',
            _pretty(
              item.afterValues,
            ),
          ),
          _codeBlock(
            'بيانات الطلب',
            _pretty(
              item.requestData,
            ),
          ),
        ],
      ),
    );
  }

  Widget _backupTab() {
    final provider =
        context.watch<
            SystemAdminProvider>();

    return RefreshIndicator(
      onRefresh:
          provider.loadBackups,
      child:
          ListView(
        padding:
            const EdgeInsets.fromLTRB(
          16,
          16,
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
                  'نسخة احتياطية كاملة',
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
                  'تشمل بيانات النظام وسجل القيود ومعلومات المرفقات، مع التحقق من سلامة الملف وSchema قبل أي استعادة.',
                ),
                const SizedBox(
                  height:
                      12,
                ),
                FilledButton.icon(
                  onPressed:
                      provider.working
                          ? null
                          : _createBackup,
                  icon:
                      const Icon(
                    Icons
                        .backup_outlined,
                  ),
                  label:
                      const Text(
                    'إنشاء نسخة الآن',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height:
                12,
          ),
          if (
            provider.loadingBackups &&
            provider.backups.isEmpty
          )
            const Padding(
              padding:
                  EdgeInsets.all(
                40,
              ),
              child:
                  Center(
                child:
                    CircularProgressIndicator(),
              ),
            )
          else if (
            provider.backups.isEmpty
          )
            const _SurfaceCard(
              child:
                  Text(
                'لا توجد نسخ احتياطية بعد.',
              ),
            )
          else
            ...provider.backups.map(
              (backup) =>
                  Padding(
                padding:
                    const EdgeInsets.only(
                  bottom:
                      8,
                ),
                child:
                    _SurfaceCard(
                  child:
                      Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .stretch,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            child:
                                Icon(
                              Icons
                                  .inventory_2_outlined,
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
                                  backup.fileName,
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${_size(backup.sizeBytes)}'
                                  ' • '
                                  '${backup.recordsCount} سجل'
                                  ' • '
                                  '${backup.attachmentsCount} مرفق',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height:
                            8,
                      ),
                      Text(
                        '${backup.reason == 'pre_restore' ? 'نسخة أمان قبل الاستعادة' : 'نسخة يدوية'}'
                        ' • '
                        '${_dateTime(backup.createdAt)}',
                      ),
                      if (
                        backup.restoredAt !=
                        null
                      )
                        Padding(
                          padding:
                              const EdgeInsets.only(
                            top:
                                4,
                          ),
                          child:
                              Text(
                            'تمت الاستعادة منها: '
                            '${_dateTime(backup.restoredAt!)}',
                            style:
                                const TextStyle(
                              color:
                                  _primary,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height:
                            10,
                      ),
                      Wrap(
                        spacing:
                            8,
                        runSpacing:
                            8,
                        children: [
                          OutlinedButton.icon(
                            onPressed:
                                provider.working
                                    ? null
                                    : () =>
                                        _shareBackup(
                                      backup,
                                    ),
                            icon:
                                const Icon(
                              Icons
                                  .download_outlined,
                            ),
                            label:
                                const Text(
                              'تنزيل / مشاركة',
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed:
                                provider.working
                                    ? null
                                    : () =>
                                        _restore(
                                      backup,
                                    ),
                            icon:
                                const Icon(
                              Icons
                                  .restore_outlined,
                            ),
                            label:
                                const Text(
                              'استعادة',
                            ),
                          ),
                          TextButton.icon(
                            onPressed:
                                provider.working
                                    ? null
                                    : () =>
                                        _delete(
                                      backup,
                                    ),
                            icon:
                                const Icon(
                              Icons
                                  .delete_outline,
                            ),
                            label:
                                const Text(
                              'حذف',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _detail(
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top:
            6,
      ),
      child:
          Row(
        children: [
          SizedBox(
            width:
                100,
            child:
                Text(
              label,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child:
                SelectableText(
              value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeBlock(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top:
            12,
      ),
      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.w700,
            ),
          ),
          const SizedBox(
            height:
                4,
          ),
          Container(
            padding:
                const EdgeInsets.all(
              10,
            ),
            decoration:
                BoxDecoration(
              color:
                  const Color(
                    0xFFF2F3F7,
                  ),
              borderRadius:
                  BorderRadius.circular(
                8,
              ),
            ),
            child:
                SelectableText(
              value,
              style:
                  const TextStyle(
                fontFamily:
                    'monospace',
                fontSize:
                    12,
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
