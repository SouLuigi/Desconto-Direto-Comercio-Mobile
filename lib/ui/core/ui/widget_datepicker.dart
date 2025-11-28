import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final DateTime? initialDate;
  final Function(DateTime) onDateSelected; // Callback para a ViewModel
  final String? Function(String?)? validator;

  const CustomDatePicker({
    Key? key,
    required this.label,
    required this.controller,
    required this.onDateSelected,
    this.initialDate,
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
        // O PULO DO GATO: Impede o teclado de abrir
        onTap: () async {
          // Abre o calendário nativo do Android/iOS
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );

          if (pickedDate != null) {
            // 1. Formata a data para exibir no Input (Visual)
            // Dica: Para formatação profissional use o pacote 'intl'
            String formattedDate =
                "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";

            controller.text = formattedDate;

            // 2. Envia o objeto DateTime real para a ViewModel (Lógica)
            onDateSelected(pickedDate);
          }
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.Orange1),
          prefixIcon: const Icon(
            Icons.calendar_today,
            color: AppColors.Orange1,
          ),
          // Ícone de calendário
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
