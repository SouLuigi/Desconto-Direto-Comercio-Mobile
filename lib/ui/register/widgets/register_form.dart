import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/ui/widget_button.dart';
import '../view_models/register_viewmodel.dart';
import 'register_form_dropdown.dart';
import 'register_form_input.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegisterViewModel>();
    final status = context.select((RegisterViewModel vm) => vm.status);
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        spacing: 10,
        children: [
          Text(
            'Cadastro',
            style: GoogleFonts.kaiseiDecol(
              textStyle: const TextStyle(
                color: AppColors.White1,
                fontWeight: FontWeight.w400,
                fontSize: 35,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          RegisterFormInput(
            name: 'nome',
            label: 'Nome do Comercio',
            onChanged: (value) => viewModel.setNome(value ??  ''),
          ),
          RegisterFormDropdown(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, selecione uma categoria';
              }
              return null;
            },
            onChanged: (value) => viewModel.setCategoria(value ?? ''),
          ),
          RegisterFormInput(
            name: 'telefone',
            label: 'Telefone',
            keyboardType: TextInputType.phone,
            onChanged: (value) => viewModel.setTelefone(value ?? ''),
            validator: FormBuilderValidators.phoneNumber(
              checkNullOrEmpty: true,
            ),
          ),
          RegisterFormInput(
            name: 'email',
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: FormBuilderValidators.email(),
            onChanged: (value) => viewModel.setEmail(value ?? ''),
          ),
          RegisterFormInput(
            name: 'senha',
            label: 'Senha',
            obscureText: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(4),
            ]),
            onChanged: (value) => viewModel.setSenha(value ?? ''),
          ),
          RegisterFormInput(
            name: 'confirmar',
            label: 'Confirmar Senha',
            obscureText: true,
            validator: (value) {
              if (value != viewModel.senha) {
                return 'As senhas não coincidem';
              }
              return null;
            },
          ),
          const SizedBox(height: 0),
          Column(
            spacing: 10,
            children: [
              WidgetButton(
                text: status == CreationStatus.loading
                    ? 'Aguarde...'
                    : 'Avançar',
                onPressed: status == CreationStatus.loading
                    ? null
                    : () {
                  if (formKey.currentState?.validate() ?? false) {
                    viewModel.createRegister();
                  }
                },
              ),
              WidgetButton(text: 'Voltar', onPressed: () {
                context.pop();
              }),
              if (status == CreationStatus.error)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    viewModel.errorMessage ?? 'Erro desconhecido.',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
