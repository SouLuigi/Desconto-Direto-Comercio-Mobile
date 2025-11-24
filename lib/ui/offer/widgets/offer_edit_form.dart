import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/model/offer_model.dart';
import '../view_models/offer_viewmodel.dart';

class OfferEditForm extends StatefulWidget {
  final Offer offer;

  const OfferEditForm({
    super.key,
    required this.offer,
  });

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

    nome = TextEditingController(text: widget.offer.product.nome);
    medida = TextEditingController(text: widget.offer.product.medida);
    unidade = TextEditingController(text: widget.offer.product.unidadeMedida);
    categoria = TextEditingController(text: widget.offer.product.categoria);
    preco = TextEditingController(text: widget.offer.preco.toString());
    data = TextEditingController(
        text: DateFormat("MM/dd/yyyy").format(widget.offer.validade));
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.offer.product;

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
            product.fotoUrl,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 80),
          ),
        ),

        const SizedBox(height: 25),

        // ------------------ CAMPOS NÃO EDITÁVEIS ------------------
        _label("Nome do Produto"),
        TextField(
          controller: nome,
          readOnly: true,
          decoration: _decoration(),
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
                    readOnly: true,
                    decoration: _decoration(),
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
                    readOnly: true,
                    decoration: _decoration(),
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
          readOnly: true,
          decoration: _decoration(),
        ),

        const SizedBox(height: 20),

        // ------------------ CAMPOS EDITÁVEIS ------------------

        _label("Data de Validade"),
        TextField(
          controller: data,
          decoration: _decoration().copyWith(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month, color: Colors.orange),
              onPressed: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: widget.offer.validade,
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

        // ------------------ BOTÃO SALVAR ------------------
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
              final updated = Offer(
                id: widget.offer.id,
                validade: DateFormat("MM/dd/yyyy").parse(data.text),
                dataPostagem: widget.offer.dataPostagem,
                comercioId: widget.offer.comercioId,
                likes: widget.offer.likes,
                preco: double.parse(preco.text),
                product: widget.offer.product,
              );

              final ok =
                  await context.read<OfferViewModel>().updateOffer(updated);

              if (ok) Navigator.pop(context);
            },
            child: const Text(
              "Salvar Alterações",
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
