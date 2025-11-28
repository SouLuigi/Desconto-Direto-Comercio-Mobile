import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../routing/routes.dart';
import '../../core/themes/colors.dart';
import '../view_models/auth_viewmodel.dart';
import 'auth_form_input.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Consumer<AuthViewModel>(
        builder: (context, authViewModel, child){
          final isLoading = authViewModel.isLoading == true;
          return  FormBuilder(
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
                    textAlign: TextAlign.center,
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
                  validator: FormBuilderValidators.password(minLength: 4),
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
                          : () {
                        if (formKey.currentState?.saveAndValidate() ?? false) {
                          final email = formKey.currentState?.value['email'] as String;
                          final senha = formKey.currentState?.value['senha'] as String;

                          authViewModel.login(email: email, password: senha);
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
        }
    );

  }
}
