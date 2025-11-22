import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/flyer_repository.dart';
import '../../../data/services/flyer_service.dart';

class FlyerCreatePage extends StatefulWidget {
  const FlyerCreatePage({super.key});

  @override
  State<FlyerCreatePage> createState() => _FlyerCreatePageState();
}

class _FlyerCreatePageState extends State<FlyerCreatePage> {
  late final FlyerService flyerService;

  _FlyerCreatePageState() {
    flyerService = FlyerService(FlyerRepository());
  }

  File? imagemSelecionada;
  DateTime? dataExpiracao;

  final TextEditingController dataExpiracaoCtrl = TextEditingController();

  bool loading = false;

  // TODO - depois pegue do login
  final int comercioId = 1;

  Future<void> selecionarImagem() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowedExtensions: ["jpg", "jpeg", "png"],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        imagemSelecionada = File(result.files.single.path!);
      });
    }
  }

  Future<void> selecionarData() async {
    final data = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
    );

    if (data != null) {
      setState(() {
        dataExpiracao = data;
        dataExpiracaoCtrl.text = "${data.day}/${data.month}/${data.year}";
      });
    }
  }

  Future<void> salvar() async {
    if (imagemSelecionada == null || dataExpiracao == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos!")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      // 1️⃣ Criar flyer com dados obrigatórios
      final flyer = Flyer(
        id: 0,
        fotoUrl: "temp", // necessário pois o service exige não vazio
        dataExpiracao: dataExpiracao!,
        comercioId: comercioId,
      );

      final criado = await flyerService.createNewFlyer(flyer);

      // 2️⃣ Fazer upload da imagem
      final ok = await flyerService.uploadImageOfFlyer(
        criado.id,
        imagemSelecionada!,
      );

      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Panfleto cadastrado com sucesso!")),
        );
        Navigator.pop(context);
      } else {
        throw Exception("Erro ao enviar imagem");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Cadastro de Panfleto"),
        backgroundColor: const Color(0xFF003A57),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 📌 área da imagem
            GestureDetector(
              onTap: selecionarImagem,
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imagemSelecionada == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_a_photo,
                        size: 50, color: Colors.orange),
                    SizedBox(height: 10),
                    Text(
                      "Adicionar imagem\nJPG, PNG somente",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(imagemSelecionada!,
                      fit: BoxFit.cover),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 📌 data de expiração
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Data de expiração",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
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
                          controller: dataExpiracaoCtrl,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "DD/MM/YYYY",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_month,
                            color: Colors.orange),
                        onPressed: selecionarData,
                      )
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 📌 botão postar
            SizedBox(
              width: double.infinity,
              height: 48,
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
