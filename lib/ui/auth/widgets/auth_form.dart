import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
import '../../core/themes/colors.dart';
import '../view_models/auth_viewmodel.dart';
import 'auth_form_input.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) {
        final isLoading = authViewModel.isLoading;

        return FormBuilder(
          key: formKey,
          child: Column(
            spacing: 20,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text(
                  'Login',
                  style: GoogleFonts.kaiseiDecol(
                    textStyle: const TextStyle(
                      color: AppColors.White1,
                      fontWeight: FontWeight.w400,
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
              AuthFormInput(
                name: 'email',
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.email(),
              ),
              AuthFormInput(
                name: 'senha',
                label: 'Senha',
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              Column(
                spacing: 15,
                children: [
                  GestureDetector(
                    child: Text(
                      'Esqueci minha senha.',
                      style: GoogleFonts.kaiseiDecol(
                        textStyle: const TextStyle(
                          color: AppColors.White1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  WidgetButton(
                    text: isLoading ? 'Entrando...' : 'Entrar',
                    onPressed: isLoading
                        ? null
                        : () async {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final email = formKey.currentState!.value['email'];
                        final senha = formKey.currentState!.value['senha'];

                        await authViewModel.login(
                          email: email,
                          senha: senha,
                        );

                        if (authViewModel.errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(authViewModel.errorMessage!),
                            ),
                          );
                          return;
                        }

                        if (authViewModel.isAuthenticated) {
                          context.push(Routes.primary);
                        }
                      }
                    },
                  ),
                  WidgetButton(
                    text: 'Cadastrar',
                    onPressed: isLoading
                        ? null
                        : () {
                      context.push(Routes.register);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
