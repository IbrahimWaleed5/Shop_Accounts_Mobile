import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/party_model.dart';
import '../../providers/party_provider.dart';
import 'party_details_screen.dart';
import 'party_form_screen.dart';

class PartiesScreen extends StatefulWidget {
  final String initialFilter;

  const PartiesScreen({
    super.key,
    required this.initialFilter,
  });

  @override
  State<PartiesScreen> createState() =>
      _PartiesScreenState();
}

class _PartiesScreenState
    extends State<PartiesScreen> {
  final _searchController =
      TextEditingController();

  late String _filter;

  @override
  void initState() {
    super.initState();

    _filter = widget.initialFilter;

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      _load();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() {
    return context
        .read<PartyProvider>()
        .load(
          type: _filter == 'all'
              ? null
              : _filter,
          search:
              _searchController.text,
        );
  }

  Future<void> _add() async {
    final type = _filter == 'supplier'
        ? 'supplier'
        : _filter == 'all'
            ? 'customer'
            : _filter;

    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PartyFormScreen(
          initialType: type,
        ),
      ),
    );

    if (changed == true &&
        mounted) {
      await _load();
    }
  }

  Future<void> _open(
    PartyModel party,
  ) async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PartyDetailsScreen(
          party: party,
        ),
      ),
    );

    if (changed == true &&
        mounted) {
      await _load();
    }
  }

  String _title() {
    switch (_filter) {
      case 'customer':
        return 'العملاء';
      case 'supplier':
        return 'الموردون';
      case 'both':
        return 'عميل ومورد';
      default:
        return 'جميع الحسابات';
    }
  }

  String _typeLabel(
    PartyModel party,
  ) {
    switch (party.type) {
      case 'customer':
        return 'عميل';
      case 'supplier':
        return 'مورد';
      default:
        return 'عميل ومورد';
    }
  }

  String _balanceSummary(
    PartyModel party,
  ) {
    if (party.openingBalances.isEmpty) {
      return 'بدون رصيد افتتاحي';
    }

    return party.openingBalances
        .map(
          (balance) {
            final amount =
                MoneyUtils.formatMinor(
              balance.amountMinor,
              balance
                  .currencyDecimalPlaces,
            );

            return balance.balanceSide ==
                    'receivable'
                ? 'عليه $amount ${balance.currencySymbol}'
                : 'له $amount ${balance.currencySymbol}';
          },
        )
        .join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<PartyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_title()),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            provider.submitting
                ? null
                : _add,
        icon: const Icon(
          Icons.person_add_alt_1,
        ),
        label:
            const Text('إضافة'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.fromLTRB(
              16,
              12,
              16,
              8,
            ),
            child: TextField(
              controller:
                  _searchController,
              textInputAction:
                  TextInputAction.search,
              onSubmitted:
                  (_) => _load(),
              decoration:
                  InputDecoration(
                hintText:
                    'بحث بالاسم أو الهاتف',
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
                _FilterChip(
                  label: 'العملاء',
                  value: 'customer',
                  selected:
                      _filter ==
                          'customer',
                  onSelected: (value) {
                    setState(() {
                      _filter = value;
                    });
                    _load();
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'الموردون',
                  value: 'supplier',
                  selected:
                      _filter ==
                          'supplier',
                  onSelected: (value) {
                    setState(() {
                      _filter = value;
                    });
                    _load();
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'النوعان',
                  value: 'both',
                  selected:
                      _filter == 'both',
                  onSelected: (value) {
                    setState(() {
                      _filter = value;
                    });
                    _load();
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'الكل',
                  value: 'all',
                  selected:
                      _filter == 'all',
                  onSelected: (value) {
                    setState(() {
                      _filter = value;
                    });
                    _load();
                  },
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
                      EdgeInsets.all(
                    12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons
                            .offline_bolt_outlined,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'عرض البيانات المحفوظة محليًا.',
                        ),
                      ),
                    ],
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
                          .parties
                          .isEmpty) {
                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  if (provider.error !=
                          null &&
                      provider
                          .parties
                          .isEmpty) {
                    return ListView(
                      padding:
                          const EdgeInsets
                              .all(24),
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        const Icon(
                          Icons
                              .error_outline,
                          size: 55,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          provider.error!,
                          textAlign:
                              TextAlign
                                  .center,
                        ),
                      ],
                    );
                  }

                  if (provider
                      .parties
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
                              .people_outline,
                          size: 60,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'لا توجد حسابات بعد.',
                          textAlign:
                              TextAlign
                                  .center,
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
                    itemCount: provider
                        .parties
                        .length,
                    separatorBuilder:
                        (_, _) =>
                            const SizedBox(
                      height: 8,
                    ),
                    itemBuilder:
                        (context, index) {
                      final party =
                          provider
                                  .parties[
                              index];

                      return Card(
                        child: ListTile(
                          onTap: () =>
                              _open(
                            party,
                          ),
                          leading:
                              CircleAvatar(
                            child: Icon(
                              party.isSupplier &&
                                      !party
                                          .isCustomer
                                  ? Icons
                                      .local_shipping_outlined
                                  : Icons
                                      .person_outline,
                            ),
                          ),
                          title: Text(
                            party.name,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                          subtitle: Text(
                            '${_typeLabel(party)}'
                            '${party.phone == null || party.phone!.isEmpty ? '' : ' • ${party.phone}'}\n'
                            '${_balanceSummary(party)}',
                          ),
                          isThreeLine: true,
                          trailing: Icon(
                            party.isActive
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

class _FilterChip
    extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final ValueChanged<String>
      onSelected;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) =>
          onSelected(value),
    );
  }
}
