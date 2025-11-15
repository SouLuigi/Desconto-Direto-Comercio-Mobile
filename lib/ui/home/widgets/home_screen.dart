import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.Blue1,
          leading: IconButton(
            icon: Icon(Icons.account_circle_outlined, color: AppColors.Yellow1),
            onPressed: () {},
            tooltip: 'Perfil',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 47,
              color: AppColors.Yellow1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Minhas Ofertas',
                  style: GoogleFonts.kaiseiDecol(
                    textStyle: const TextStyle(
                      color: AppColors.White1,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
