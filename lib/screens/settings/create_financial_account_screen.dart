import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/currency_model.dart';
import '../../providers/reference_data_provider.dart';

class CreateFinancialAccountScreen
    extends StatefulWidget {
  const CreateFinancialAccountScreen({
    super.key,
  });

  @override
  State<CreateFinancialAccountScreen>
      createState() =>
          _CreateFinancialAccountScreenState();
}

class _CreateFinancialAccountScreenState
    extends State<CreateFinancialAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController =
      TextEditingController();

  final _openingBalanceController =
      TextEditingController(text: '0');

  final _notesController =
      TextEditingController();

  String _type = 'cash';
  int? _currencyId;

  @override
  void dispose() {
    _nameController.dispose();
    _openingBalanceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  CurrencyModel? _selectedCurrency(
    ReferenceDataProvider provider,
  ) {
    for (final currency
        in provider.activeCurrencies) {
      if (currency.id == _currencyId) {
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

    final currency =
        _selectedCurrency(provider);

    if (currency == null) {
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
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
      return;
    }

    final success =
        await provider.createFinancialAccount(
      name: _nameController.text,
      type: _type,
      currencyId: currency.id,
      openingBalanceMinor:
          openingBalanceMinor,
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
            'تم إنشاء الحساب المالي.',
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
              'تعذر إنشاء الحساب المالي.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ReferenceDataProvider>();

    final currencies =
        provider.activeCurrencies;

    if (_currencyId == null &&
        currencies.isNotEmpty) {
      _currencyId = currencies.first.id;
    }

    final selected =
        _selectedCurrency(provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'حساب مالي جديد',
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
              const Text(
                'مثل: Cash، بنك فلسطين، Jawwal Pay أو أي محفظة أخرى.',
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'اسم الحساب',
                  prefixIcon: Icon(
                    Icons
                        .account_balance_wallet_outlined,
                  ),
                  border:
                      OutlineInputBorder(),
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
                  labelText:
                      'نوع الحساب',
                  border:
                      OutlineInputBorder(),
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
                    child:
                        Text('محفظة إلكترونية'),
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

              DropdownButtonFormField<int>(
                initialValue: _currencyId,
                decoration:
                    const InputDecoration(
                  labelText: 'العملة',
                  border:
                      OutlineInputBorder(),
                ),
                items: currencies
                    .map(
                      (currency) =>
                          DropdownMenuItem<int>(
                        value: currency.id,
                        child: Text(
                          '${currency.code} - ${currency.nameAr}',
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _currencyId = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'اختر العملة';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller:
                    _openingBalanceController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  labelText:
                      'الرصيد الافتتاحي',
                  suffixText:
                      selected?.symbol,
                  border:
                      const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل الرصيد الافتتاحي';
                  }

                  if (selected == null) {
                    return 'اختر العملة';
                  }

                  try {
                    MoneyUtils.parseToMinor(
                      value,
                      selected.decimalPlaces,
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
                      provider.isSubmitting
                          ? null
                          : _save,
                  icon: const Icon(
                    Icons.add_card,
                  ),
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
