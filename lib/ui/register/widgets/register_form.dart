import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.White1,
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
        GestureDetector(
          onTap: () {
            print('Texto clicado');
          },
          child: Text(
            'Esqueceu a senha?',
            style: TextStyle(color: AppColors.White1),
          ),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Cadastrar')),
        ElevatedButton(onPressed: () {}, child: Text('Entrar')),
      ],
    );
  }
}
