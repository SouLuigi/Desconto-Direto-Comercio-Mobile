import 'package:desconto_direto_comercio_mobile/ui/register/view_models/register_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/themes/colors.dart';

class RegisterFormDropdown extends StatelessWidget{
  const RegisterFormDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Categoria',
          hintText: 'Selecione a Categoria',
          labelStyle: TextStyle(color: AppColors.White1),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.White1, width: 2.0),
            ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.Blue1, width: 2.0),
          ),
        ),
        isExpanded: true,
        initialValue: viewModel.categoria.isEmpty ? null : viewModel.categoria,
        icon: const Icon(Icons.arrow_drop_down, color: AppColors.White1),
        style: const TextStyle(color: AppColors.White1, fontSize: 16),
        dropdownColor: AppColors.Blue1,
        items: viewModel.categories.map((String category){
          return DropdownMenuItem<String>(
              value: category,
              child: Text(category,style: const TextStyle(color: AppColors.White1)),
          );
        }).toList(),
        onChanged: (String ? newValue){
          viewModel.setCategoria(newValue!);
        },
        validator: (value){
          if(value == null || value.isEmpty){
            return 'Por favor, selecione uma categoria';
          }
          return null;
        }
      ),
    );
  }
}