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
  void dispose() {
    nome.dispose();
    medida.dispose();
    unidade.dispose();
    categoria.dispose();
    preco.dispose();
    data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // IMAGEM
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.network(
            "https://static.paodeacucar.com/media/uploads/produtos/7891035612702_1.jpg",
            height: 200,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 20),

        // Nome do Produto
        TextField(
          controller: nome,
          decoration: const InputDecoration(
            labelText: "Nome do Produto",
          ),
        ),

        const SizedBox(height: 15),

        // Medida + Unidade
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: medida,
                decoration: const InputDecoration(
                  labelText: "Medida",
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: unidade,
                decoration: const InputDecoration(
                  labelText: "Unidade de Medida",
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // Categoria
        TextField(
          controller: categoria,
          decoration: const InputDecoration(
            labelText: "Categoria do Produto",
          ),
        ),

        const SizedBox(height: 15),

        // Data de postagem
        TextField(
          controller: data,
          decoration: InputDecoration(
            labelText: "Data de Postagem",
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2040),
                  initialDate: DateTime.now(),
                );

                if (picked != null) {
                  data.text = DateFormat("MM/dd/yyyy").format(picked);
                }
              },
            ),
          ),
        ),

        const SizedBox(height: 15),

        // Preço
        TextField(
          controller: preco,
          decoration: const InputDecoration(
            labelText: "Preço",
          ),
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
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {},
            child: const Text(
              "Postar",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
