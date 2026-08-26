import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/user_management_provider.dart';
import 'create_user_screen.dart';

class UsersScreen
    extends StatefulWidget {
  const UsersScreen({
    super.key,
  });

  @override
  State<UsersScreen> createState() =>
      _UsersScreenState();
}

class _UsersScreenState
    extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<
              UserManagementProvider>()
          .loadUsers();
    });
  }

  Future<void> _create() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const CreateUserScreen(),
      ),
    );

    if (!mounted) {
      return;
    }

    await context
        .read<UserManagementProvider>()
        .loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<
            UserManagementProvider>();

    final currentUser =
        context.watch<AuthProvider>().user!;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text(
          'إدارة المستخدمين',
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: _create,
        icon:
            const Icon(Icons.person_add),
        label:
            const Text('إنشاء حساب'),
      ),

      body: provider.loading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh:
                  provider.loadUsers,
              child: ListView.builder(
                padding:
                    const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  100,
                ),
                itemCount:
                    provider.users.length,
                itemBuilder:
                    (context, index) {
                  final user =
                      provider.users[index];

                  final active =
                      user.status ==
                          'active';

                  final mine =
                      user.id ==
                          currentUser.id;

                  return Card(
                    margin:
                        const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          user.isManager
                              ? Icons
                                  .admin_panel_settings
                              : Icons
                                  .calculate,
                        ),
                      ),

                      title:
                          Text(user.name),

                      subtitle: Text(
                        '${user.email}\n'
                        '${user.isManager ? 'مدير' : 'محاسب'}'
                        ' • '
                        '${active ? 'فعال' : 'معطل'}',
                      ),

                      isThreeLine: true,

                      trailing: Switch(
                        value: active,
                        onChanged: mine
                            ? null
                            : (value) async {
                                final success =
                                    await provider
                                        .updateStatus(
                                  userId:
                                      user.id,
                                  status: value
                                      ? 'active'
                                      : 'inactive',
                                );

                                if (!context
                                    .mounted) {
                                  return;
                                }

                                if (!success) {
                                  ScaffoldMessenger
                                          .of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        provider.error ??
                                            'تعذر تعديل الحساب',
                                      ),
                                    ),
                                  );
                                }
                              },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}