import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_textField.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_datepicker.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/view_models/offer_viewmodel.dart';

class OfferEditForm extends StatefulWidget {
  const OfferEditForm({super.key});

  @override
  State<OfferEditForm> createState() => _OfferEditFormState();
}

class _OfferEditFormState extends State<OfferEditForm> {
  final preco = TextEditingController();
  final data = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Garante que o selectedOffer já existe antes de usar
    Future.microtask(() {
      final vm = context.read<OfferViewModel>();
      final offer = vm.selectedOffer!;

      preco.text = offer.preco.toStringAsFixed(2);
      data.text = DateFormat("MM/dd/yyyy").format(offer.validade);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OfferViewModel>();
    final offer = vm.selectedOffer!;
    final product = offer.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -----------------------------------
        // IMAGEM DO PRODUTO
        // -----------------------------------
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: (product.fotoUrl.isEmpty)
              ? const Icon(Icons.broken_image, size: 80)
              : Image.network(
                  product.fotoUrl,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
        ),

        const SizedBox(height: 25),

        // -----------------------------------
        // CAMPOS NÃO EDITÁVEIS
        // -----------------------------------
        campoNaoEditavel("Nome do Produto", product.nome),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(child: campoNaoEditavel("Medida", product.medida)),
            const SizedBox(width: 15),
            Expanded(child: campoNaoEditavel("Unidade", product.unidadeMedida)),
          ],
        ),
        const SizedBox(height: 15),
        campoNaoEditavel("Categoria", product.categoria),

        const SizedBox(height: 20),

        // -----------------------------------
        // DATE PICKER (EDITÁVEL)
        // -----------------------------------
        CustomDatePicker(
          label: "Validade da Oferta",
          controller: data,
          initialDate: offer.validade,
          onDateSelected: (picked) {
            data.text = DateFormat("MM/dd/yyyy").format(picked);
          },
        ),

        const SizedBox(height: 10),

        // -----------------------------------
        // PREÇO (EDITÁVEL)
        // -----------------------------------
        CustomInput(
          label: "Preço",
          controller: preco,
          keyboardType: TextInputType.number,
          icon: Icons.attach_money,
        ),

        const SizedBox(height: 30),

        // -----------------------------------
        // BOTÃO SALVAR ALTERAÇÃO
        // -----------------------------------
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () async {
              final updatedOffer = _buildUpdatedOffer(offer);

              final ok = await vm.updateOffer(updatedOffer);

              if (ok) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Oferta atualizada com sucesso!"),
                    ),
                  );
                  Navigator.pop(context);
                }
              }
            },
            child: const Text(
              "Salvar Alterações",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  // ------------------------------------------------------------
  // MONTA NOVA OFERTA (mantém tudo, atualiza preço e validade)
  // ------------------------------------------------------------
  Offer _buildUpdatedOffer(Offer old) {
    return Offer(
      id: old.id,
      comercioId: old.comercioId,
      dataPostagem: old.dataPostagem,
      likes: old.likes,
      product: old.product,
      preco: double.parse(preco.text),
      validade: DateFormat("MM/dd/yyyy").parse(data.text),
    );
  }

  // ------------------------------------------------------------
  // WIDGET CAMPO NÃO EDITÁVEL
  // ------------------------------------------------------------
  Widget campoNaoEditavel(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 5),
        AbsorbPointer(
          child: Opacity(
            opacity: 0.75,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
