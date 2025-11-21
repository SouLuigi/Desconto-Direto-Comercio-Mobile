import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'flyers_create_controller.dart';

class FlyersCreatePage extends StatefulWidget {
  const FlyersCreatePage({super.key});

  @override
  State<FlyersCreatePage> createState() => _FlyersCreatePageState();
}

class _FlyersCreatePageState extends State<FlyersCreatePage> {
  final controller = FlyersCreateController();

  File? imagemSelecionada;

  final TextEditingController postagemCtrl = TextEditingController();
  final TextEditingController vencimentoCtrl = TextEditingController();

  final ImagePicker picker = ImagePicker();

  Future<void> selecionarImagem() async {
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() => imagemSelecionada = File(img.path));
    }
  }

  Future<void> salvar() async {
    if (imagemSelecionada == null ||
        postagemCtrl.text.isEmpty ||
        vencimentoCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos!")),
      );
      return;
    }

    final sucesso = await controller.cadastrarFlyer(
      imagem: imagemSelecionada!,
      dataPostagem: postagemCtrl.text,
      dataVencimento: vencimentoCtrl.text,
    );

    if (sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Panfleto cadastrado com sucesso!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao cadastrar panfleto")),
      );
    }
  }

  Future<void> selecionarData(TextEditingController controller) async {
    DateTime? data = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
    );

    if (data != null) {
      controller.text = "${data.month}/${data.day}/${data.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF003A57),
        elevation: 0,
        title: const Text("Tela Cadastro Panfleto"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: selecionarImagem,
              child: Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imagemSelecionada == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.camera_alt,
                        size: 50, color: Colors.orange),
                    SizedBox(height: 10),
                    Text(
                      "Adicionar imagem\nJPG, PNG somente",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(imagemSelecionada!,
                      fit: BoxFit.cover),
                ),
              ),
            ),

            const SizedBox(height: 25),

            _campoData(
              label: "Data de postagem",
              controller: postagemCtrl,
              onPress: () => selecionarData(postagemCtrl),
            ),

            const SizedBox(height: 15),

            _campoData(
              label: "Data de vencimento",
              controller: vencimentoCtrl,
              onPress: () => selecionarData(vencimentoCtrl),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Postar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _campoData({
    required String label,
    required TextEditingController controller,
    required VoidCallback onPress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600)),

        const SizedBox(height: 5),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "MM/DD/YYYY"),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month, color: Colors.orange),
                onPressed: onPress,
              )
            ],
          ),
        ),
      ],
    );
  }
}
