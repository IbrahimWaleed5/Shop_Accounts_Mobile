import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/currency_model.dart';
import '../../models/worker_model.dart';
import '../../models/worker_opening_balance_model.dart';
import '../../providers/reference_data_provider.dart';
import '../../providers/worker_provider.dart';

class WorkerFormScreen extends StatefulWidget {
  final WorkerModel? worker;

  const WorkerFormScreen({
    super.key,
    this.worker,
  });

  @override
  State<WorkerFormScreen> createState() =>
      _WorkerFormScreenState();
}

class _WorkerFormScreenState
    extends State<WorkerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _jobTitle = TextEditingController();
  final _wage = TextEditingController();
  final _notes = TextEditingController();

  final Map<String, TextEditingController>
      _opening = {};

  late String _wageType;
  int? _wageCurrencyId;
  DateTime? _hireDate;
  bool _initializedBalances = false;

  bool get _editing => widget.worker != null;

  @override
  void initState() {
    super.initState();

    final worker = widget.worker;

    _wageType = worker?.wageType ?? 'monthly';
    _wageCurrencyId =
        worker?.wageCurrencyId;
    _hireDate = worker?.hireDate;

    if (worker != null) {
      _name.text = worker.name;
      _phone.text = worker.phone ?? '';
      _jobTitle.text =
          worker.jobTitle ?? '';
      _notes.text = worker.notes ?? '';
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final currencies = context
        .read<ReferenceDataProvider>()
        .activeCurrencies;

    if (currencies.isEmpty) {
      return;
    }

    _wageCurrencyId ??=
        currencies.first.id;

    if (!_initializedBalances) {
      if (widget.worker?.wageAmountMinor !=
              null &&
          widget.worker
                  ?.wageCurrencyDecimalPlaces !=
              null) {
        _wage.text =
            MoneyUtils.formatMinor(
          widget.worker!.wageAmountMinor!,
          widget.worker!
              .wageCurrencyDecimalPlaces!,
        );
      }

      for (final currency in currencies) {
        for (final side
            in ['payable', 'advance']) {
          final key =
              '${currency.id}:$side';

          WorkerOpeningBalanceModel?
              existing;

          for (final balance
              in widget.worker
                      ?.openingBalances ??
                  const <
                      WorkerOpeningBalanceModel>[]) {
            if (balance.currencyId ==
                    currency.id &&
                balance.balanceSide ==
                    side) {
              existing = balance;
              break;
            }
          }

          _opening[key] =
              TextEditingController(
            text: existing == null
                ? ''
                : MoneyUtils.formatMinor(
                    existing.amountMinor,
                    currency
                        .decimalPlaces,
                  ),
          );
        }
      }

      _initializedBalances = true;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _jobTitle.dispose();
    _wage.dispose();
    _notes.dispose();

    for (final controller
        in _opening.values) {
      controller.dispose();
    }

    super.dispose();
  }

  TextEditingController _openingController(
    int currencyId,
    String side,
  ) {
    final key =
        '$currencyId:$side';

    return _opening.putIfAbsent(
      key,
      () => TextEditingController(),
    );
  }

  CurrencyModel? _currencyById(
    List<CurrencyModel> currencies,
    int? id,
  ) {
    for (final currency in currencies) {
      if (currency.id == id) {
        return currency;
      }
    }

    return null;
  }

  List<WorkerOpeningBalanceModel>
      _buildOpeningBalances(
    List<CurrencyModel> currencies,
  ) {
    final result =
        <WorkerOpeningBalanceModel>[];

    for (final currency in currencies) {
      for (final side
          in ['payable', 'advance']) {
        final text = _openingController(
          currency.id,
          side,
        ).text.trim();

        if (text.isEmpty) {
          continue;
        }

        final amount =
            MoneyUtils.parseToMinor(
          text,
          currency.decimalPlaces,
        );

        if (amount < 0) {
          throw const FormatException(
            'الرصيد الافتتاحي لا يمكن أن يكون سالبًا.',
          );
        }

        if (amount == 0) {
          continue;
        }

        result.add(
          WorkerOpeningBalanceModel(
            currencyId: currency.id,
            currencyCode: currency.code,
            currencyNameAr:
                currency.nameAr,
            currencySymbol:
                currency.symbol,
            currencyDecimalPlaces:
                currency.decimalPlaces,
            balanceSide: side,
            amountMinor: amount,
          ),
        );
      }
    }

    return result;
  }

  Future<void> _chooseHireDate() async {
    final selected =
        await showDatePicker(
      context: context,
      initialDate:
          _hireDate ?? DateTime.now(),
      firstDate:
          DateTime(2000),
      lastDate:
          DateTime(2100),
    );

    if (selected != null) {
      setState(() {
        _hireDate = selected;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final reference = context
        .read<ReferenceDataProvider>();

    int? wageMinor;
    int? wageCurrencyId;

    if (_wageType != 'none') {
      final currency = _currencyById(
        reference.activeCurrencies,
        _wageCurrencyId,
      );

      if (currency == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'اختر عملة الأجر.',
            ),
          ),
        );
        return;
      }

      try {
        wageMinor =
            MoneyUtils.parseToMinor(
          _wage.text,
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

      if (wageMinor < 0) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'الأجر لا يمكن أن يكون سالبًا.',
            ),
          ),
        );
        return;
      }

      wageCurrencyId = currency.id;
    }

    List<WorkerOpeningBalanceModel>
        openingBalances;

    try {
      openingBalances =
          _buildOpeningBalances(
        reference.activeCurrencies,
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

    final provider =
        context.read<WorkerProvider>();

    final success = _editing
        ? await provider.update(
            workerId: widget.worker!.id,
            name: _name.text,
            phone: _phone.text,
            jobTitle: _jobTitle.text,
            wageType: _wageType,
            wageCurrencyId:
                wageCurrencyId,
            wageAmountMinor:
                wageMinor,
            hireDate: _hireDate,
            notes: _notes.text,
            openingBalances:
                openingBalances,
          )
        : await provider.create(
            name: _name.text,
            phone: _phone.text,
            jobTitle: _jobTitle.text,
            wageType: _wageType,
            wageCurrencyId:
                wageCurrencyId,
            wageAmountMinor:
                wageMinor,
            hireDate: _hireDate,
            notes: _notes.text,
            openingBalances:
                openingBalances,
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
                ? 'تم تحديث العامل.'
                : 'تم إنشاء العامل.',
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
              'تعذر حفظ العامل.',
        ),
      ),
    );
  }

  String _dateLabel() {
    if (_hireDate == null) {
      return 'غير محدد';
    }

    final y = _hireDate!.year;
    final m = _hireDate!.month
        .toString()
        .padLeft(2, '0');
    final d = _hireDate!.day
        .toString()
        .padLeft(2, '0');

    return '$y-$m-$d';
  }

  @override
  Widget build(BuildContext context) {
    final reference =
        context.watch<
            ReferenceDataProvider>();

    final provider =
        context.watch<WorkerProvider>();

    final currencies =
        reference.activeCurrencies;

    final wageCurrency =
        _currencyById(
      currencies,
      _wageCurrencyId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editing
              ? 'تعديل العامل'
              : 'عامل جديد',
        ),
      ),
      body: currencies.isEmpty
          ? const Center(
              child: Text(
                'لا توجد عملات متاحة.',
              ),
            )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,
                  children: [
                    const Card(
                      child: Padding(
                        padding:
                            EdgeInsets.all(
                          14,
                        ),
                        child: Text(
                          'العامل سجل داخلي فقط. لا يوجد له بريد أو كلمة مرور أو تسجيل دخول.',
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    TextFormField(
                      controller: _name,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'اسم العامل',
                        prefixIcon: Icon(
                          Icons
                              .badge_outlined,
                        ),
                        border:
                            OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value
                                .trim()
                                .isEmpty) {
                          return 'أدخل اسم العامل';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    TextFormField(
                      controller: _phone,
                      keyboardType:
                          TextInputType.phone,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'رقم الهاتف',
                        prefixIcon: Icon(
                          Icons
                              .phone_outlined,
                        ),
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    TextFormField(
                      controller:
                          _jobTitle,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'المسمى الوظيفي',
                        prefixIcon: Icon(
                          Icons
                              .work_outline,
                        ),
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    DropdownButtonFormField<
                        String>(
                      initialValue:
                          _wageType,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'نظام الأجر',
                        border:
                            OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'monthly',
                          child:
                              Text('شهري'),
                        ),
                        DropdownMenuItem(
                          value: 'daily',
                          child:
                              Text('يومي'),
                        ),
                        DropdownMenuItem(
                          value: 'none',
                          child: Text(
                            'بدون أجر ثابت',
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _wageType = value;
                        });
                      },
                    ),

                    if (_wageType !=
                        'none') ...[
                      const SizedBox(
                        height: 14,
                      ),

                      DropdownButtonFormField<
                          int>(
                        initialValue:
                            _wageCurrencyId,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'عملة الأجر',
                          border:
                              OutlineInputBorder(),
                        ),
                        items: currencies
                            .map(
                              (currency) =>
                                  DropdownMenuItem<
                                      int>(
                                value:
                                    currency.id,
                                child: Text(
                                  '${currency.code} - ${currency.nameAr}',
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _wageCurrencyId =
                                value;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      TextFormField(
                        controller: _wage,
                        keyboardType:
                            const TextInputType
                                .numberWithOptions(
                          decimal: true,
                        ),
                        decoration:
                            InputDecoration(
                          labelText:
                              _wageType ==
                                      'monthly'
                                  ? 'الراتب الشهري'
                                  : 'الأجر اليومي',
                          suffixText:
                              wageCurrency
                                  ?.symbol,
                          border:
                              const OutlineInputBorder(),
                        ),
                        validator:
                            (value) {
                          if (_wageType ==
                              'none') {
                            return null;
                          }

                          if (value == null ||
                              value
                                  .trim()
                                  .isEmpty) {
                            return 'أدخل قيمة الأجر';
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
                          _chooseHireDate,
                      icon: const Icon(
                        Icons
                            .calendar_month_outlined,
                      ),
                      label: Text(
                        'تاريخ بدء العمل: ${_dateLabel()}',
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
                      height: 22,
                    ),

                    _OpeningBalanceSection(
                      title:
                          'مستحقات سابقة للعامل',
                      description:
                          'مبالغ كان المحل مدينًا بها للعامل قبل بدء النظام.',
                      side: 'payable',
                      currencies:
                          currencies,
                      controller:
                          _openingController,
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    _OpeningBalanceSection(
                      title:
                          'سلف سابقة على العامل',
                      description:
                          'مبالغ كان العامل قد أخذها كسلفة قبل بدء النظام.',
                      side: 'advance',
                      currencies:
                          currencies,
                      controller:
                          _openingController,
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    SizedBox(
                      height: 55,
                      child:
                          FilledButton.icon(
                        onPressed:
                            provider.submitting
                                ? null
                                : _save,
                        icon: const Icon(
                          Icons.save_outlined,
                        ),
                        label: Text(
                          provider.submitting
                              ? 'جارٍ الحفظ...'
                              : _editing
                                  ? 'حفظ التعديلات'
                                  : 'إضافة العامل',
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

class _OpeningBalanceSection
    extends StatelessWidget {
  final String title;
  final String description;
  final String side;

  final List<CurrencyModel>
      currencies;

  final TextEditingController Function(
    int currencyId,
    String side,
  ) controller;

  const _OpeningBalanceSection({
    required this.title,
    required this.description,
    required this.side,
    required this.currencies,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style:
                  const TextStyle(
                fontSize: 17,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(description),
            const SizedBox(
              height: 14,
            ),
            ...currencies.map(
              (currency) =>
                  Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 10,
                ),
                child:
                    TextFormField(
                  controller:
                      controller(
                    currency.id,
                    side,
                  ),
                  keyboardType:
                      const TextInputType
                          .numberWithOptions(
                    decimal: true,
                  ),
                  decoration:
                      InputDecoration(
                    labelText:
                        currency.code,
                    suffixText:
                        currency.symbol,
                    hintText: '0',
                    border:
                        const OutlineInputBorder(),
                  ),
                  validator:
                      (value) {
                    if (value == null ||
                        value
                            .trim()
                            .isEmpty) {
                      return null;
                    }

                    try {
                      final amount =
                          MoneyUtils
                              .parseToMinor(
                        value,
                        currency
                            .decimalPlaces,
                      );

                      if (amount <
                          0) {
                        return 'لا يمكن إدخال مبلغ سالب';
                      }
                    } on FormatException catch (e) {
                      return e
                          .message;
                    }

                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
