import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OfferEditForm extends StatefulWidget {
  const OfferEditForm({super.key});

  @override
  State<OfferEditForm> createState() => _OfferEditFormState();
}

class _OfferEditFormState extends State<OfferEditForm> {
  // VALORES FAKES PARA TESTE
  final String nomeProduto = "Veja Limpa Piso Max";
  final String medidaProduto = "500";
  final String unidadeProduto = "ML";
  final String categoriaProduto = "Limpeza";
  final String imagemProduto =
      "https://static.paodeacucar.com/media/uploads/produtos/7891035612702_1.jpg";

  // CAMPOS EDITÁVEIS
  final data = TextEditingController(text: "12/31/2025");
  final preco = TextEditingController(text: "8.90");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------ IMAGEM ------------------
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Image.network(
            imagemProduto,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 80),
          ),
        ),

        const SizedBox(height: 25),

        // ------------------ CAMPOS  ------------------
        _label("Nome do Produto"),
        _campoNaoEditavel(nomeProduto),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Medida"),
                  _campoNaoEditavel(medidaProduto),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Unidade"),
                  _campoNaoEditavel(unidadeProduto),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        _label("Categoria do Produto"),
        _campoNaoEditavel(categoriaProduto),

        const SizedBox(height: 20),

       
        _label("Data de Validade"),
        TextField(
          controller: data,
          readOnly: true,
          decoration: _decoration().copyWith(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month, color: Colors.orange),
              onPressed: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2040),
                );

                if (selected != null) {
                  data.text = DateFormat("MM/dd/yyyy").format(selected);
                }
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        _label("Preço"),
        TextField(
          controller: preco,
          keyboardType: TextInputType.number,
          decoration: _decoration(),
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Oferta atualizada! (fake)")),
              );
            },
            child: const Text(
              "Atualizar",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- HELPERS ----------------------

  Widget _campoNaoEditavel(String valor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFCDCDCD)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        valor,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  InputDecoration _decoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFCDCDCD)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
