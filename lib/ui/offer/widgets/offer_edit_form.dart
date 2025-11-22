import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OfferEditForm extends StatefulWidget {
  const OfferEditForm({super.key});

  @override
  State<OfferEditForm> createState() => _OfferEditFormState();
}

class _OfferEditFormState extends State<OfferEditForm> {
  late TextEditingController nome;
  late TextEditingController medida;
  late TextEditingController unidade;
  late TextEditingController categoria;
  late TextEditingController preco;
  late TextEditingController data;

  @override
  void initState() {
    super.initState();
    nome = TextEditingController(text: "Veja Limpador Spray Anti Bac Banheiro Oxi");
    medida = TextEditingController(text: "500");
    unidade = TextEditingController(text: "ML");
    categoria = TextEditingController(text: "Limpeza");
    preco = TextEditingController(text: "R\$ 8,90");
    data = TextEditingController(text: "08/17/2025");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // IMAGEM DO PRODUTO
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Image.network(
            "https://static.paodeacucar.com/media/uploads/produtos/7891035612702_1.jpg",
            height: 200,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 25),

        _label("Nome do Produto"),
        TextField(
          controller: nome,
          decoration: _inputDecoration(),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Medida"),
                  TextField(
                    controller: medida,
                    decoration: _inputDecoration(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Unidade de Medida"),
                  TextField(
                    controller: unidade,
                    decoration: _inputDecoration(),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        _label("Categoria do Produto"),
        TextField(
          controller: categoria,
          decoration: _inputDecoration(),
        ),

        const SizedBox(height: 20),

        _label("Data de postagem"),
        TextField(
          controller: data,
          decoration: _inputDecoration().copyWith(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month, color: Colors.orange),
              onPressed: () async {
                final selected = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2040),
                  initialDate: DateTime.now(),
                );
                if (selected != null) {
                  data.text = DateFormat('MM/dd/yyyy').format(selected);
                }
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        _label("Preço"),
        TextField(
          controller: preco,
          decoration: _inputDecoration(),
        ),

        const SizedBox(height: 30),

        // BOTÃO POSTAR
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
            onPressed: () {},
            child: const Text(
              "Postar",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF8A8A8A),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFCDCDCD), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
