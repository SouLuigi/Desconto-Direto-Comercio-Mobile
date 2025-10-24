import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/ui/widget_button.dart';
import 'register_form_input.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(
          'Cadastro',
          style: GoogleFonts.kaiseiDecol(
            textStyle: const TextStyle(
              color: AppColors.White1,
              fontWeight: FontWeight.w400,
              fontSize: 30,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        RegisterFormInput(name: 'Nome do comercio', label: 'Nome do Comercio'),
        RegisterFormInput(
          name: 'Categoria',
          label: 'Categoria ex: ( Mercado, Padaria)',
        ),
        RegisterFormInput(name: 'Telefone', label: 'Telefone'),
        RegisterFormInput(name: 'Email', label: 'Email'),
        RegisterFormInput(name: 'Senha', label: 'Senha'),
        RegisterFormInput(name: 'Confirmar Senha', label: 'Confirmar Senha'),
        Column(
          spacing: 6,
          children: [
            GestureDetector(
              onTap: () {
                print('Texto clicado');
              },
              child: Text(
                'Esqueceu a senha?',
                style: GoogleFonts.kaiseiDecol(
                  textStyle: const TextStyle(
                    color: AppColors.White1,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            WidgetButton(
              text: 'Cadastrar',
              onPressed: () {},
            ),
            WidgetButton(
              text: 'Entrar',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
