import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/model/offer_model.dart';
import '../../offer/view_models/offer_viewmodel.dart';

class OfferEditForm extends StatefulWidget {
  final Offer offer;

  const OfferEditForm({super.key, required this.offer});

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
      text: DateFormat('MM/dd/yyyy').format(widget.offer.validade),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OfferViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔶 IMAGEM DO PRODUTO
        Center(
          child: Container(
            height: 230,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              widget.offer.product.fotoUrl,
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
            ),
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

        _label("Categoria"),
        TextField(controller: categoria, decoration: _decoration()),

        const SizedBox(height: 20),

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

        // BOTÃO SALVAR
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              final alteredOffer = Offer(
                id: widget.offer.id,
                comercioId: widget.offer.comercioId,
                likes: widget.offer.likes,
                dataPostagem: widget.offer.dataPostagem,
                validade: DateFormat('MM/dd/yyyy').parse(data.text),
                preco: double.tryParse(preco.text) ?? widget.offer.preco,
                product: widget.offer.product, // ← NÃO EDITA PRODUTO
              );

              final success = await vm.updateOffer(alteredOffer);

              if (success && mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Oferta atualizada com sucesso")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: vm.isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text("Salvar", style: TextStyle(fontSize: 18)),
          ),
        ),
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
