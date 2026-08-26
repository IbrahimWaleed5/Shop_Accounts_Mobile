import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../core/utils/quantity_utils.dart';
import '../../models/product_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/product_provider.dart';
import 'product_form_screen.dart';

class ProductsScreen
    extends StatefulWidget {
  const ProductsScreen({
    super.key,
  });

  @override
  State<ProductsScreen> createState() =>
      _ProductsScreenState();
}

class _ProductsScreenState
    extends State<ProductsScreen> {
  final _search =
      TextEditingController();

  String _type = 'all';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) => _load(),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() {
    return context
        .read<ProductProvider>()
        .load(
          search: _search.text,
          type: _type == 'all'
              ? null
              : _type,
        );
  }

  Future<void> _openForm({
    ProductModel? product,
  }) async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ProductFormScreen(
          product: product,
        ),
      ),
    );

    if (changed == true &&
        mounted) {
      await _load();
    }
  }

  String _stock(
    ProductModel product,
  ) {
    if (product.isService) {
      return 'خدمة - بدون مخزون';
    }

    final qty =
        QuantityUtils.formatMilli(
      product.stockQuantityMilli,
    );

    final cost =
        product.averageCostMinor == null
            ? 'بدون تكلفة'
            : '${MoneyUtils.formatMinor(product.averageCostMinor!, product.currencyDecimalPlaces)} ${product.currencySymbol}';

    return 'المخزون: $qty ${product.unit} • متوسط التكلفة: $cost';
  }

  Future<void> _toggle(
    ProductModel product,
  ) async {
    final provider =
        context.read<ProductProvider>();

    final success =
        await provider.setStatus(
      productId: product.id,
      isActive: !product.isActive,
    );

    if (!mounted || success) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          provider.error ??
              'تعذر تعديل الصنف.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ProductProvider>();

    final manager =
        context.watch<AuthProvider>()
            .user!
            .isManager;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأصناف والخدمات',
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: provider.submitting
            ? null
            : () => _openForm(),
        icon: const Icon(Icons.add),
        label:
            const Text('إضافة صنف'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.all(16),
            child: TextField(
              controller: _search,
              onSubmitted:
                  (_) => _load(),
              decoration:
                  InputDecoration(
                hintText:
                    'بحث بالاسم أو SKU',
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),
                suffixIcon:
                    IconButton(
                  onPressed: _load,
                  icon: const Icon(
                    Icons
                        .arrow_forward_rounded,
                  ),
                ),
                border:
                    const OutlineInputBorder(),
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection:
                Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                for (final item in const [
                  ('all', 'الكل'),
                  ('inventory', 'مخزون'),
                  ('service', 'خدمات'),
                ])
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      left: 8,
                    ),
                    child: ChoiceChip(
                      label: Text(item.$2),
                      selected:
                          _type == item.$1,
                      onSelected: (_) {
                        setState(() {
                          _type = item.$1;
                        });

                        _load();
                      },
                    ),
                  ),
              ],
            ),
          ),

          if (provider.fromLocal)
            const Padding(
              padding:
                  EdgeInsets.fromLTRB(
                16,
                10,
                16,
                0,
              ),
              child: Card(
                child: Padding(
                  padding:
                      EdgeInsets.all(12),
                  child: Text(
                    'عرض الأصناف المحفوظة محليًا.',
                  ),
                ),
              ),
            ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _load,
              child: Builder(
                builder: (context) {
                  if (provider.loading &&
                      provider
                          .products
                          .isEmpty) {
                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  if (provider
                      .products
                      .isEmpty) {
                    return ListView(
                      padding:
                          const EdgeInsets
                              .all(24),
                      children: const [
                        SizedBox(
                          height: 80,
                        ),
                        Icon(
                          Icons
                              .inventory_2_outlined,
                          size: 60,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'لا توجد أصناف بعد.',
                          textAlign:
                              TextAlign.center,
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    padding:
                        const EdgeInsets
                            .fromLTRB(
                      16,
                      12,
                      16,
                      100,
                    ),
                    itemCount:
                        provider
                            .products
                            .length,
                    separatorBuilder:
                        (_, _) =>
                            const SizedBox(
                      height: 8,
                    ),
                    itemBuilder:
                        (context, index) {
                      final product =
                          provider
                                  .products[
                              index];

                      return Card(
                        child: ListTile(
                          onTap: () =>
                              _openForm(
                            product:
                                product,
                          ),
                          leading:
                              CircleAvatar(
                            child: Icon(
                              product
                                      .isInventory
                                  ? Icons
                                      .inventory_2_outlined
                                  : Icons
                                      .design_services_outlined,
                            ),
                          ),
                          title: Text(
                            product.name,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                          subtitle: Text(
                            '${product.currencyCode}'
                            '${product.sku == null ? '' : ' • ${product.sku}'}\n'
                            '${_stock(product)}',
                          ),
                          isThreeLine: true,
                          trailing: manager
                              ? Switch(
                                  value:
                                      product
                                          .isActive,
                                  onChanged:
                                      provider
                                              .submitting
                                          ? null
                                          : (_) =>
                                              _toggle(
                                                product,
                                              ),
                                )
                              : Icon(
                                  product.isActive
                                      ? Icons
                                          .chevron_left
                                      : Icons
                                          .block,
                                ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
