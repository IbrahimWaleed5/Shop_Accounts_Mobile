import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterRequestScreen
    extends StatefulWidget {
  const RegisterRequestScreen({
    super.key,
  });

  @override
  State<RegisterRequestScreen>
      createState() =>
          _RegisterRequestScreenState();
}

class _RegisterRequestScreenState
    extends State<
        RegisterRequestScreen> {
  static const _background =
      Color(0xFFF8F9FA);

  static const _primary =
      Color(0xFF5152B9);

  final _formKey =
      GlobalKey<FormState>();

  final _nameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final _confirmController =
      TextEditingController();

  String _role =
      'accountant';

  bool _hidePassword =
      true;

  bool _hideConfirmation =
      true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback(
      (_) {
        context
            .read<AuthProvider>()
            .clearRequestFeedback();
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (
      !_formKey.currentState!
          .validate()
    ) {
      return;
    }

    FocusScope.of(context)
        .unfocus();

    final auth =
        context.read<
            AuthProvider>();

    final ok =
        await auth.requestAccount(
      name:
          _nameController.text,
      email:
          _emailController.text,
      password:
          _passwordController.text,
      passwordConfirmation:
          _confirmController.text,
      role:
          _role,
    );

    if (
      !mounted ||
      !ok
    ) {
      return;
    }

    await showDialog<void>(
      context:
          context,
      barrierDismissible:
          false,
      builder:
          (dialogContext) =>
              AlertDialog(
        icon:
            const Icon(
          Icons
              .hourglass_top_rounded,
          color:
              _primary,
          size:
              42,
        ),
        title:
            const Text(
          'تم إرسال الطلب',
        ),
        content:
            Text(
          auth.requestSuccess ??
              'الطلب بانتظار موافقة المدير.',
          textAlign:
              TextAlign.center,
        ),
        actions: [
          FilledButton(
            onPressed:
                () =>
                    Navigator.pop(
              dialogContext,
            ),
            child:
                const Text(
              'العودة لتسجيل الدخول',
            ),
          ),
        ],
      ),
    );

    if (mounted) {
      Navigator.pop(
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth =
        context.watch<
            AuthProvider>();

    return Scaffold(
      backgroundColor:
          _background,
      appBar:
          AppBar(
        backgroundColor:
            _background,
        elevation:
            0,
        scrolledUnderElevation:
            0,
        title:
            const Text(
          'طلب إنشاء حساب',
          style:
              TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),
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
                    440,
              ),
              child:
                  Container(
                padding:
                    const EdgeInsets.all(
                  20,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  border:
                      Border.all(
                    color:
                        const Color(
                          0xFFC7C5D4,
                        ).withValues(
                      alpha:
                          .35,
                    ),
                  ),
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
                            .person_add_alt_1_rounded,
                        size:
                            62,
                        color:
                            _primary,
                      ),
                      const SizedBox(
                        height:
                            12,
                      ),
                      const Text(
                        'إنشاء حساب مدير أو محاسب فقط',
                        textAlign:
                            TextAlign.center,
                        style:
                            TextStyle(
                          fontSize:
                              20,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height:
                            6,
                      ),
                      const Text(
                        'لن يتم تفعيل الحساب إلا بعد موافقة المدير.',
                        textAlign:
                            TextAlign.center,
                      ),
                      const SizedBox(
                        height:
                            22,
                      ),
                      TextFormField(
                        controller:
                            _nameController,
                        textInputAction:
                            TextInputAction.next,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'الاسم',
                          prefixIcon:
                              Icon(
                            Icons
                                .person_outline,
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
                            return 'أدخل الاسم';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height:
                            14,
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

                          if (
                            !value.contains(
                              '@',
                            )
                          ) {
                            return 'البريد الإلكتروني غير صحيح';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height:
                            14,
                      ),
                      DropdownButtonFormField<
                          String>(
                        initialValue:
                            _role,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'نوع الحساب',
                          prefixIcon:
                              Icon(
                            Icons
                                .badge_outlined,
                          ),
                          border:
                              OutlineInputBorder(),
                        ),
                        items:
                            const [
                          DropdownMenuItem(
                            value:
                                'accountant',
                            child:
                                Text(
                              'محاسب',
                            ),
                          ),
                          DropdownMenuItem(
                            value:
                                'manager',
                            child:
                                Text(
                              'مدير',
                            ),
                          ),
                        ],
                        onChanged:
                            (value) {
                          if (
                            value != null
                          ) {
                            setState(() {
                              _role =
                                  value;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height:
                            14,
                      ),
                      TextFormField(
                        controller:
                            _passwordController,
                        obscureText:
                            _hidePassword,
                        textInputAction:
                            TextInputAction.next,
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
                            value.length < 8
                          ) {
                            return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height:
                            14,
                      ),
                      TextFormField(
                        controller:
                            _confirmController,
                        obscureText:
                            _hideConfirmation,
                        onFieldSubmitted:
                            (_) =>
                                _submit(),
                        decoration:
                            InputDecoration(
                          labelText:
                              'تأكيد كلمة المرور',
                          prefixIcon:
                              const Icon(
                            Icons
                                .lock_reset_outlined,
                          ),
                          suffixIcon:
                              IconButton(
                            onPressed:
                                () {
                              setState(() {
                                _hideConfirmation =
                                    !_hideConfirmation;
                              });
                            },
                            icon:
                                Icon(
                              _hideConfirmation
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
                            value !=
                            _passwordController.text
                          ) {
                            return 'تأكيد كلمة المرور غير مطابق';
                          }

                          return null;
                        },
                      ),
                      if (
                        auth.requestError !=
                        null
                      ) ...[
                        const SizedBox(
                          height:
                              14,
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
                            auth.requestError!,
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
                            20,
                      ),
                      SizedBox(
                        height:
                            52,
                        child:
                            FilledButton.icon(
                          onPressed:
                              auth.requestLoading
                                  ? null
                                  : _submit,
                          icon:
                              auth.requestLoading
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
                                      Icons
                                          .send_outlined,
                                    ),
                          label:
                              Text(
                            auth.requestLoading
                                ? 'جاري إرسال الطلب...'
                                : 'إرسال الطلب للمدير',
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
      ),
    );
  }
}
