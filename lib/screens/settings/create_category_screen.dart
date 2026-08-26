import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/reference_data_provider.dart';

class CreateCategoryScreen
    extends StatefulWidget {
  const CreateCategoryScreen({
    super.key,
  });

  @override
  State<CreateCategoryScreen>
      createState() =>
          _CreateCategoryScreenState();
}

class _CreateCategoryScreenState
    extends State<CreateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController =
      TextEditingController();

  final _notesController =
      TextEditingController();

  String _type = 'expense';

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider =
        context.read<ReferenceDataProvider>();

    final success =
        await provider.createCategory(
      name: _nameController.text,
      type: _type,
      notes: _notesController.text,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'تم إنشاء التصنيف.',
          ),
        ),
      );

      Navigator.pop(context, true);
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          provider.error ??
              'تعذر إنشاء التصنيف.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ReferenceDataProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تصنيف جديد',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'اسم التصنيف',
                  prefixIcon:
                      Icon(Icons.category_outlined),
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل اسم التصنيف';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _type,
                decoration:
                    const InputDecoration(
                  labelText:
                      'نوع التصنيف',
                  border:
                      OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'expense',
                    child: Text('مصروف'),
                  ),
                  DropdownMenuItem(
                    value: 'income',
                    child: Text('دخل'),
                  ),
                  DropdownMenuItem(
                    value: 'both',
                    child:
                        Text('دخل ومصروف'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _type = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration:
                    const InputDecoration(
                  labelText:
                      'ملاحظات - اختياري',
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 54,
                child: FilledButton.icon(
                  onPressed:
                      provider.isSubmitting
                          ? null
                          : _save,
                  icon: const Icon(
                    Icons.add,
                  ),
                  label: Text(
                    provider.isSubmitting
                        ? 'جارٍ الحفظ...'
                        : 'إنشاء التصنيف',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
