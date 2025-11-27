import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import '../view_models/offer_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_textField.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_dropdown.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_datepicker.dart';

// NOVO IMPORT
import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/widget_campo_nao_editavel.dart';

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

        // ------------------ CAMPOS NÃO EDITÁVEIS (ATUALIZADOS) ------------------
        if (produtoSelecionado != null) ...[
          CampoNaoEditavel(
            label: "Nome do Produto",
            value: nome.text,
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: CampoNaoEditavel(
                  label: "Medida",
                  value: medida.text,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CampoNaoEditavel(
                  label: "Unidade de Medida",
                  value: unidade.text,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          CampoNaoEditavel(
            label: "Categoria do Produto",
            value: categoria.text,
          ),

          const SizedBox(height: 20),
        ],

        // ------------------ DATA ------------------
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
      preco: double.parse(preco.text.replaceAll(',', '.')),
      produto: p,
    );
  }
}
