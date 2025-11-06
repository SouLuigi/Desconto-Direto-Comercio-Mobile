import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import 'auth_form.dart';

class AuthScreen extends StatelessWidget{
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.Blue1,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 100.0),
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
                child: SingleChildScrollView(child: AuthForm()),
              ),
            ),
          ],
        ),

      ),
    );
  }
}