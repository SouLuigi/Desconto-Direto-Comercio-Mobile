import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import'package:desconto_direto_comercio_mobile/ui/offer/view_models/offer_viewmodel.dart';
class OfferCreateForm extends StatefulWidget {
  final List<Product> produtos;

  const OfferCreateForm({
    super.key,
    required this.produtos,
  });

  @override
  State<OfferCreateForm> createState() => _OfferCreateFormState();
}

class _OfferCreateFormState extends State<OfferCreateForm> {
  Product? produtoSelecionado;

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
        // ------------------ DROPDOWN PRODUTOS ------------------
        _label("Selecione o Produto"),
        DropdownButtonFormField<Product>(
          value: produtoSelecionado,
          items: widget.produtos.map((p) {
            return DropdownMenuItem<Product>(
              value: p,
              child: Text(p.nome),
            );
          }).toList(),
          decoration: _decoration(),
          onChanged: (p) {
            setState(() {
              produtoSelecionado = p;

              nome.text = p!.nome;
              medida.text = p.medida;
              unidade.text = p.unidadeMedida;
              categoria.text = p.categoria;
            });
          },
        ),

        const SizedBox(height: 25),

        // ------------------ IMAGEM DO PRODUTO ------------------
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: produtoSelecionado == null
              ? const Text(
                  "Selecione um produto",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              : Image.network(
                  produtoSelecionado!.fotoUrl,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
        ),

        const SizedBox(height: 25),

        // ------------------ CAMPOS ------------------
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

        _label("Data de Postagem"),
        TextField(
          controller: data,
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
          decoration: _decoration(),
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 30),

        // ------------------ BOTÃO POSTAR ------------------
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
            onPressed: () async {
              if (produtoSelecionado == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Selecione um produto antes de postar.")),
                );
                return;
              }

              final offer = Offer(
                id: 0,
                validade: DateFormat("MM/dd/yyyy").parse(data.text),
                dataPostagem: DateTime.now(),
                comercioId: 1,
                likes: 0,
                preco: double.parse(preco.text),
                product: produtoSelecionado!,
              );

              final ok =
                  await context.read<OfferViewModel>().createOffer(offer);

              if (ok) Navigator.pop(context);
            },
            child: const Text(
              "Postar",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------ HELPERS ------------------
  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
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
