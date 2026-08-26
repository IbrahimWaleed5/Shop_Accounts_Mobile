import 'category_model.dart';
import 'currency_model.dart';
import 'financial_account_model.dart';

class ReferenceDataModel {
  final List<CurrencyModel> currencies;
  final List<FinancialAccountModel> financialAccounts;
  final List<CategoryModel> categories;

  const ReferenceDataModel({
    required this.currencies,
    required this.financialAccounts,
    required this.categories,
  });

  factory ReferenceDataModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final currenciesJson =
        json['currencies'] as List<dynamic>? ?? [];

    final accountsJson =
        json['financial_accounts']
                as List<dynamic>? ??
            [];

    final categoriesJson =
        json['categories'] as List<dynamic>? ?? [];

    return ReferenceDataModel(
      currencies: currenciesJson
          .map(
            (item) => CurrencyModel.fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList(),
      financialAccounts: accountsJson
          .map(
            (item) =>
                FinancialAccountModel.fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList(),
      categories: categoriesJson
          .map(
            (item) => CategoryModel.fromJson(
              Map<String, dynamic>.from(
                item as Map,
              ),
            ),
          )
          .toList(),
    );
  }
}
