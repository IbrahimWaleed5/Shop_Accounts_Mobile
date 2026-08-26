import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../core/utils/quantity_utils.dart';
import '../../models/financial_account_model.dart';
import '../../models/party_model.dart';
import '../../models/product_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/commerce_provider.dart';
import '../../providers/party_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/reference_data_provider.dart';

class SalePurchaseFormScreen
    extends StatefulWidget {
  final bool isSale;

  const SalePurchaseFormScreen({
    super.key,
    required this.isSale,
  });

  @override
  State<SalePurchaseFormScreen> createState() =>
      _SalePurchaseFormScreenState();
}

class _SalePurchaseFormScreenState
    extends State<SalePurchaseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _mixedPaid =
      TextEditingController();

  final _description =
      TextEditingController();

  final _notes =
      TextEditingController();

  final List<_CommerceLine> _lines = [
    _CommerceLine(),
  ];

  int? _currencyId;
  int? _partyId;
  int? _financialAccountId;

  String _settlement = 'cash';

  DateTime _occurredAt =
      DateTime.now();

  bool get _isSale =>
      widget.isSale;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
      await Future.wait([
        context
            .read<ProductProvider>()
            .load(),
        context
            .read<PartyProvider>()
            .load(),
      ]);

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _mixedPaid.dispose();
    _description.dispose();
    _notes.dispose();

    for (final line in _lines) {
      line.dispose();
    }

    super.dispose();
  }

  ProductModel? _findProduct(
    List<ProductModel> products,
    int? id,
  ) {
    if (id == null) {
      return null;
    }

    for (final product in products) {
      if (product.id == id) {
        return product;
      }
    }

    return null;
  }

  List<ProductModel> _products(
    List<ProductModel> products,
  ) {
    return products
        .where(
          (item) =>
              item.isActive &&
              item.currencyId ==
                  _currencyId &&
              (
                _isSale ||
                item.isInventory
              ),
        )
        .toList();
  }

  List<PartyModel> _parties(
    List<PartyModel> parties,
  ) {
    return parties
        .where(
          (item) =>
              item.isActive &&
              (
                _isSale
                    ? item.isCustomer
                    : item.isSupplier
              ),
        )
        .toList();
  }

  List<FinancialAccountModel>
      _financialAccounts(
    List<FinancialAccountModel> accounts,
  ) {
    return accounts
        .where(
          (item) =>
              item.isActive &&
              item.currencyId ==
                  _currencyId,
        )
        .toList();
  }

  int? _lineTotal(
    _CommerceLine line,
    List<ProductModel> products,
  ) {
    final product =
        _findProduct(
      products,
      line.productId,
    );

    if (product == null) {
      return null;
    }

    try {
      final quantity =
          QuantityUtils.parseToMilli(
        line.quantity.text,
      );

      final price =
          MoneyUtils.parseToMinor(
        line.price.text,
        product.currencyDecimalPlaces,
      );

      return (
        quantity * price + 500
      ) ~/
          1000;
    } on FormatException {
      return null;
    }
  }

  int _total(
    List<ProductModel> products,
  ) {
    var total = 0;

    for (final line in _lines) {
      total +=
          _lineTotal(
            line,
            products,
          ) ??
          0;
    }

    return total;
  }

  void _onProductChanged(
    _CommerceLine line,
    ProductModel product,
  ) {
    line.productId =
        product.id;

    final suggested =
        _isSale
            ? product
                .defaultSalePriceMinor
            : product.averageCostMinor;

    if (suggested != null) {
      line.price.text =
          MoneyUtils.formatMinor(
        suggested,
        product.currencyDecimalPlaces,
      );
    } else {
      line.price.clear();
    }

    if (line.quantity.text
        .trim()
        .isEmpty) {
      line.quantity.text = '1';
    }

    setState(() {});
  }

  void _addLine() {
    setState(() {
      _lines.add(
        _CommerceLine(),
      );
    });
  }

  void _removeLine(
    int index,
  ) {
    if (_lines.length == 1) {
      return;
    }

    setState(() {
      final line =
          _lines.removeAt(index);

      line.dispose();
    });
  }

  Future<void> _pickDate() async {
    final date =
        await showDatePicker(
      context: context,
      initialDate: _occurredAt,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null) {
      return;
    }

    setState(() {
      _occurredAt = DateTime(
        date.year,
        date.month,
        date.day,
        _occurredAt.hour,
        _occurredAt.minute,
      );
    });
  }

  String _isoLocal(
    DateTime value,
  ) {
    String two(int number) =>
        number.toString().padLeft(2, '0');

    return '${value.year}-${two(value.month)}-${two(value.day)}T'
        '${two(value.hour)}:${two(value.minute)}:${two(value.second)}';
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final productProvider =
        context.read<ProductProvider>();

    final reference =
        context.read<
            ReferenceDataProvider>();

    final products =
        _products(
      productProvider.products,
    );

    if (_currencyId == null) {
      _message(
        'اختر العملة.',
      );
      return;
    }

    final itemPayload =
        <Map<String, dynamic>>[];

    var total = 0;

    for (var i = 0;
        i < _lines.length;
        i++) {
      final line = _lines[i];

      final product =
          _findProduct(
        products,
        line.productId,
      );

      if (product == null) {
        _message(
          'اختر الصنف في السطر ${i + 1}.',
        );
        return;
      }

      int quantity;
      int price;

      try {
        quantity =
            QuantityUtils.parseToMilli(
          line.quantity.text,
        );

        price =
            MoneyUtils.parseToMinor(
          line.price.text,
          product.currencyDecimalPlaces,
        );
      } on FormatException catch (e) {
        _message(
          'السطر ${i + 1}: ${e.message}',
        );
        return;
      }

      if (quantity <= 0) {
        _message(
          'كمية السطر ${i + 1} يجب أن تكون أكبر من صفر.',
        );
        return;
      }

      if (price < 0) {
        _message(
          'سعر السطر ${i + 1} غير صحيح.',
        );
        return;
      }

      if (
        _isSale &&
        product.isInventory &&
        quantity >
            product.stockQuantityMilli
      ) {
        _message(
          'المخزون غير كافٍ للصنف ${product.name}.',
        );
        return;
      }

      final lineTotal =
          (quantity * price + 500) ~/
              1000;

      total += lineTotal;

      itemPayload.add({
        'product_id':
            product.id,
        'quantity_milli':
            quantity,
        'unit_price_minor':
            price,
        'description':
            product.name,
      });
    }

    if (total <= 0) {
      _message(
        'إجمالي العملية يجب أن يكون أكبر من صفر.',
      );
      return;
    }

    int paidNow;

    if (_settlement == 'cash') {
      paidNow = total;
    } else if (
      _settlement == 'credit'
    ) {
      paidNow = 0;
    } else {
      try {
        final currency = reference
            .activeCurrencies
            .firstWhere(
          (item) =>
              item.id ==
              _currencyId,
        );

        paidNow =
            MoneyUtils.parseToMinor(
          _mixedPaid.text,
          currency.decimalPlaces,
        );
      } on Object {
        _message(
          'أدخل المبلغ المدفوع في العملية المختلطة.',
        );
        return;
      }

      if (
        paidNow <= 0 ||
        paidNow >= total
      ) {
        _message(
          'في العملية المختلطة يجب أن يكون المدفوع أكبر من صفر وأقل من الإجمالي.',
        );
        return;
      }
    }

    final unpaid =
        total - paidNow;

    if (
      unpaid > 0 &&
      _partyId == null
    ) {
      _message(
        _isSale
            ? 'اختر العميل لأن هناك مبلغًا آجلًا.'
            : 'اختر المورد لأن هناك مبلغًا آجلًا.',
      );
      return;
    }

    if (
      paidNow > 0 &&
      _financialAccountId == null
    ) {
      _message(
        'اختر الحساب المالي للجزء المدفوع.',
      );
      return;
    }

    final payload =
        <String, dynamic>{
      'currency_id':
          _currencyId,
      'party_id':
          _partyId,
      'financial_account_id':
          paidNow > 0
              ? _financialAccountId
              : null,
      'paid_now_minor':
          paidNow,
      'occurred_at':
          _isoLocal(_occurredAt),
      'description':
          _description.text
                  .trim()
                  .isEmpty
              ? (
                  _isSale
                      ? 'بيع'
                      : 'شراء'
                )
              : _description.text
                  .trim(),
      'notes':
          _notes.text
                  .trim()
                  .isEmpty
              ? null
              : _notes.text
                  .trim(),
      'items': itemPayload,
    };

    final commerce =
        context.read<
            CommerceProvider>();

    final transaction =
        await commerce.create(
      sale: _isSale,
      payload: payload,
    );

    if (!mounted) {
      return;
    }

    if (transaction == null) {
      _message(
        commerce.error ??
            'تعذر ترحيل العملية.',
      );
      return;
    }

    await Future.wait([
      context
          .read<ProductProvider>()
          .load(),
      context
          .read<AccountingProvider>()
          .load(),
    ]);

    if (!mounted) {
      return;
    }

    final profit =
        transaction.grossProfitMinor;

    final isPending =
        transaction.status ==
                'pending_sync' ||
            transaction.status ==
                'syncing';

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          isPending
              ? 'تم حفظ العملية على الجهاز وستتم مزامنتها تلقائيًا عند عودة الاتصال.'
              : _isSale &&
                      profit != null
                  ? 'تم البيع. الربح الإجمالي للحركة: ${MoneyUtils.formatMinor(profit, transaction.currencyDecimalPlaces)} ${transaction.currencySymbol}'
                  : _isSale &&
                          transaction.costStatus ==
                              'incomplete'
                      ? 'تم البيع. بيانات التكلفة غير مكتملة، لذلك لم يتم عرض ربح غير موثوق.'
                      : 'تم ترحيل عملية الشراء.',
        ),
      ),
    );

    Navigator.pop(
      context,
      true,
    );
  }

  void _message(
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

  @override
  Widget build(BuildContext context) {
    final reference =
        context.watch<
            ReferenceDataProvider>();

    final productProvider =
        context.watch<ProductProvider>();

    final partyProvider =
        context.watch<PartyProvider>();

    final commerce =
        context.watch<
            CommerceProvider>();

    final currencies =
        reference.activeCurrencies;

    if (
      _currencyId == null &&
      currencies.isNotEmpty
    ) {
      _currencyId =
          currencies.first.id;
    }

    final products =
        _products(
      productProvider.products,
    );

    final parties =
        _parties(
      partyProvider.parties,
    );

    final financialAccounts =
        _financialAccounts(
      reference.financialAccounts,
    );

    final currency = currencies
        .where(
          (item) =>
              item.id ==
              _currencyId,
        )
        .firstOrNull;

    final total =
        _total(products);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isSale
              ? 'فاتورة بيع'
              : 'فاتورة شراء',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding:
              const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<int>(
              initialValue:
                  _currencyId,
              decoration:
                  const InputDecoration(
                labelText: 'العملة',
                border:
                    OutlineInputBorder(),
              ),
              items: currencies
                  .map(
                    (item) =>
                        DropdownMenuItem<
                            int>(
                      value: item.id,
                      child: Text(
                        '${item.code} - ${item.nameAr}',
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _currencyId =
                      value;

                  _partyId = null;
                  _financialAccountId =
                      null;

                  for (final line
                      in _lines) {
                    line.productId =
                        null;
                    line.price.clear();
                  }
                });
              },
            ),

            const SizedBox(
              height: 14,
            ),

            DropdownButtonFormField<
                String>(
              initialValue:
                  _settlement,
              decoration:
                  const InputDecoration(
                labelText:
                    'طريقة التسوية',
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'cash',
                  child:
                      Text('نقدي بالكامل'),
                ),
                DropdownMenuItem(
                  value: 'credit',
                  child:
                      Text('آجل بالكامل'),
                ),
                DropdownMenuItem(
                  value: 'mixed',
                  child:
                      Text('جزء نقدي وجزء آجل'),
                ),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _settlement =
                      value;

                  if (value ==
                      'credit') {
                    _financialAccountId =
                        null;
                  }
                });
              },
            ),

            const SizedBox(
              height: 14,
            ),

            DropdownButtonFormField<int>(
              initialValue:
                  _partyId,
              decoration:
                  InputDecoration(
                labelText: _isSale
                    ? 'العميل - مطلوب عند البيع الآجل'
                    : 'المورد - مطلوب عند الشراء الآجل',
                border:
                    const OutlineInputBorder(),
              ),
              items: parties
                  .map(
                    (item) =>
                        DropdownMenuItem<
                            int>(
                      value: item.id,
                      child:
                          Text(item.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _partyId = value;
                });
              },
            ),

            if (
              _settlement !=
              'credit'
            ) ...[
              const SizedBox(
                height: 14,
              ),

              DropdownButtonFormField<
                  int>(
                initialValue:
                    _financialAccountId,
                decoration:
                    const InputDecoration(
                  labelText:
                      'الحساب المالي',
                  border:
                      OutlineInputBorder(),
                ),
                items:
                    financialAccounts
                        .map(
                          (item) =>
                              DropdownMenuItem<
                                  int>(
                            value:
                                item.id,
                            child:
                                Text(
                              item.name,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    _financialAccountId =
                        value;
                  });
                },
              ),
            ],

            if (
              _settlement ==
              'mixed'
            ) ...[
              const SizedBox(
                height: 14,
              ),

              TextFormField(
                controller:
                    _mixedPaid,
                keyboardType:
                    const TextInputType
                        .numberWithOptions(
                  decimal: true,
                ),
                decoration:
                    InputDecoration(
                  labelText:
                      'المبلغ المدفوع الآن',
                  suffixText:
                      currency?.symbol,
                  border:
                      const OutlineInputBorder(),
                ),
              ),
            ],

            const SizedBox(
              height: 22,
            ),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    'الأصناف',
                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed:
                      _addLine,
                  icon: const Icon(
                    Icons.add,
                  ),
                  label:
                      const Text(
                    'سطر',
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            for (var index = 0;
                index <
                    _lines.length;
                index++)
              _CommerceLineCard(
                key: ValueKey(
                  _lines[index],
                ),
                index: index,
                line: _lines[index],
                products: products,
                isSale: _isSale,
                currencySymbol:
                    currency?.symbol ??
                    '',
                onProductChanged:
                    (product) =>
                        _onProductChanged(
                  _lines[index],
                  product,
                ),
                onChanged: () =>
                    setState(() {}),
                onRemove: () =>
                    _removeLine(
                  index,
                ),
                canRemove:
                    _lines.length > 1,
              ),

            const SizedBox(
              height: 14,
            ),

            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  18,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'الإجمالي',
                        style:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                    Text(
                      '${currency == null ? '0' : MoneyUtils.formatMinor(total, currency.decimalPlaces)} ${currency?.symbol ?? ''}',
                      style:
                          const TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(
                Icons
                    .calendar_month_outlined,
              ),
              label: Text(
                'التاريخ: ${_occurredAt.year}-${_occurredAt.month.toString().padLeft(2, '0')}-${_occurredAt.day.toString().padLeft(2, '0')}',
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            TextFormField(
              controller:
                  _description,
              decoration:
                  const InputDecoration(
                labelText:
                    'البيان - اختياري',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            TextFormField(
              controller: _notes,
              maxLines: 3,
              decoration:
                  const InputDecoration(
                labelText:
                    'ملاحظات - اختياري',
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 18,
            ),

            if (_isSale)
              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(
                    14,
                  ),
                  child: Text(
                    'ربح بيع أصناف المخزون يُحسب من متوسط التكلفة وقت البيع. إذا احتوت الفاتورة على خدمة، يظهر الربح كغير مكتمل بدل اختلاق تكلفة للخدمة.',
                  ),
                ),
              ),

            const SizedBox(
              height: 18,
            ),

            SizedBox(
              height: 56,
              child:
                  FilledButton.icon(
                onPressed:
                    commerce.submitting
                        ? null
                        : _save,
                icon: const Icon(
                  Icons
                      .check_circle_outline,
                ),
                label: Text(
                  commerce.submitting
                      ? 'جارٍ الترحيل...'
                      : _isSale
                          ? 'حفظ وترحيل البيع'
                          : 'حفظ وترحيل الشراء',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommerceLine {
  int? productId;

  final quantity =
      TextEditingController(
    text: '1',
  );

  final price =
      TextEditingController();

  void dispose() {
    quantity.dispose();
    price.dispose();
  }
}

class _CommerceLineCard
    extends StatelessWidget {
  final int index;
  final _CommerceLine line;

  final List<ProductModel>
      products;

  final bool isSale;
  final String currencySymbol;

  final ValueChanged<ProductModel>
      onProductChanged;

  final VoidCallback onChanged;
  final VoidCallback onRemove;
  final bool canRemove;

  const _CommerceLineCard({
    super.key,
    required this.index,
    required this.line,
    required this.products,
    required this.isSale,
    required this.currencySymbol,
    required this.onProductChanged,
    required this.onChanged,
    required this.onRemove,
    required this.canRemove,
  });

  ProductModel? _selected() {
    for (final product in products) {
      if (product.id ==
          line.productId) {
        return product;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final selected =
        _selected();

    String? stockText;

    if (
      isSale &&
      selected?.isInventory ==
          true
    ) {
      stockText =
          'المتوفر: ${QuantityUtils.formatMilli(selected!.stockQuantityMilli)} ${selected.unit}';
    }

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'السطر ${index + 1}',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
                if (canRemove)
                  IconButton(
                    onPressed:
                        onRemove,
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                  ),
              ],
            ),

            DropdownButtonFormField<
                int>(
              initialValue:
                  line.productId,
              decoration:
                  const InputDecoration(
                labelText:
                    'الصنف',
                border:
                    OutlineInputBorder(),
              ),
              items: products
                  .map(
                    (product) =>
                        DropdownMenuItem<
                            int>(
                      value: product.id,
                      child: Text(
                        product.name,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                final product =
                    products.firstWhere(
                  (item) =>
                      item.id == value,
                );

                onProductChanged(
                  product,
                );
              },
            ),

            if (stockText !=
                null) ...[
              const SizedBox(
                height: 6,
              ),
              Align(
                alignment:
                    Alignment.centerRight,
                child: Text(
                  stockText,
                ),
              ),
            ],

            const SizedBox(
              height: 12,
            ),

            Row(
              children: [
                Expanded(
                  child:
                      TextFormField(
                    controller:
                        line.quantity,
                    keyboardType:
                        const TextInputType
                            .numberWithOptions(
                      decimal: true,
                    ),
                    onChanged:
                        (_) =>
                            onChanged(),
                    decoration:
                        InputDecoration(
                      labelText:
                          'الكمية',
                      suffixText:
                          selected?.unit,
                      border:
                          const OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child:
                      TextFormField(
                    controller:
                        line.price,
                    keyboardType:
                        const TextInputType
                            .numberWithOptions(
                      decimal: true,
                    ),
                    onChanged:
                        (_) =>
                            onChanged(),
                    decoration:
                        InputDecoration(
                      labelText: isSale
                          ? 'سعر الوحدة'
                          : 'تكلفة الوحدة',
                      suffixText:
                          currencySymbol,
                      border:
                          const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension _FirstOrNullExtension<T>
    on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;

    return iterator.moveNext()
        ? iterator.current
        : null;
  }
}
