import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),

      child: Row(
        children: [
          // Ícone Colorido
          Container(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, color: AppColors.Blue1, size: 24),
          ),

          // Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.kaiseiDecol(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColors.Orange1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.Yellow1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
