import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomTimePicker extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TimeOfDay? initialTime;
  final Function(TimeOfDay) onTimeSelected;
  final String? Function(String?)? validator;

  const CustomTimePicker({
    Key? key,
    required this.label,
    required this.controller,
    required this.onTimeSelected,
    this.initialTime,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        readOnly: true,
        // Bloqueia o teclado
        onTap: () async {
          // Abre o relógio nativo
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: initialTime ?? TimeOfDay.now(),
            builder: (context, child) {
              // Ajuste opcional para forçar modo 24h se o dispositivo não estiver
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
          );

          if (pickedTime != null) {
            // 1. Formata para String (HH:mm) para exibir na tela
            // padLeft(2, '0') garante que 9:5 vire 09:05
            final String formattedTime =
                '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';

            controller.text = formattedTime;

            // 2. Envia o objeto TimeOfDay para a ViewModel
            onTimeSelected(pickedTime);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.Orange1),
          prefixIcon: const Icon(Icons.access_time, color: AppColors.Orange1),
          // Ícone de relógio
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.Orange1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.Orange1, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
