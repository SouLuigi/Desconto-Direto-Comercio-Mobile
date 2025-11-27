import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import '../view_models/offer_viewmodel.dart';

// Widgets customizados
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_textField.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_dropdown.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_datepicker.dart';


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
  String? produtoSelecionadoNome;

  final nome = TextEditingController();
  final medida = TextEditingController();
  final unidade = TextEditingController();
  final categoria = TextEditingController();
  final preco = TextEditingController();
  final data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nomesProdutos = widget.produtos.map((p) => p.nome).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------ PRODUTOS (CustomDropdown) ------------------
        CustomDropdown(
          label: "Selecione o Produto",
          items: nomesProdutos,
          value: produtoSelecionadoNome,
          icon: Icons.shopping_bag,
          onChanged: (value) {
            setState(() {
              produtoSelecionadoNome = value;
              produtoSelecionado =
                  widget.produtos.firstWhere((p) => p.nome == value);

              nome.text = produtoSelecionado!.nome;
              medida.text = produtoSelecionado!.medida;
              unidade.text = produtoSelecionado!.unidadeMedida;
              categoria.text = produtoSelecionado!.categoria;
            });
          },
        ),

        const SizedBox(height: 25),

        // ------------------ IMAGEM DO PRODUTO ------------------
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: (produtoSelecionado == null ||
                  produtoSelecionado!.fotoUrl.isEmpty)
              ? const Icon(Icons.broken_image, size: 80)
              : Image.network(
                  produtoSelecionado!.fotoUrl,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
        ),

        const SizedBox(height: 25),

        // ------------------ CAMPOS NÃO EDITÁVEIS ------------------
        campoNaoEditavelCustom("Nome do Produto", nome),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(child: campoNaoEditavelCustom("Medida", medida)),
            const SizedBox(width: 15),
            Expanded(child: campoNaoEditavelCustom("Unidade de Medida", unidade)),
          ],
        ),

        const SizedBox(height: 20),

        campoNaoEditavelCustom("Categoria do Produto", categoria),

        const SizedBox(height: 20),

        // ------------------ DATA (CustomDatePicker) ------------------
        CustomDatePicker(
          label: "Data de Postagem",
          controller: data,
          initialDate: DateTime.now(),
          onDateSelected: (picked) {
            data.text = DateFormat("MM/dd/yyyy").format(picked);
            setState(() {});
          },
        ),

        const SizedBox(height: 10),

        // ------------------ PREÇO ------------------
        CustomInput(
          label: "Preço",
          controller: preco,
          keyboardType: TextInputType.number,
          hint: "Ex: 8.90",
          icon: Icons.attach_money,
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
                    content: Text("Selecione um produto antes de postar."),
                  ),
                );
                return;
              }

              final ok = await context.read<OfferViewModel>().createOffer(
                    _montarOferta(produtoSelecionado!),
                  );

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

  Offer _montarOferta(Product p) {
    return Offer(
      id: 0,
      validade: DateFormat("MM/dd/yyyy").parse(data.text),
      dataPostagem: DateTime.now(),
      comercioId: 1,
      likes: 0,
      preco: double.parse(preco.text),
      produto: p,
    );
  }

  /// Campo NÃO editável usando CustomInput + bloqueio
  Widget campoNaoEditavelCustom(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        AbsorbPointer(
          child: Opacity(
            opacity: 0.75,
            child: CustomInput(
              label: label,
              controller: controller,
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
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
