import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/category_model.dart';
import '../../models/financial_account_model.dart';
import '../../providers/reference_data_provider.dart';
import 'create_category_screen.dart';
import 'create_financial_account_screen.dart';

class AccountingSettingsScreen
    extends StatefulWidget {
  const AccountingSettingsScreen({
    super.key,
  });

  @override
  State<AccountingSettingsScreen>
      createState() =>
          _AccountingSettingsScreenState();
}

class _AccountingSettingsScreenState
    extends State<AccountingSettingsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      final provider =
          context.read<
              ReferenceDataProvider>();

      if (provider.currencies.isEmpty) {
        provider.load();
      }
    });
  }

  Future<void> _openAccount() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const CreateFinancialAccountScreen(),
      ),
    );
  }

  Future<void> _openCategory() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const CreateCategoryScreen(),
      ),
    );
  }

  String _accountType(
    String type,
  ) {
    switch (type) {
      case 'cash':
        return 'نقدي';
      case 'bank':
        return 'بنك';
      case 'wallet':
        return 'محفظة';
      default:
        return 'أخرى';
    }
  }

  String _categoryType(
    String type,
  ) {
    switch (type) {
      case 'expense':
        return 'مصروف';
      case 'income':
        return 'دخل';
      default:
        return 'دخل ومصروف';
    }
  }

  Future<void> _toggleAccount(
    FinancialAccountModel account,
    bool value,
  ) async {
    final provider =
        context.read<
            ReferenceDataProvider>();

    final ok =
        await provider
            .setFinancialAccountStatus(
      accountId: account.id,
      isActive: value,
    );

    if (!mounted || ok) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          provider.error ??
              'تعذر تعديل الحساب.',
        ),
      ),
    );
  }

  Future<void> _toggleCategory(
    CategoryModel category,
    bool value,
  ) async {
    final provider =
        context.read<
            ReferenceDataProvider>();

    final ok =
        await provider.setCategoryStatus(
      categoryId: category.id,
      isActive: value,
    );

    if (!mounted || ok) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          provider.error ??
              'تعذر تعديل التصنيف.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<
            ReferenceDataProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإعدادات المحاسبية',
        ),
        actions: [
          IconButton(
            tooltip: 'تحديث',
            onPressed: provider.isLoading
                ? null
                : provider.load,
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: provider.isLoading &&
              provider.currencies.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: provider.load,
              child: ListView(
                padding:
                    const EdgeInsets.all(16),
                children: [
                  if (provider.fromLocal)
                    const Card(
                      child: Padding(
                        padding:
                            EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Icon(
                              Icons
                                  .offline_bolt_outlined,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'يتم عرض نسخة الإعدادات المحفوظة محليًا.',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (provider.error != null) ...[
                    const SizedBox(height: 10),
                    Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                          14,
                        ),
                        child: Text(
                          provider.error!,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 14),

                  const Text(
                    'العملات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  ...provider.currencies.map(
                    (currency) => Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            currency.symbol,
                          ),
                        ),
                        title: Text(
                          '${currency.code} - ${currency.nameAr}',
                        ),
                        subtitle: Text(
                          'المنازل العشرية: ${currency.decimalPlaces}',
                        ),
                        trailing: Icon(
                          currency.isActive
                              ? Icons
                                  .check_circle_outline
                              : Icons.block,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'الحسابات المالية',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed:
                            provider.isSubmitting
                                ? null
                                : _openAccount,
                        icon: const Icon(
                          Icons.add,
                        ),
                        label:
                            const Text('إضافة'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ...provider.financialAccounts
                      .map(
                    (account) => Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons
                              .account_balance_wallet_outlined,
                        ),
                        title:
                            Text(account.name),
                        subtitle: Text(
                          '${_accountType(account.type)} • '
                          '${account.currencyCode}\n'
                          'الرصيد الافتتاحي: '
                          '${MoneyUtils.formatMinor(account.openingBalanceMinor, account.currencyDecimalPlaces)} '
                          '${account.currencySymbol}',
                        ),
                        isThreeLine: true,
                        trailing: Switch(
                          value:
                              account.isActive,
                          onChanged:
                              provider.isSubmitting
                                  ? null
                                  : (value) {
                                      _toggleAccount(
                                        account,
                                        value,
                                      );
                                    },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'التصنيفات',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed:
                            provider.isSubmitting
                                ? null
                                : _openCategory,
                        icon: const Icon(
                          Icons.add,
                        ),
                        label:
                            const Text('إضافة'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ...provider.categories.map(
                    (category) => Card(
                      child: ListTile(
                        leading:
                            const Icon(
                          Icons
                              .category_outlined,
                        ),
                        title: Text(
                          category.name,
                        ),
                        subtitle: Text(
                          _categoryType(
                            category.type,
                          ),
                        ),
                        trailing: Switch(
                          value:
                              category.isActive,
                          onChanged:
                              provider.isSubmitting
                                  ? null
                                  : (value) {
                                      _toggleCategory(
                                        category,
                                        value,
                                      );
                                    },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}
