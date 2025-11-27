import 'dart:io';
import 'package:flutter/material.dart';
import '../../Navigation/widget/navigation_screen.dart';
import '../viewmodel/flyer_create_viewmodel.dart';
import '../widgets/flyer_expiration_field_widget.dart';
import '../widgets/flyer_image_picker_widget.dart';

class FlyerCreateScreen extends StatefulWidget {
  const FlyerCreateScreen({super.key});



  @override
  State<FlyerCreateScreen> createState() => _FlyerCreateScreenState();
}

class _FlyerCreateScreenState extends State<FlyerCreateScreen> {
  final vm = FlyerCreateViewModel();
  final dataCtrl = TextEditingController();

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );

    if (data != null) {
      vm.selecionarData(data);
      dataCtrl.text = "${data.day}/${data.month}/${data.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
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

              const SizedBox(height: 30),

              FlyerExpirationFieldWidget(
                controller: dataCtrl,
                onTap: _selecionarData,
              ),

              const SizedBox(height: 40),

              ValueListenableBuilder<bool>(
                valueListenable: vm.loading,
                builder: (_, loading, __) {
                  return ElevatedButton(
                    onPressed: loading
                        ? null
                        : () async {
                      final ok = await vm.salvarFlyer();
                      if (ok && mounted)Navigator.pop(context, true);

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Salvar Panfleto",
                      style:
                      TextStyle(color: Colors.white, fontSize: 18),
                    ),
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
