import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/currency_model.dart';
import '../../models/party_model.dart';
import '../../models/party_opening_balance_model.dart';
import '../../providers/party_provider.dart';
import '../../providers/reference_data_provider.dart';

class PartyFormScreen
    extends StatefulWidget {
  final String initialType;
  final PartyModel? party;

  const PartyFormScreen({
    super.key,
    required this.initialType,
    this.party,
  });

  @override
  State<PartyFormScreen> createState() =>
      _PartyFormScreenState();
}

class _PartyFormScreenState
    extends State<PartyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController =
      TextEditingController();

  final _phoneController =
      TextEditingController();

  final _addressController =
      TextEditingController();

  final _notesController =
      TextEditingController();

  final Map<String, TextEditingController>
      _balanceControllers = {};

  late String _type;
  bool _initialized = false;

  bool get _editing =>
      widget.party != null;

  @override
  void initState() {
    super.initState();

    _type = widget.party?.type ??
        widget.initialType;

    final party = widget.party;

    if (party != null) {
      _nameController.text =
          party.name;

      _phoneController.text =
          party.phone ?? '';

      _addressController.text =
          party.address ?? '';

      _notesController.text =
          party.notes ?? '';
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) {
      return;
    }

    final currencies =
        context
            .read<
                ReferenceDataProvider>()
            .activeCurrencies
            .where(
              (currency) =>
                  currency.code.trim().toUpperCase() ==
                  'ILS',
            )
            .toList();

    if (currencies.isEmpty) {
      return;
    }

    for (final currency in currencies) {
      for (final side
          in ['receivable', 'payable']) {
        final key =
            '${currency.id}:$side';

        final existing = widget
            .party?.openingBalances
            .where(
              (item) =>
                  item.currencyId ==
                      currency.id &&
                  item.balanceSide ==
                      side,
            )
            .cast<
                PartyOpeningBalanceModel?>()
            .firstOrNull;

        _balanceControllers[key] =
            TextEditingController(
          text: existing == null
              ? ''
              : MoneyUtils.formatMinor(
                  existing.amountMinor,
                  currency.decimalPlaces,
                ),
        );
      }
    }

    _initialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _notesController.dispose();

    for (final controller
        in _balanceControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  bool get _showReceivable =>
      _type == 'customer' ||
      _type == 'both';

  bool get _showPayable =>
      _type == 'supplier' ||
      _type == 'both';

  TextEditingController _controller(
    int currencyId,
    String side,
  ) {
    final key =
        '$currencyId:$side';

    return _balanceControllers.putIfAbsent(
      key,
      () => TextEditingController(),
    );
  }

  List<PartyOpeningBalanceModel>
      _buildBalances(
    List<CurrencyModel> currencies,
  ) {
    final result =
        <PartyOpeningBalanceModel>[];

    for (final currency in currencies) {
      if (_showReceivable) {
        final text = _controller(
          currency.id,
          'receivable',
        ).text.trim();

        if (text.isNotEmpty) {
          final value =
              MoneyUtils.parseToMinor(
            text,
            currency.decimalPlaces,
          );

          if (value < 0) {
            throw const FormatException(
              'الرصيد الافتتاحي لا يمكن أن يكون سالبًا.',
            );
          }

          if (value > 0) {
            result.add(
              PartyOpeningBalanceModel(
                currencyId:
                    currency.id,
                currencyCode:
                    currency.code,
                currencyNameAr:
                    currency.nameAr,
                currencySymbol:
                    currency.symbol,
                currencyDecimalPlaces:
                    currency
                        .decimalPlaces,
                balanceSide:
                    'receivable',
                amountMinor: value,
              ),
            );
          }
        }
      }

      if (_showPayable) {
        final text = _controller(
          currency.id,
          'payable',
        ).text.trim();

        if (text.isNotEmpty) {
          final value =
              MoneyUtils.parseToMinor(
            text,
            currency.decimalPlaces,
          );

          if (value < 0) {
            throw const FormatException(
              'الرصيد الافتتاحي لا يمكن أن يكون سالبًا.',
            );
          }

          if (value > 0) {
            result.add(
              PartyOpeningBalanceModel(
                currencyId:
                    currency.id,
                currencyCode:
                    currency.code,
                currencyNameAr:
                    currency.nameAr,
                currencySymbol:
                    currency.symbol,
                currencyDecimalPlaces:
                    currency
                        .decimalPlaces,
                balanceSide:
                    'payable',
                amountMinor: value,
              ),
            );
          }
        }
      }
    }

    return result;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final reference =
        context.read<
            ReferenceDataProvider>();

    List<PartyOpeningBalanceModel>
        balances;

    try {
      balances = _buildBalances(
        reference.activeCurrencies
            .where(
              (currency) =>
                  currency.code.trim().toUpperCase() ==
                  'ILS',
            )
            .toList(),
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
        context.read<PartyProvider>();

    final success = _editing
        ? await provider.update(
            partyId: widget.party!.id,
            type: _type,
            name:
                _nameController.text,
            phone:
                _phoneController.text,
            address:
                _addressController.text,
            notes:
                _notesController.text,
            openingBalances: balances,
          )
        : await provider.create(
            type: _type,
            name:
                _nameController.text,
            phone:
                _phoneController.text,
            address:
                _addressController.text,
            notes:
                _notesController.text,
            openingBalances: balances,
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
                ? 'تم تحديث البيانات.'
                : 'تم الحفظ بنجاح.',
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
              'تعذر حفظ البيانات.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reference =
        context.watch<
            ReferenceDataProvider>();

    final partyProvider =
        context.watch<PartyProvider>();

    final currencies =
        reference.activeCurrencies
            .where(
              (currency) =>
                  currency.code.trim().toUpperCase() ==
                  'ILS',
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editing
              ? 'تعديل العميل / المورد'
              : (_type == 'supplier' ? 'إضافة مورد' : 'إضافة عميل'),
        ),
      ),
      body: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,
                  children: [
                    DropdownButtonFormField<
                        String>(
                      initialValue: _type,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'نوع السجل',
                        border:
                            OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'customer',
                          child: Text(
                            'عميل',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'supplier',
                          child: Text(
                            'مورد',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'both',
                          child: Text(
                            'عميل ومورد',
                          ),
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

                    const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      controller:
                          _nameController,
                      textInputAction:
                          TextInputAction.next,
                      decoration:
                          const InputDecoration(
                        labelText: 'الاسم',
                        prefixIcon: Icon(
                          Icons
                              .person_outline,
                        ),
                        border:
                            OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value
                                .trim()
                                .isEmpty) {
                          return 'أدخل الاسم';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      controller:
                          _phoneController,
                      keyboardType:
                          TextInputType.phone,
                      textInputAction:
                          TextInputAction.next,
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
                      height: 16,
                    ),

                    TextFormField(
                      controller:
                          _addressController,
                      textInputAction:
                          TextInputAction.next,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'العنوان - اختياري',
                        prefixIcon: Icon(
                          Icons
                              .location_on_outlined,
                        ),
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      controller:
                          _notesController,
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
                      height: 24,
                    ),

                    if (_showReceivable)
                      _BalanceSection(
                        title:
                            'الرصيد السابق على العميل',
                        description:
                            'المبلغ الذي كان العميل مدينًا به للمحل قبل بدء استخدام النظام.',
                        currencies:
                            currencies,
                        side:
                            'receivable',
                        controller:
                            _controller,
                      ),

                    if (_showReceivable &&
                        _showPayable)
                      const SizedBox(
                        height: 22,
                      ),

                    if (_showPayable)
                      _BalanceSection(
                        title:
                            'الرصيد السابق للمورد',
                        description:
                            'المبلغ الذي كان المحل مدينًا به للمورد قبل بدء استخدام النظام.',
                        currencies:
                            currencies,
                        side: 'payable',
                        controller:
                            _controller,
                      ),

                    const SizedBox(
                      height: 26,
                    ),

                    SizedBox(
                      height: 55,
                      child:
                          FilledButton.icon(
                        onPressed:
                            partyProvider
                                    .submitting
                                ? null
                                : _save,
                        icon: const Icon(
                          Icons.save_outlined,
                        ),
                        label: Text(
                          partyProvider
                                  .submitting
                              ? 'جارٍ الحفظ...'
                              : _editing
                                  ? 'حفظ التعديلات'
                                  : (_type == 'supplier' ? 'حفظ المورد' : 'حفظ العميل'),
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

class _BalanceSection
    extends StatelessWidget {
  final String title;
  final String description;
  final List<CurrencyModel> currencies;
  final String side;

  final TextEditingController Function(
    int currencyId,
    String side,
  ) controller;

  const _BalanceSection({
    required this.title,
    required this.description,
    required this.currencies,
    required this.side,
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
              style: const TextStyle(
                fontSize: 17,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(description),
            const SizedBox(height: 16),
            ...currencies.map(
              (currency) => Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 12,
                ),
                child: TextFormField(
                  controller: controller(
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
                        'شيكل (ILS)',
                    suffixText:
                        currency.symbol,
                    hintText: '0',
                    border:
                        const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value
                            .trim()
                            .isEmpty) {
                      return null;
                    }

                    try {
                      final minor =
                          MoneyUtils
                              .parseToMinor(
                        value,
                        currency
                            .decimalPlaces,
                      );

                      if (minor < 0) {
                        return 'لا يمكن إدخال رصيد سالب';
                      }
                    } on FormatException catch (e) {
                      return e.message;
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

extension _NullableIterableExtension<T>
    on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;

    if (!iterator.moveNext()) {
      return null;
    }

    return iterator.current;
  }
}
