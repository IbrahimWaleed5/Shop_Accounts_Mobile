import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/money_utils.dart';
import '../../models/worker_model.dart';
import '../../providers/worker_provider.dart';
import 'worker_details_screen.dart';
import 'worker_form_screen.dart';

class WorkersScreen
    extends StatefulWidget {
  const WorkersScreen({
    super.key,
  });

  @override
  State<WorkersScreen> createState() =>
      _WorkersScreenState();
}

class _WorkersScreenState
    extends State<WorkersScreen> {
  final _search =
      TextEditingController();

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
        .read<WorkerProvider>()
        .load(
          search: _search.text,
        );
  }

  Future<void> _add() async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const WorkerFormScreen(),
      ),
    );

    if (changed == true &&
        mounted) {
      await _load();
    }
  }

  Future<void> _open(
    WorkerModel worker,
  ) async {
    final changed =
        await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            WorkerDetailsScreen(
          worker: worker,
        ),
      ),
    );

    if (changed == true &&
        mounted) {
      await _load();
    }
  }

  String _wage(
    WorkerModel worker,
  ) {
    if (worker.wageType == 'none' ||
        worker.wageAmountMinor == null ||
        worker.wageCurrencyDecimalPlaces ==
            null) {
      return 'بدون أجر ثابت';
    }

    final amount =
        MoneyUtils.formatMinor(
      worker.wageAmountMinor!,
      worker
          .wageCurrencyDecimalPlaces!,
    );

    return '$amount ${worker.wageCurrencySymbol ?? ''} ${worker.wageType == 'monthly' ? 'شهري' : 'يومي'}';
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<WorkerProvider>();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('العمال'),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            provider.submitting
                ? null
                : _add,
        icon: const Icon(
          Icons.person_add_alt,
        ),
        label:
            const Text('إضافة عامل'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.all(16),
            child: TextField(
              controller: _search,
              textInputAction:
                  TextInputAction.search,
              onSubmitted:
                  (_) => _load(),
              decoration:
                  InputDecoration(
                hintText:
                    'بحث بالاسم أو الهاتف أو الوظيفة',
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

          if (provider.fromLocal)
            const Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 16,
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
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          'عرض العمال المحفوظين محليًا.',
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
                          .workers
                          .isEmpty) {
                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  if (provider.error !=
                          null &&
                      provider
                          .workers
                          .isEmpty) {
                    return ListView(
                      padding:
                          const EdgeInsets
                              .all(24),
                      children: [
                        const SizedBox(
                          height: 70,
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
                      .workers
                      .isEmpty) {
                    return ListView(
                      padding:
                          const EdgeInsets
                              .all(24),
                      children: const [
                        SizedBox(
                          height: 70,
                        ),
                        Icon(
                          Icons
                              .badge_outlined,
                          size: 60,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'لا يوجد عمال بعد.',
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
                      10,
                      16,
                      100,
                    ),
                    itemCount: provider
                        .workers
                        .length,
                    separatorBuilder:
                        (_, _) =>
                            const SizedBox(
                      height: 8,
                    ),
                    itemBuilder:
                        (context, index) {
                      final worker =
                          provider
                                  .workers[
                              index];

                      return Card(
                        child: ListTile(
                          onTap: () =>
                              _open(
                            worker,
                          ),
                          leading:
                              const CircleAvatar(
                            child: Icon(
                              Icons
                                  .badge_outlined,
                            ),
                          ),
                          title: Text(
                            worker.name,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                          subtitle: Text(
                            '${worker.jobTitle ?? 'عامل'}\n${_wage(worker)}',
                          ),
                          isThreeLine: true,
                          trailing: Icon(
                            worker.isActive
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
