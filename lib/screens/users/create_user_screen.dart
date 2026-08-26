import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_roles.dart';
import '../../providers/user_management_provider.dart';

class CreateUserScreen
    extends StatefulWidget {
  const CreateUserScreen({
    super.key,
  });

  @override
  State<CreateUserScreen> createState() =>
      _CreateUserScreenState();
}

class _CreateUserScreenState
    extends State<CreateUserScreen> {
  final _formKey =
      GlobalKey<FormState>();

  final _name =
      TextEditingController();

  final _email =
      TextEditingController();

  final _password =
      TextEditingController();

  final _confirm =
      TextEditingController();

  String _role =
      AppRoles.accountant;

  bool _hidePassword = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();

    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider =
        context.read<
            UserManagementProvider>();

    final success =
        await provider.createUser(
      name: _name.text,
      email: _email.text,
      password: _password.text,
      role: _role,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'تم إنشاء الحساب بنجاح',
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
              'تعذر إنشاء الحساب',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<
            UserManagementProvider>();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('إنشاء حساب'),
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
              TextFormField(
                controller: _name,
                decoration:
                    const InputDecoration(
                  labelText: 'الاسم',
                  prefixIcon:
                      Icon(Icons.person),
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل الاسم';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _email,
                keyboardType:
                    TextInputType
                        .emailAddress,
                decoration:
                    const InputDecoration(
                  labelText:
                      'البريد الإلكتروني',
                  prefixIcon:
                      Icon(Icons.email),
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'أدخل البريد الإلكتروني';
                  }

                  if (!value.contains('@')) {
                    return 'البريد غير صحيح';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _role,
                decoration:
                    const InputDecoration(
                  labelText: 'نوع الحساب',
                  border:
                      OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value:
                        AppRoles.accountant,
                    child:
                        Text('محاسب'),
                  ),
                  DropdownMenuItem(
                    value:
                        AppRoles.manager,
                    child:
                        Text('مدير'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _role = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _password,
                obscureText:
                    _hidePassword,
                decoration:
                    InputDecoration(
                  labelText:
                      'كلمة المرور',
                  prefixIcon:
                      const Icon(
                    Icons.lock,
                  ),
                  suffixIcon:
                      IconButton(
                    onPressed: () {
                      setState(() {
                        _hidePassword =
                            !_hidePassword;
                      });
                    },
                    icon: Icon(
                      _hidePassword
                          ? Icons.visibility
                          : Icons
                              .visibility_off,
                    ),
                  ),
                  border:
                      const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.length < 8) {
                    return 'كلمة المرور 8 أحرف على الأقل';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _confirm,
                obscureText: true,
                decoration:
                    const InputDecoration(
                  labelText:
                      'تأكيد كلمة المرور',
                  prefixIcon:
                      Icon(Icons.lock_reset),
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value !=
                      _password.text) {
                    return 'كلمتا المرور غير متطابقتين';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 55,
                child: FilledButton.icon(
                  onPressed:
                      provider.submitting
                          ? null
                          : _save,
                  icon:
                      const Icon(
                    Icons.person_add,
                  ),
                  label: Text(
                    provider.submitting
                        ? 'جارٍ الإنشاء...'
                        : 'إنشاء الحساب',
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