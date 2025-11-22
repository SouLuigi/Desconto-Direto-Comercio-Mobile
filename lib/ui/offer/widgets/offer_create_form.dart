import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class OfferCreateForm extends StatefulWidget {
  const OfferCreateForm({super.key});

  @override
  State<OfferCreateForm> createState() => _OfferCreateFormState();
}

class _OfferCreateFormState extends State<OfferCreateForm> {
  final search = TextEditingController();
  final nome = TextEditingController();
  final medida = TextEditingController();
  final unidade = TextEditingController();
  final categoria = TextEditingController();
  final preco = TextEditingController();
  final data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SEARCH BAR
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: search,
                  decoration: const InputDecoration(
                    hintText: "Veja Limpador Spray Anti Bac Banheiro Oxi",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.orange),
                onPressed: () {},
              )
            ],
          ),
        ),

        const SizedBox(height: 25),
        
      

        // IMAGE BOX
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
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 80),
          ),
        ),

        const SizedBox(height: 25),

        _label("Nome do Produto"),
        TextField(controller: nome, decoration: _decoration()),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Medida"),
                  TextField(controller: medida, decoration: _decoration()),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Unidade de Medida"),
                  TextField(controller: unidade, decoration: _decoration()),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        _label("Categoria do Produto"),
        TextField(controller: categoria, decoration: _decoration()),

        const SizedBox(height: 20),

        _label("Data de postagem"),
        TextField(
          controller: data,
          decoration: _decoration().copyWith(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month, color: Colors.orange),
              onPressed: () async {
                final selected = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
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
        TextField(controller: preco, decoration: _decoration()),

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
        )
      ],
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.grey)),
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
