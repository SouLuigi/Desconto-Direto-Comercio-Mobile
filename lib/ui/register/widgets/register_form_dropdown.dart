import 'package:desconto_direto_comercio_mobile/ui/register/view_models/register_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/themes/colors.dart';

class RegisterFormDropdown extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;

  const RegisterFormDropdown({super.key, this.validator, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();
    return SizedBox(
      child: DropdownButtonFormField<String>(
        hint: const Text(
          'Selecione a Categoria',
          style: TextStyle(color: AppColors.Yellow1),
        ),
        decoration: InputDecoration(
          hintText: 'Selecione a Categoria',
          labelStyle: const TextStyle(color: AppColors.Blue1),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.White1, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.White1, width: 1.0),
          ),
          filled: true,
          fillColor: AppColors.White1,
        ),
        isExpanded: true,
        initialValue: viewModel.categoria.isEmpty ? null : viewModel.categoria,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: AppColors.Yellow1,
          size: 30,
        ),
        style: const TextStyle(color: AppColors.Blue1, fontSize: 16),
        dropdownColor: AppColors.Blue1,
        items: viewModel.categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: const TextStyle(color: AppColors.Yellow1),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
