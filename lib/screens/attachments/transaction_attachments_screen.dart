import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/accounting_transaction_model.dart';
import '../../providers/attachment_provider.dart';
import '../../providers/auth_provider.dart';

class TransactionAttachmentsScreen
    extends StatefulWidget {
  final AccountingTransactionModel
      transaction;

  const TransactionAttachmentsScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<TransactionAttachmentsScreen>
      createState() =>
          _TransactionAttachmentsScreenState();
}

class _TransactionAttachmentsScreenState
    extends State<
        TransactionAttachmentsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) => _load(),
    );
  }

  Future<void> _load() {
    return context
        .read<AttachmentProvider>()
        .load(
          transactionId:
              widget.transaction.id,
          transactionUuid:
              widget.transaction.uuid,
        );
  }

  Future<void> _pick() async {
    final file =
        await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'webp',
        'pdf',
      ],
    );

    if (file == null) {
      return;
    }

    final bytes =
        await file.readAsBytes();

    if (!mounted) {
      return;
    }

    if (
      bytes.length >
      15 * 1024 * 1024
    ) {
      _message(
        'حجم الملف يجب ألا يتجاوز 15 MB.',
      );
      return;
    }

    final extension =
        (file.extension ?? '')
            .toLowerCase();

    final mime = switch (extension) {
      'jpg' || 'jpeg' =>
        'image/jpeg',
      'png' =>
        'image/png',
      'webp' =>
        'image/webp',
      'pdf' =>
        'application/pdf',
      _ =>
        'application/octet-stream',
    };

    if (!mounted) {
      return;
    }

    final provider =
        context.read<
            AttachmentProvider>();

    final ok =
        await provider.add(
      transactionId:
          widget.transaction.id,
      transactionUuid:
          widget.transaction.uuid,
      fileName:
          file.name,
      mimeType:
          mime,
      bytes:
          bytes,
    );

    if (!mounted) {
      return;
    }

    if (ok) {
      _message(
        'تم حفظ المرفق على الجهاز.',
      );

      await _sync();
    } else {
      _message(
        provider.error ??
            'تعذر حفظ المرفق.',
      );
    }
  }

  Future<void> _sync() async {
    final provider =
        context.read<
            AttachmentProvider>();

    final count =
        await provider.sync(
      transactionId:
          widget.transaction.id,
      transactionUuid:
          widget.transaction.uuid,
    );

    if (
      mounted &&
      count > 0
    ) {
      _message(
        'تم رفع $count مرفق.',
      );
    }
  }

  Future<void> _delete(
    int attachmentId,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (dialogContext) =>
          AlertDialog(
        title:
            const Text(
          'حذف المرفق',
        ),
        content:
            const Text(
          'هل تريد حذف هذا المرفق؟',
        ),
        actions: [
          TextButton(
            onPressed: () =>
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
            onPressed: () =>
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
            AttachmentProvider>();

    final ok =
        await provider
            .deleteRemote(
      attachmentId:
          attachmentId,
      transactionId:
          widget.transaction.id,
      transactionUuid:
          widget.transaction.uuid,
    );

    if (
      mounted &&
      !ok
    ) {
      _message(
        provider.error ??
            'تعذر الحذف.',
      );
    }
  }

  String _size(
    int bytes,
  ) {
    if (bytes <
        1024) {
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

  void _message(
    String message,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content:
            Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<
            AttachmentProvider>();

    final isManager =
        context
            .watch<AuthProvider>()
            .user!
            .isManager;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          'مرفقات الحركة',
        ),
        actions: [
          IconButton(
            tooltip:
                'مزامنة المرفقات',
            onPressed:
                provider.syncing
                    ? null
                    : _sync,
            icon:
                const Icon(
              Icons.sync,
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            provider.loading
                ? null
                : _pick,
        icon:
            const Icon(
          Icons.attach_file,
        ),
        label:
            const Text(
          'إضافة مرفق',
        ),
      ),
      body:
          provider.loading &&
                  provider
                      .items
                      .isEmpty
              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh:
                      _load,
                  child:
                      provider
                              .items
                              .isEmpty
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
                                      .attachment_outlined,
                                  size:
                                      60,
                                ),
                                SizedBox(
                                  height:
                                      12,
                                ),
                                Text(
                                  'لا توجد مرفقات لهذه الحركة.',
                                  textAlign:
                                      TextAlign.center,
                                ),
                              ],
                            )
                          : ListView.separated(
                              padding:
                                  const EdgeInsets.fromLTRB(
                                16,
                                12,
                                16,
                                100,
                              ),
                              itemCount:
                                  provider.items.length,
                              separatorBuilder:
                                  (_, _) =>
                                      const SizedBox(
                                height:
                                    8,
                              ),
                              itemBuilder:
                                  (context, index) {
                                final item =
                                    provider.items[index];

                                final pending =
                                    item.syncStatus !=
                                    'synced';

                                return Card(
                                  child:
                                      ListTile(
                                    leading:
                                        CircleAvatar(
                                      child:
                                          Icon(
                                        item.mimeType ==
                                                'application/pdf'
                                            ? Icons
                                                .picture_as_pdf_outlined
                                            : Icons
                                                .image_outlined,
                                      ),
                                    ),
                                    title:
                                        Text(
                                      item.originalName,
                                      maxLines:
                                          1,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                    subtitle:
                                        Text(
                                      '${_size(item.sizeBytes)}'
                                      '${pending ? '\nمحفوظ محليًا - بانتظار الرفع' : '\nتم الرفع'}'
                                      '${item.lastError == null ? '' : '\n${item.lastError}'}',
                                    ),
                                    isThreeLine:
                                        true,
                                    trailing:
                                        isManager &&
                                                item.id != null &&
                                                item.syncStatus ==
                                                    'synced'
                                            ? IconButton(
                                                tooltip:
                                                    'حذف',
                                                onPressed:
                                                    () => _delete(item.id!),
                                                icon:
                                                    const Icon(
                                                  Icons.delete_outline,
                                                ),
                                              )
                                            : Icon(
                                                pending
                                                    ? Icons.cloud_upload_outlined
                                                    : Icons.check_circle_outline,
                                              ),
                                  ),
                                );
                              },
                            ),
                ),
    );
  }
}
