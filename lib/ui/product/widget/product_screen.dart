import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/themes/colors.dart';
import '../../core/ui/widget_button.dart';
import '../../core/ui/widget_textField.dart';
import '../../core/ui/widget_dropdown.dart';
import '../../flyers/widgets/flyer_image_picker_widget.dart';
import '../viewmodel/product_create_viewmodel.dart';

class ProductCreateScreen extends StatefulWidget {
  const ProductCreateScreen({super.key});

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final vm = ProductCreateViewModel();


  final nomeCtrl = TextEditingController();
  final medidaCtrl = TextEditingController();
  final unidadeCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final List<String> _categories = const [
    'Supermercado / Mercearia',
    'Padaria / Confeitaria',
    'Açougue',
    'Peixaria',
    'Lanchonete / Pastelaria',
    'Pizzaria',
    'Oficina Mecânica',
    'Autopeças',
    'Borracharia',
    'Farmácia / Drogaria',
    'Loja de Roupas / Boutique',
    'Loja de Calçados',
    'Salão de Beleza / Barbearia',
    'Pet Shop',
    'Papelaria / Utilidades',
    'Eletrônicos / Informática',
    'Móveis / Decoração',
    'Materiais de Construção',
    'Outros',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF003049),
        title: Text(
          "Cadastrar Produto",
          style: GoogleFonts.kaiseiDecol(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [


              ValueListenableBuilder<File?>(
                valueListenable: vm.imagemSelecionada,
                builder: (_, file, __) {
                  return FlyerImagePickerWidget(
                    file: file,
                    onTap: vm.selecionarImagem,
                  );
                },
              ),

              const SizedBox(height: 20),


              CustomInput(
                label: "Nome do Produto",
                controller: nomeCtrl,
                validator: (v) =>
                v == null || v.isEmpty ? "Obrigatório" : null,
              ),

              const SizedBox(height: 10),


              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      label: "Medida",
                      controller: medidaCtrl,
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                      v == null || v.isEmpty ? "Obrigatório" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomInput(
                      label: "Unidade",
                      controller: unidadeCtrl,
                      validator: (v) =>
                      v == null || v.isEmpty ? "Obrigatório" : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),


              CustomDropdown(
                label: "Categoria",
                items: _categories,
                value: vm.categoria.isEmpty ? null : vm.categoria,
                onChanged: (value) {
                  vm.setCategoria(value ?? "");
                  setState(() {});
                },
                validator: (value) =>
                value == null || value.isEmpty ? "Selecione uma categoria" : null,
                icon: Icons.category,
              ),

              const SizedBox(height: 35),


              ValueListenableBuilder<bool>(
                valueListenable: vm.loading,
                builder: (_, loading, __) {
                  return WidgetButton(
                    text: "Postar",
                    color: AppColors.Orange1,
                    textColor: Colors.white,
                    onPressed: loading
                        ? null
                        : () async {
                      vm.setNome(nomeCtrl.text);
                      vm.setMedida(medidaCtrl.text);
                      vm.setUnidade(unidadeCtrl.text);

                      if (_formKey.currentState!.validate()) {
                        final ok = await vm.salvarProduto();
                        if (ok && mounted) Navigator.pop(context, true);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
