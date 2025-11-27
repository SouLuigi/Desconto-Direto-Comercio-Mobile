import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/view_models/offer_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/offer_edit_form.dart';

class OfferEditScreen extends StatelessWidget {
  const OfferEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OfferViewModel>();

    // ------------------------------------------
    // 1. Offer NÃO selecionada → ERRO DE FLUXO
    // ------------------------------------------
    if (vm.selectedOffer == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Nenhuma oferta selecionada para edição.",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    // ------------------------------------------
    // 2. Tela principal
    // ------------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Oferta"),
        backgroundColor: Colors.orange,
        elevation: 2,
      ),

      body: vm.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: const OfferEditForm(),
            ),

      // ------------------------------------------
      // 3. Loader global para UpdateOffer()
      // ------------------------------------------
      floatingActionButton: vm.isLoading
          ? FloatingActionButton(
              backgroundColor: Colors.orange,
              onPressed: () {},
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
