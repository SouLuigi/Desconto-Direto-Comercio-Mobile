import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/colors.dart';

class WidgetButton extends StatelessWidget {

  final String text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;

  const WidgetButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.Blue1,
    this.textColor = AppColors.White1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.kaiseiDecol(
            textStyle: const TextStyle(
              color: AppColors.White1,
              fontWeight: FontWeight.w400,
              fontSize: 17,
            )
          ),
        )
      ),
    );
  }
}