import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/currency_model.dart';
import '../../models/financial_account_model.dart';
import '../../models/party_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/party_provider.dart';
import '../../providers/reference_data_provider.dart';
import '../../providers/simple_sale_provider.dart';

class SimpleSaleScreen
    extends StatefulWidget {
  const SimpleSaleScreen({
    super.key,
  });

  @override
  State<SimpleSaleScreen> createState() =>
      _SimpleSaleScreenState();
}

class _SimpleSaleScreenState
    extends State<SimpleSaleScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final _amount =
      TextEditingController();

  final _paidNow =
      TextEditingController();

  final _description =
      TextEditingController();

  final _notes =
      TextEditingController();

  int? _currencyId;
  int? _customerId;
  int? _financialAccountId;

  String _settlement =
      'cash';

  DateTime _occurredAt =
      DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) async {
        // مهم:
        // هذه القائمة تأتي مباشرة من العملاء
        // المسجلين في شاشة المديونية.
        await context
            .read<PartyProvider>()
            .load(
              type: 'customer',
            );

        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _amount.dispose();
    _paidNow.dispose();
    _description.dispose();
    _notes.dispose();
    super.dispose();
  }

  CurrencyModel? _currency(
    List<CurrencyModel> currencies,
  ) {
    for (final item in currencies) {
      if (item.id == _currencyId) {
        return item;
      }
    }

    return null;
  }

  List<PartyModel> _customers(
    List<PartyModel> parties,
  ) {
    return parties
        .where(
          (item) =>
              item.isActive &&
              item.isCustomer,
        )
        .toList();
  }

  List<FinancialAccountModel>
      _accounts(
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

  Future<void> _pickDate() async {
    final selected =
        await showDatePicker(
      context: context,
      initialDate: _occurredAt,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _occurredAt = DateTime(
        selected.year,
        selected.month,
        selected.day,
        _occurredAt.hour,
        _occurredAt.minute,
      );
    });
  }

  String _isoLocal(
    DateTime value,
  ) {
    String two(int n) =>
        n.toString().padLeft(2, '0');

    return '${value.year}-${two(value.month)}-${two(value.day)}T'
        '${two(value.hour)}:${two(value.minute)}:${two(value.second)}';
  }

  Future<void> _save() async {
    if (
      !_formKey.currentState!
          .validate()
    ) {
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
      _message('اختر العملة.');
      return;
    }

    int amount;

    try {
      amount =
          MoneyUtils.parseToMinor(
        _amount.text,
        currency.decimalPlaces,
      );
    } on FormatException catch (e) {
      _message(e.message);
      return;
    }

    if (amount <= 0) {
      _message(
        'المبلغ يجب أن يكون أكبر من صفر.',
      );
      return;
    }

    int paidNow;

    if (_settlement == 'cash') {
      paidNow = amount;
    } else if (
      _settlement == 'credit'
    ) {
      paidNow = 0;
    } else {
      try {
        paidNow =
            MoneyUtils.parseToMinor(
          _paidNow.text,
          currency.decimalPlaces,
        );
      } on FormatException catch (e) {
        _message(e.message);
        return;
      }

      if (
        paidNow <= 0 ||
        paidNow >= amount
      ) {
        _message(
          'في البيع المختلط يجب أن يكون المدفوع أكبر من صفر وأقل من الإجمالي.',
        );
        return;
      }
    }

    final remaining =
        amount - paidNow;

    if (
      remaining > 0 &&
      _customerId == null
    ) {
      _message(
        'اختر العميل المسجل في المديونية.',
      );
      return;
    }

    if (
      paidNow > 0 &&
      _financialAccountId == null
    ) {
      _message(
        'اختر الحساب المالي للمبلغ المقبوض.',
      );
      return;
    }

    final provider =
        context.read<
            SimpleSaleProvider>();

    final transaction =
        await provider.create({
      'currency_id':
          currency.id,
      'amount_minor':
          amount,
      'paid_now_minor':
          paidNow,
      'party_id':
          _customerId,
      'financial_account_id':
          paidNow > 0
              ? _financialAccountId
              : null,
      'occurred_at':
          _isoLocal(_occurredAt),
      'description':
          _description.text
                  .trim()
                  .isEmpty
              ? 'بيع'
              : _description.text
                  .trim(),
      'notes':
          _notes.text
                  .trim()
                  .isEmpty
              ? null
              : _notes.text
                  .trim(),
    });

    if (!mounted) {
      return;
    }

    if (transaction == null) {
      _message(
        provider.error ??
            'تعذر حفظ البيع.',
      );
      return;
    }

    await context
        .read<AccountingProvider>()
        .load();

    if (!mounted) {
      return;
    }

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
              ? 'تم حفظ البيع على الجهاز. ستتم مزامنته تلقائيًا عند عودة الاتصال.'
              : remaining > 0
                  ? 'تم تسجيل البيع، والمتبقي على العميل: ${MoneyUtils.formatMinor(remaining, currency.decimalPlaces)} ${currency.symbol}'
                  : 'تم تسجيل البيع النقدي بالكامل.',
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

    final partyProvider =
        context.watch<
            PartyProvider>();

    final saleProvider =
        context.watch<
            SimpleSaleProvider>();

    final currencies =
        reference.activeCurrencies;

    if (
      _currencyId == null &&
      currencies.isNotEmpty
    ) {
      _currencyId =
          currencies.first.id;
    }

    final currency =
        _currency(currencies);

    final customers =
        _customers(
      partyProvider.parties,
    );

    final accounts =
        _accounts(
      reference.financialAccounts,
    );

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('فاتورة بيع'),
      ),
      body: ListView(
        padding:
            const EdgeInsets.all(16),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<
                    int>(
                  initialValue:
                      _currencyId,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'العملة',
                    border:
                        OutlineInputBorder(),
                  ),
                  items: currencies
                      .map(
                        (item) =>
                            DropdownMenuItem<
                                int>(
                          value:
                              item.id,
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

                      _financialAccountId =
                          null;
                    });
                  },
                  validator:
                      (value) {
                    if (value == null) {
                      return 'اختر العملة';
                    }

                    return null;
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
                      child: Text(
                        'نقدي بالكامل',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'credit',
                      child: Text(
                        'آجل بالكامل',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'mixed',
                      child: Text(
                        'جزء نقدي وجزء آجل',
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _settlement =
                          value;

                      if (
                        value ==
                        'credit'
                      ) {
                        _financialAccountId =
                            null;
                      }
                    });
                  },
                ),

                const SizedBox(
                  height: 14,
                ),

                DropdownButtonFormField<
                    int>(
                  initialValue:
                      _customerId,
                  decoration:
                      InputDecoration(
                    labelText:
                        _settlement ==
                                'cash'
                            ? 'العميل - اختياري في البيع النقدي'
                            : 'العميل المسجل في المديونية',
                    helperText:
                        customers.isEmpty
                            ? 'لا يوجد عملاء مسجلون في المديونية حتى الآن.'
                            : 'الأسماء هنا من قائمة العملاء المسجلين لديك.',
                    border:
                        const OutlineInputBorder(),
                  ),
                  items: customers
                      .map(
                        (customer) =>
                            DropdownMenuItem<
                                int>(
                          value:
                              customer.id,
                          child: Text(
                            customer.name,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _customerId =
                          value;
                    });
                  },
                  validator:
                      (value) {
                    if (
                      _settlement !=
                          'cash' &&
                      value == null
                    ) {
                      return 'اختر العميل من المديونية';
                    }

                    return null;
                  },
                ),

                if (
                  partyProvider.loading
                ) ...[
                  const SizedBox(
                    height: 8,
                  ),
                  const LinearProgressIndicator(),
                ],

                const SizedBox(
                  height: 14,
                ),

                TextFormField(
                  controller:
                      _amount,
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      InputDecoration(
                    labelText:
                        'إجمالي مبلغ البيع',
                    suffixText:
                        currency?.symbol,
                    border:
                        const OutlineInputBorder(),
                  ),
                  validator:
                      (value) {
                    if (
                      value == null ||
                      value
                          .trim()
                          .isEmpty
                    ) {
                      return 'أدخل مبلغ البيع';
                    }

                    return null;
                  },
                ),

                if (
                  _settlement ==
                  'mixed'
                ) ...[
                  const SizedBox(
                    height: 14,
                  ),

                  TextFormField(
                    controller:
                        _paidNow,
                    keyboardType:
                        const TextInputType
                            .numberWithOptions(
                      decimal: true,
                    ),
                    decoration:
                        InputDecoration(
                      labelText:
                          'المبلغ المقبوض الآن',
                      suffixText:
                          currency?.symbol,
                      border:
                          const OutlineInputBorder(),
                    ),
                  ),
                ],

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
                    items: accounts
                        .map(
                          (account) =>
                              DropdownMenuItem<
                                  int>(
                            value:
                                account.id,
                            child:
                                Text(
                              account.name,
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
                    validator:
                        (value) {
                      if (
                        _settlement !=
                            'credit' &&
                        value == null
                      ) {
                        return 'اختر الحساب المالي';
                      }

                      return null;
                    },
                  ),
                ],

                const SizedBox(
                  height: 14,
                ),

                OutlinedButton.icon(
                  onPressed:
                      _pickDate,
                  icon: const Icon(
                    Icons
                        .calendar_month_outlined,
                  ),
                  label: Text(
                    'التاريخ: '
                    '${_occurredAt.year}-'
                    '${_occurredAt.month.toString().padLeft(2, '0')}-'
                    '${_occurredAt.day.toString().padLeft(2, '0')}',
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
                        'بيان البيع',
                    hintText:
                        'مثال: بضاعة، خدمة، مبيعات متنوعة...',
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 14,
                ),

                TextFormField(
                  controller:
                      _notes,
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

                const Card(
                  child: Padding(
                    padding:
                        EdgeInsets.all(
                      14,
                    ),
                    child: Text(
                      'لا يوجد اختيار صنف في فاتورة البيع. إذا كان جزء من المبلغ آجلًا، يُسجل مباشرة كمديونية على العميل المختار.',
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
                        saleProvider
                                .submitting
                            ? null
                            : _save,
                    icon: const Icon(
                      Icons
                          .check_circle_outline,
                    ),
                    label: Text(
                      saleProvider
                              .submitting
                          ? 'جارٍ الترحيل...'
                          : 'حفظ وترحيل البيع',
                    ),
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
