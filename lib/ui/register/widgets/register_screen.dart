// Flutter imports:

import 'package:flutter/material.dart';
import '../../core/themes/colors.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Blue1,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                      'assets/Logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: AppColors.Yellow1,
                ),
                child: RegisterForm(),
              ),
            ],
          ),
        ),
    );
  }
}
