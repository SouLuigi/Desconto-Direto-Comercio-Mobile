import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/view_models/offer_viewmodel.dart';

import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/widget_appbar_offer.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/widget_campo_nao_editavel.dart';

import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_textField.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_datepicker.dart';

class OfferEditScreen extends StatefulWidget {
  const OfferEditScreen({super.key});

  @override
  State<OfferEditScreen> createState() => _OfferEditScreenState();
}

class _OfferEditScreenState extends State<OfferEditScreen> {
  final preco = TextEditingController();
  final data = TextEditingController();

  @override
  void initState() {
    super.initState();

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
    final product = offer.produto;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: const AppBarPadrao(
          titulo: "Editar Oferta",
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ============================
              // IMAGEM
              // ============================
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
                      ),
              ),

              const SizedBox(height: 25),

              // ============================
              // CAMPOS NÃO EDITÁVEIS
              // ============================
              CampoNaoEditavel(label: "Nome do Produto", value: product.nome),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: CampoNaoEditavel(
                      label: "Medida",
                      value: product.medida,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CampoNaoEditavel(
                      label: "Unidade",
                      value: product.unidadeMedida,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              CampoNaoEditavel(
                label: "Categoria",
                value: product.categoria,
              ),

              const SizedBox(height: 20),

              // ============================
              // DATE PICKER
              // ============================
              CustomDatePicker(
                label: "Validade",
                controller: data,
                initialDate: offer.validade,
                onDateSelected: (picked) {
                  data.text = DateFormat("MM/dd/yyyy").format(picked);
                },
              ),

              const SizedBox(height: 15),

              // ============================
              // PREÇO EDITÁVEL
              // ============================
              CustomInput(
                label: "Preço",
                controller: preco,
                keyboardType: TextInputType.number,
                icon: Icons.attach_money,
              ),

              const SizedBox(height: 30),

              // ============================
              // BOTÃO SALVAR ALTERAÇÕES
              // ============================
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
                    debugPrint(">>> [DEBUG] Botão SALVAR clicado");

                    final offerFinal = _montarOfertaAtualizada(offer);

                    final ok = await vm.updateOffer(offerFinal);
                    debugPrint(">>> [DEBUG] Resultado updateOffer: $ok");

                    if (!ok) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            vm.errorMessage ?? "Erro ao atualizar oferta.",
                          ),
                        ),
                      );
                      return;
                    }

                    if (mounted) Navigator.pop(context);
                  },
                  child: const Text(
                    "Salvar Alterações",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // RECONSTRÓI A OFERTA (SEM copyWith!)
  // ================================================================
  Offer _montarOfertaAtualizada(Offer old) {
    return Offer(
      id: old.id,
      produto: old.produto,
      dataPostagem: old.dataPostagem,
      likes: old.likes,
      comercioId: old.comercioId, // sobrescrito no VM!
      preco: double.parse(preco.text.replaceAll(',', '.')),
      validade: DateFormat("MM/dd/yyyy").parse(data.text),
    );
  }
}
