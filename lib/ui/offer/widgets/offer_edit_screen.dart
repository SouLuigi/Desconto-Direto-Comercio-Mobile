import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/model/offer_model.dart';
import '../../../data/services/offer_service.dart';
import '../view_models/offer_viewmodel.dart';
import 'offer_edit_form.dart';

class OfferEditScreen extends StatelessWidget {
  final Offer offer;

  const OfferEditScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OfferViewModel(context.read<OfferService>()),

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            "Editar Oferta",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: OfferEditForm(
              offer: offer,         // ✔ A OFERTA QUE VAI SER EDITADA
            ),
          ),
        ),
      ),
    );
  }
}
