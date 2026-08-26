import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/category_model.dart';
import '../../models/currency_model.dart';
import '../../models/financial_account_model.dart';
import '../../models/party_model.dart';
import '../../providers/accounting_provider.dart';
import '../../providers/party_provider.dart';
import '../../providers/reference_data_provider.dart';
import '../../providers/worker_provider.dart';

class TransactionFormScreen extends StatefulWidget {
  final String initialType;

  const TransactionFormScreen({
    super.key,
    this.initialType = 'expense',
  });

  @override
  State<TransactionFormScreen> createState() =>
      _TransactionFormScreenState();
}

class _TransactionFormScreenState
    extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _amountController =
      TextEditingController();

  final _descriptionController =
      TextEditingController();

  final _notesController =
      TextEditingController();

  late String _type;
  int? _currencyId;
  int? _partyId;
  int? _workerId;
  int? _categoryId;
  int? _financialAccountId;
  int? _targetFinancialAccountId;

  DateTime _occurredAt = DateTime.now();

  @override
  void initState() {
    super.initState();

    _type = widget.initialType;

    WidgetsBinding.instance
        .addPostFrameCallback((_) async {
      final party =
          context.read<PartyProvider>();

      final worker =
          context.read<WorkerProvider>();

      await Future.wait([
        party.load(),
        worker.load(),
      ]);

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  bool get _requiresParty {
    return _type ==
            'customer_collection' ||
        _type ==
            'supplier_payment';
  }

  bool get _requiresWorker {
    return _type ==
            'worker_salary_accrual' ||
        _type ==
            'worker_salary_payment' ||
        _type == 'worker_advance' ||
        _type ==
            'worker_advance_recovery' ||
        _type == 'worker_deduction';
  }

  bool get _requiresCategory {
    return _type == 'expense';
  }

  bool get _requiresFinancialAccount {
    return _type ==
            'customer_collection' ||
        _type ==
            'supplier_payment' ||
        _type == 'expense' ||
        _type == 'other_income' ||
        _type ==
            'worker_salary_payment' ||
        _type == 'worker_advance' ||
        _type ==
            'worker_advance_recovery' ||
        _type == 'transfer';
  }

  bool get _requiresTargetAccount {
    return _type == 'transfer';
  }

  bool get _isCustomerType {
    return _type ==
        'customer_collection';
  }

  bool get _isSupplierType {
    return _type ==
        'supplier_payment';
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

  List<FinancialAccountModel>
      _accountsForCurrency(
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

  List<PartyModel> _filteredParties(
    List<PartyModel> parties,
  ) {
    if (_isCustomerType) {
      return parties
          .where(
            (item) =>
                item.isActive &&
                item.isCustomer,
          )
          .toList();
    }

    if (_isSupplierType) {
      return parties
          .where(
            (item) =>
                item.isActive &&
                item.isSupplier,
          )
          .toList();
    }

    return parties
        .where((item) => item.isActive)
        .toList();
  }

  List<CategoryModel> _expenseCategories(
    List<CategoryModel> categories,
  ) {
    return categories
        .where(
          (item) =>
              item.isActive &&
              (
                item.type == 'expense' ||
                item.type == 'both'
              ),
        )
        .toList();
  }

  void _resetDependentFields() {
    _partyId = null;
    _workerId = null;
    _categoryId = null;
    _financialAccountId = null;
    _targetFinancialAccountId = null;
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
        _occurredAt.second,
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

    int amountMinor;

    try {
      amountMinor =
          MoneyUtils.parseToMinor(
        _amountController.text,
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

    if (amountMinor <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'المبلغ يجب أن يكون أكبر من صفر.',
          ),
        ),
      );
      return;
    }

    final payload =
        <String, dynamic>{
      'type': _type,
      'currency_id':
          currency.id,
      'amount_minor':
          amountMinor,
      'occurred_at':
          _isoLocal(_occurredAt),
      'description':
          _descriptionController.text
                  .trim()
                  .isEmpty
              ? null
              : _descriptionController.text
                  .trim(),
      'notes':
          _notesController.text
                  .trim()
                  .isEmpty
              ? null
              : _notesController.text
                  .trim(),
      'party_id':
          _requiresParty
              ? _partyId
              : null,
      'worker_id':
          _requiresWorker
              ? _workerId
              : null,
      'category_id':
          _requiresCategory
              ? _categoryId
              : null,
      'financial_account_id':
          _requiresFinancialAccount
              ? _financialAccountId
              : null,
      'target_financial_account_id':
          _requiresTargetAccount
              ? _targetFinancialAccountId
              : null,
    };

    final provider =
        context.read<
            AccountingProvider>();

    final success =
        await provider.create(
      payload,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      final isPending =
          provider.lastCreatedStatus ==
                  'pending_sync' ||
              provider.lastCreatedStatus ==
                  'syncing';

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            isPending
                ? 'تم حفظ الحركة على الجهاز وستتم مزامنتها تلقائيًا عند عودة الاتصال.'
                : 'تم ترحيل الحركة محاسبيًا.',
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
              'تعذر حفظ الحركة.',
        ),
      ),
    );
  }

  String _dateLabel() {
    final y =
        _occurredAt.year;

    final m =
        _occurredAt.month
            .toString()
            .padLeft(2, '0');

    final d =
        _occurredAt.day
            .toString()
            .padLeft(2, '0');

    return '$y-$m-$d';
  }

  String _titleForType(
    String type,
  ) {
    switch (type) {
      case 'customer_collection':
        return 'تحصيل من عميل';
      case 'supplier_payment':
        return 'دفع لمورد';
      case 'expense':
        return 'إضافة مصروف';
      case 'other_income':
        return 'إضافة دخل آخر';
      case 'worker_salary_accrual':
        return 'استحقاق راتب عامل';
      case 'worker_salary_payment':
        return 'دفع راتب عامل';
      case 'worker_advance':
        return 'سلفة عامل';
      case 'worker_advance_recovery':
        return 'استرداد سلفة عامل';
      case 'worker_deduction':
        return 'خصم من مستحقات عامل';
      case 'transfer':
        return 'تحويل بين حسابين';
      default:
        return 'إضافة حركة محاسبية';
    }
  }

  @override
  Widget build(BuildContext context) {
    final reference =
        context.watch<
            ReferenceDataProvider>();

    final partyProvider =
        context.watch<
            PartyProvider>();

    final workerProvider =
        context.watch<
            WorkerProvider>();

    final accounting =
        context.watch<
            AccountingProvider>();

    final currencies =
        reference.activeCurrencies;

    if (_currencyId == null &&
        currencies.isNotEmpty) {
      _currencyId =
          currencies.first.id;
    }

    final currency =
        _currency(currencies);

    final financialAccounts =
        _accountsForCurrency(
      reference.financialAccounts,
    );

    final parties =
        _filteredParties(
      partyProvider.parties,
    );

    final workers =
        workerProvider.workers
            .where(
              (item) =>
                  item.isActive,
            )
            .toList();

    final categories =
        _expenseCategories(
      reference.categories,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titleForType(_type),
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
              DropdownButtonFormField<
                  String>(
                initialValue: _type,
                decoration:
                    const InputDecoration(
                  labelText:
                      'نوع الحركة',
                  border:
                      OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value:
                        'customer_collection',
                    child: Text(
                      'تحصيل من عميل',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'supplier_payment',
                    child: Text(
                      'دفع لمورد',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'expense',
                    child: Text(
                      'مصروف',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'other_income',
                    child: Text(
                      'دخل آخر',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'worker_salary_accrual',
                    child: Text(
                      'استحقاق راتب عامل',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'worker_salary_payment',
                    child: Text(
                      'دفع راتب عامل',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'worker_advance',
                    child: Text(
                      'سلفة عامل',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'worker_advance_recovery',
                    child: Text(
                      'استرداد سلفة عامل',
                    ),
                  ),
                  DropdownMenuItem(
                    value:
                        'worker_deduction',
                    child: Text(
                      'خصم من مستحقات عامل',
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'transfer',
                    child: Text(
                      'تحويل بين حسابين ماليين',
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _type = value;
                    _resetDependentFields();
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

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

                    _financialAccountId =
                        null;

                    _targetFinancialAccountId =
                        null;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'اختر العملة';
                  }

                  return null;
                },
              ),

              if (_requiresParty) ...[
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField<
                    int>(
                  initialValue:
                      _partyId,
                  decoration:
                      InputDecoration(
                    labelText:
                        _isCustomerType
                            ? 'العميل'
                            : 'المورد',
                    border:
                        const OutlineInputBorder(),
                  ),
                  items: parties
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
                      _partyId =
                          value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return _isCustomerType
                          ? 'اختر العميل'
                          : 'اختر المورد';
                    }

                    return null;
                  },
                ),
              ],

              if (_requiresWorker) ...[
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField<
                    int>(
                  initialValue:
                      _workerId,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'العامل',
                    border:
                        OutlineInputBorder(),
                  ),
                  items: workers
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
                      _workerId =
                          value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'اختر العامل';
                    }

                    return null;
                  },
                ),
              ],

              if (_requiresCategory) ...[
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField<
                    int>(
                  initialValue:
                      _categoryId,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'تصنيف المصروف',
                    border:
                        OutlineInputBorder(),
                  ),
                  items: categories
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
                      _categoryId =
                          value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'اختر التصنيف';
                    }

                    return null;
                  },
                ),
              ],

              if (_requiresFinancialAccount) ...[
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField<
                    int>(
                  initialValue:
                      _financialAccountId,
                  decoration:
                      InputDecoration(
                    labelText:
                        _requiresTargetAccount
                            ? 'الحساب المصدر'
                            : 'الحساب المالي',
                    border:
                        const OutlineInputBorder(),
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

                      if (
                        _targetFinancialAccountId ==
                            value
                      ) {
                        _targetFinancialAccountId =
                            null;
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'اختر الحساب المالي';
                    }

                    return null;
                  },
                ),
              ],

              if (_requiresTargetAccount) ...[
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField<
                    int>(
                  initialValue:
                      _targetFinancialAccountId,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'الحساب المستهدف',
                    border:
                        OutlineInputBorder(),
                  ),
                  items:
                      financialAccounts
                          .where(
                            (item) =>
                                item.id !=
                                _financialAccountId,
                          )
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
                      _targetFinancialAccountId =
                          value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'اختر الحساب المستهدف';
                    }

                    return null;
                  },
                ),
              ],

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller:
                    _amountController,
                keyboardType:
                    const TextInputType
                        .numberWithOptions(
                  decimal: true,
                ),
                decoration:
                    InputDecoration(
                  labelText: 'المبلغ',
                  suffixText:
                      currency?.symbol,
                  border:
                      const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value
                          .trim()
                          .isEmpty) {
                    return 'أدخل المبلغ';
                  }

                  if (currency ==
                      null) {
                    return 'اختر العملة';
                  }

                  try {
                    final amount =
                        MoneyUtils
                            .parseToMinor(
                      value,
                      currency
                          .decimalPlaces,
                    );

                    if (amount <=
                        0) {
                      return 'المبلغ يجب أن يكون أكبر من صفر';
                    }
                  } on FormatException catch (e) {
                    return e.message;
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(
                  Icons
                      .calendar_month_outlined,
                ),
                label: Text(
                  'تاريخ الحركة: ${_dateLabel()}',
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              TextFormField(
                controller:
                    _descriptionController,
                decoration:
                    const InputDecoration(
                  labelText:
                      'البيان - اختياري',
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

              const Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(
                    14,
                  ),
                  child: Text(
                    'الحركة ستُرحّل كقيد مزدوج متوازن. لا يوجد حذف مباشر للحركات المالية.',
                  ),
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              SizedBox(
                height: 55,
                child:
                    FilledButton.icon(
                  onPressed:
                      accounting.submitting
                          ? null
                          : _save,
                  icon: const Icon(
                    Icons.save_outlined,
                  ),
                  label: Text(
                    accounting.submitting
                        ? 'جارٍ الترحيل...'
                        : 'حفظ وترحيل',
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
