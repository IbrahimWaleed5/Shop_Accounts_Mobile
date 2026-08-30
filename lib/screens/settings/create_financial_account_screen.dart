import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/currency_model.dart';
import '../../providers/reference_data_provider.dart';

class CreateFinancialAccountScreen extends StatefulWidget {
  const CreateFinancialAccountScreen({
    super.key,
  });

  @override
  State<CreateFinancialAccountScreen> createState() =>
      _CreateFinancialAccountScreenState();
}

class _CreateFinancialAccountScreenState
    extends State<CreateFinancialAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _openingBalanceController =
      TextEditingController(text: '0');

  final _notesController = TextEditingController();

  String _type = 'cash';

  @override
  void dispose() {
    _nameController.dispose();
    _openingBalanceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  CurrencyModel? _ilsCurrency(
    ReferenceDataProvider provider,
  ) {
    for (final currency in provider.activeCurrencies) {
      if (currency.code.trim().toUpperCase() == 'ILS') {
        return currency;
      }
    }

    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider =
        context.read<ReferenceDataProvider>();

    final currency = _ilsCurrency(provider);

    if (currency == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'عملة الشيكل ILS غير محمّلة. حدّث البيانات ثم حاول مرة أخرى.',
          ),
        ),
      );
      return;
    }

    int openingBalanceMinor;

    try {
      openingBalanceMinor =
          MoneyUtils.parseToMinor(
        _openingBalanceController.text,
        currency.decimalPlaces,
      );
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
      return;
    }

    final success =
        await provider.createFinancialAccount(
      name: _nameController.text.trim(),
      type: _type,
      currencyId: currency.id,
      openingBalanceMinor:
          openingBalanceMinor,
      notes: _notesController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم إنشاء الحساب المالي بالشيكل.',
          ),
        ),
      );

      Navigator.pop(context, true);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          provider.error ??
              'تعذر إنشاء الحساب المالي.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ReferenceDataProvider>();

    final currency = _ilsCurrency(provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حساب مالي جديد',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              const Text(
                'أنشئ صندوقًا أو حساب بنك أو محفظة. جميع الحسابات تستخدم الشيكل فقط.',
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(
                  labelText: 'اسم الحساب',
                  prefixIcon: Icon(
                    Icons
                        .account_balance_wallet_outlined,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل اسم الحساب';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _type,
                decoration:
                    const InputDecoration(
                  labelText: 'نوع الحساب',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'cash',
                    child: Text('نقدي'),
                  ),
                  DropdownMenuItem(
                    value: 'bank',
                    child: Text('بنك'),
                  ),
                  DropdownMenuItem(
                    value: 'wallet',
                    child: Text(
                      'محفظة إلكترونية',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'other',
                    child: Text('أخرى'),
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

              InputDecorator(
                decoration:
                    const InputDecoration(
                  labelText: 'العملة',
                  prefixIcon: Icon(
                    Icons.payments_outlined,
                  ),
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'شيكل (ILS)',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      currency?.symbol
                                  .trim()
                                  .isNotEmpty ==
                              true
                          ? currency!.symbol
                          : '₪',
                      style:
                          const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              if (currency == null) ...[
                const SizedBox(height: 8),
                const Text(
                  'جارٍ انتظار تحميل تعريف الشيكل من السيرفر. بعد نشر إصلاح الـ API أغلق التطبيق وافتحه من جديد.',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                  ),
                ),
              ],

              const SizedBox(height: 16),

              TextFormField(
                controller:
                    _openingBalanceController,
                keyboardType:
                    const TextInputType
                        .numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration:
                    const InputDecoration(
                  labelText:
                      'الرصيد الافتتاحي',
                  suffixText: '₪',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل الرصيد الافتتاحي';
                  }

                  final ils = currency;

                  if (ils == null) {
                    return 'تعريف الشيكل غير محمّل';
                  }

                  try {
                    MoneyUtils.parseToMinor(
                      value,
                      ils.decimalPlaces,
                    );
                  } on FormatException catch (e) {
                    return e.message;
                  }

                  return null;
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
                      provider.isSubmitting ||
                              currency == null
                          ? null
                          : _save,
                  icon:
                      const Icon(Icons.add_card),
                  label: Text(
                    provider.isSubmitting
                        ? 'جارٍ الحفظ...'
                        : 'إنشاء الحساب',
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
