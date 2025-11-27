import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/view_models/offer_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/offer_edit_form.dart';
import 'package:desconto_direto_comercio_mobile/ui/offer/widgets/widget_appbar_offer.dart';
class OfferEditScreen extends StatelessWidget {
  const OfferEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OfferViewModel>();

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

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        // 🔥 APPBAR COPIADO DA CREATE (IDÊNTICO)
       appBar: const AppBarPadrao(
  titulo: "Editar Oferta",
),

        // BODY
        body: vm.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: const OfferEditForm(),
              ),

        // LOADING (opcional)
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
      ),
    );
  }
}
