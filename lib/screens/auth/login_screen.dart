import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import 'register_request_screen.dart';

class LoginScreen
    extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  static const _primary =
      Color(0xFF5152B9);

  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  bool _hidePassword =
      true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _login() async {
    if (
      !_formKey.currentState!
          .validate()
    ) {
      return;
    }

    FocusScope.of(context)
        .unfocus();

    await context
        .read<AuthProvider>()
        .login(
          email:
              _emailController.text,
          password:
              _passwordController.text,
        );
  }

  Future<void> _register() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder:
            (_) =>
                const RegisterRequestScreen(),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final auth =
        context.watch<
            AuthProvider>();

    return Scaffold(
      backgroundColor:
          const Color(
            0xFFF8F9FA,
          ),
      body:
          SafeArea(
        child:
            Center(
          child:
              SingleChildScrollView(
            padding:
                const EdgeInsets.all(
              24,
            ),
            child:
                ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth:
                    420,
              ),
              child:
                  Form(
                key:
                    _formKey,
                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,
                  children: [
                    const Icon(
                      Icons
                          .storefront_rounded,
                      size:
                          82,
                      color:
                          _primary,
                    ),
                    const SizedBox(
                      height:
                          18,
                    ),
                    Text(
                      'نظام حسابات الدكان',
                      textAlign:
                          TextAlign.center,
                      style:
                          Theme.of(
                        context,
                      )
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontWeight:
                                FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height:
                          8,
                    ),
                    const Text(
                      'تسجيل الدخول لأول مرة يحتاج إلى الإنترنت',
                      textAlign:
                          TextAlign.center,
                    ),
                    const SizedBox(
                      height:
                          32,
                    ),
                    TextFormField(
                      controller:
                          _emailController,
                      keyboardType:
                          TextInputType
                              .emailAddress,
                      textInputAction:
                          TextInputAction.next,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'البريد الإلكتروني',
                        prefixIcon:
                            Icon(
                          Icons
                              .email_outlined,
                        ),
                        border:
                            OutlineInputBorder(),
                      ),
                      validator:
                          (value) {
                        if (
                          value == null ||
                          value.trim().isEmpty
                        ) {
                          return 'أدخل البريد الإلكتروني';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height:
                          16,
                    ),
                    TextFormField(
                      controller:
                          _passwordController,
                      obscureText:
                          _hidePassword,
                      onFieldSubmitted:
                          (_) =>
                              _login(),
                      decoration:
                          InputDecoration(
                        labelText:
                            'كلمة المرور',
                        prefixIcon:
                            const Icon(
                          Icons
                              .lock_outline,
                        ),
                        suffixIcon:
                            IconButton(
                          onPressed:
                              () {
                            setState(() {
                              _hidePassword =
                                  !_hidePassword;
                            });
                          },
                          icon:
                              Icon(
                            _hidePassword
                                ? Icons
                                    .visibility_outlined
                                : Icons
                                    .visibility_off_outlined,
                          ),
                        ),
                        border:
                            const OutlineInputBorder(),
                      ),
                      validator:
                          (value) {
                        if (
                          value == null ||
                          value.isEmpty
                        ) {
                          return 'أدخل كلمة المرور';
                        }

                        return null;
                      },
                    ),
                    if (
                      auth.errorMessage !=
                      null
                    ) ...[
                      const SizedBox(
                        height:
                            16,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),
                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                          border:
                              Border.all(
                            color:
                                Theme.of(
                              context,
                            )
                                    .colorScheme
                                    .error,
                          ),
                        ),
                        child:
                            Text(
                          auth.errorMessage!,
                          textAlign:
                              TextAlign.center,
                          style:
                              TextStyle(
                            color:
                                Theme.of(
                              context,
                            )
                                    .colorScheme
                                    .error,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(
                      height:
                          24,
                    ),
                    SizedBox(
                      height:
                          54,
                      child:
                          FilledButton.icon(
                        onPressed:
                            auth.isLoading
                                ? null
                                : _login,
                        icon:
                            auth.isLoading
                                ? const SizedBox(
                                    width:
                                        20,
                                    height:
                                        20,
                                    child:
                                        CircularProgressIndicator(
                                      strokeWidth:
                                          2,
                                    ),
                                  )
                                : const Icon(
                                    Icons.login,
                                  ),
                        label:
                            Text(
                          auth.isLoading
                              ? 'جارٍ تسجيل الدخول...'
                              : 'تسجيل الدخول',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height:
                          12,
                    ),
                    OutlinedButton.icon(
                      onPressed:
                          auth.isLoading
                              ? null
                              : _register,
                      icon:
                          const Icon(
                        Icons
                            .person_add_alt_1_outlined,
                      ),
                      label:
                          const Text(
                        'إنشاء حساب جديد',
                      ),
                    ),
                    const SizedBox(
                      height:
                          8,
                    ),
                    const Text(
                      'الحسابات الجديدة تكون مدير أو محاسب فقط وتحتاج موافقة المدير قبل تسجيل الدخول.',
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        fontSize:
                            12,
                        color:
                            Color(
                          0xFF64636F,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
