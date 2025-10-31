// Flutter imports:

import 'package:desconto_direto_comercio_mobile/data/services/commerce_add_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/commerce_add_repository.dart';
import '../../core/themes/colors.dart';
import '../view_models/register_viewmodel.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = CommerceAddRepository();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Blue1,
        body: ChangeNotifierProvider(
          create: (_) => RegisterViewModel(CommerceAddService(repository)),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: Image.asset(
                    'assets/Logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: AppColors.Yellow1,
                  ),
                  child: SingleChildScrollView(child: RegisterForm()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
