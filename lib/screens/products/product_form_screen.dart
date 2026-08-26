import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../core/utils/quantity_utils.dart';
import '../../models/currency_model.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';
import '../../providers/reference_data_provider.dart';

class ProductFormScreen
    extends StatefulWidget {
  final ProductModel? product;

  const ProductFormScreen({
    super.key,
    this.product,
  });

  @override
  State<ProductFormScreen> createState() =>
      _ProductFormScreenState();
}

class _ProductFormScreenState
    extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _sku = TextEditingController();
  final _unit = TextEditingController(
    text: 'قطعة',
  );

  final _salePrice =
      TextEditingController();

  final _openingQty =
      TextEditingController();

  final _openingCost =
      TextEditingController();

  late String _type;
  int? _currencyId;

  DateTime _openingDate =
      DateTime.now();

  bool get _editing =>
      widget.product != null;

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    _type =
        product?.productType ??
        'inventory';

    if (product != null) {
      _name.text = product.name;
      _sku.text = product.sku ?? '';
      _unit.text = product.unit;
      _currencyId =
          product.currencyId;

      if (
        product.defaultSalePriceMinor !=
        null
      ) {
        _salePrice.text =
            MoneyUtils.formatMinor(
          product.defaultSalePriceMinor!,
          product.currencyDecimalPlaces,
        );
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currencies = context
        .read<ReferenceDataProvider>()
        .activeCurrencies;

    if (_currencyId == null &&
        currencies.isNotEmpty) {
      _currencyId =
          currencies.first.id;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _sku.dispose();
    _unit.dispose();
    _salePrice.dispose();
    _openingQty.dispose();
    _openingCost.dispose();
    super.dispose();
  }

  CurrencyModel? _currency(
    List<CurrencyModel> currencies,
  ) {
    for (final currency in currencies) {
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

    final reference =
        context.read<
            ReferenceDataProvider>();

    final currency =
        _currency(
      reference.activeCurrencies,
    );

    if (currency == null) {
      return;
    }

    int? salePrice;

    if (_salePrice.text
        .trim()
        .isNotEmpty) {
      try {
        salePrice =
            MoneyUtils.parseToMinor(
          _salePrice.text,
          currency.decimalPlaces,
        );
      } on FormatException catch (e) {
        _show(e.message);
        return;
      }
    }

    final payload =
        <String, dynamic>{
      'sku': _sku.text.trim().isEmpty
          ? null
          : _sku.text.trim(),
      'name': _name.text.trim(),
      'product_type': _type,
      'unit': _unit.text.trim(),
      'currency_id':
          currency.id,
      'default_sale_price_minor':
          salePrice,
    };

    if (!_editing &&
        _type == 'inventory') {
      int openingQty = 0;

      if (_openingQty.text
          .trim()
          .isNotEmpty) {
        try {
          openingQty =
              QuantityUtils.parseToMilli(
            _openingQty.text,
          );
        } on FormatException catch (e) {
          _show(e.message);
          return;
        }
      }

      payload[
          'opening_quantity_milli'] =
          openingQty;

      if (openingQty > 0) {
        try {
          final openingCost =
              MoneyUtils.parseToMinor(
            _openingCost.text,
            currency.decimalPlaces,
          );

          if (openingCost <= 0) {
            _show(
              'تكلفة المخزون الافتتاحي يجب أن تكون أكبر من صفر.',
            );
            return;
          }

          payload[
                  'opening_unit_cost_minor'] =
              openingCost;
        } on FormatException catch (e) {
          _show(e.message);
          return;
        }

        payload['opening_occurred_at'] =
            _isoLocal(
          _openingDate,
        );
      }
    }

    final provider =
        context.read<ProductProvider>();

    final success = _editing
        ? await provider.update(
            widget.product!.id,
            payload,
          )
        : await provider.create(
            payload,
          );

    if (!mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            _editing
                ? 'تم تحديث الصنف.'
                : 'تم إنشاء الصنف.',
          ),
        ),
      );

      Navigator.pop(context, true);
      return;
    }

    _show(
      provider.error ??
          'تعذر حفظ الصنف.',
    );
  }

  void _show(
    String message,
  ) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  String _isoLocal(
    DateTime value,
  ) {
    String two(int value) =>
        value.toString().padLeft(2, '0');

    return '${value.year}-${two(value.month)}-${two(value.day)}T'
        '${two(value.hour)}:${two(value.minute)}:${two(value.second)}';
  }

  Future<void> _pickOpeningDate() async {
    final date =
        await showDatePicker(
      context: context,
      initialDate: _openingDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        _openingDate = DateTime(
          date.year,
          date.month,
          date.day,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reference =
        context.watch<
            ReferenceDataProvider>();

    final productProvider =
        context.watch<ProductProvider>();

    final currencies =
        reference.activeCurrencies;

    final currency =
        _currency(currencies);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editing
              ? 'تعديل الصنف'
              : 'صنف جديد',
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
                controller: _name,
                decoration:
                    const InputDecoration(
                  labelText:
                      'اسم الصنف أو الخدمة',
                  prefixIcon:
                      Icon(Icons.inventory_2_outlined),
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل اسم الصنف';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _sku,
                decoration:
                    const InputDecoration(
                  labelText:
                      'رمز الصنف SKU - اختياري',
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                initialValue: _type,
                decoration:
                    const InputDecoration(
                  labelText: 'النوع',
                  border:
                      OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'inventory',
                    child:
                        Text('صنف مخزون'),
                  ),
                  DropdownMenuItem(
                    value: 'service',
                    child:
                        Text('خدمة'),
                  ),
                ],
                onChanged: _editing
                    ? null
                    : (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _type = value;
                        });
                      },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _unit,
                decoration:
                    const InputDecoration(
                  labelText:
                      'الوحدة',
                  hintText:
                      'قطعة / كجم / متر / خدمة',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل الوحدة';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              DropdownButtonFormField<int>(
                initialValue:
                    _currencyId,
                decoration:
                    const InputDecoration(
                  labelText:
                      'عملة الصنف',
                  border:
                      OutlineInputBorder(),
                ),
                items: currencies
                    .map(
                      (item) =>
                          DropdownMenuItem<int>(
                        value: item.id,
                        child: Text(
                          '${item.code} - ${item.nameAr}',
                        ),
                      ),
                    )
                    .toList(),
                onChanged: _editing
                    ? null
                    : (value) {
                        setState(() {
                          _currencyId =
                              value;
                        });
                      },
                validator: (value) {
                  if (value == null) {
                    return 'اختر العملة';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _salePrice,
                keyboardType:
                    const TextInputType
                        .numberWithOptions(
                  decimal: true,
                ),
                decoration:
                    InputDecoration(
                  labelText:
                      'سعر البيع الافتراضي - اختياري',
                  suffixText:
                      currency?.symbol,
                  border:
                      const OutlineInputBorder(),
                ),
              ),

              if (!_editing &&
                  _type ==
                      'inventory') ...[
                const SizedBox(height: 22),

                const Text(
                  'المخزون الافتتاحي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'اترك الكمية فارغة إذا كان الصنف يبدأ من صفر.',
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller:
                      _openingQty,
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      InputDecoration(
                    labelText:
                        'الكمية الافتتاحية',
                    suffixText:
                        _unit.text,
                    border:
                        const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller:
                      _openingCost,
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      InputDecoration(
                    labelText:
                        'تكلفة الوحدة الافتتاحية',
                    suffixText:
                        currency?.symbol,
                    border:
                        const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                OutlinedButton.icon(
                  onPressed:
                      _pickOpeningDate,
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                  ),
                  label: const Text(
                    'تاريخ المخزون الافتتاحي',
                  ),
                ),
              ],

              const SizedBox(height: 24),

              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(14),
                  child: Text(
                    'لكل صنف عملة محاسبية واحدة في هذه المرحلة. لا يتم تحويل تكلفة المخزون بين العملات بدون سعر صرف صريح.',
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                height: 55,
                child:
                    FilledButton.icon(
                  onPressed:
                      productProvider.submitting
                          ? null
                          : _save,
                  icon: const Icon(
                    Icons.save_outlined,
                  ),
                  label: Text(
                    productProvider.submitting
                        ? 'جارٍ الحفظ...'
                        : 'حفظ الصنف',
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
