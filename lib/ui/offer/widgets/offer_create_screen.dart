import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/offer_service.dart';
import '../../../data/repositories/offer_repository.dart';
import '../../../data/services/product_service.dart';
import '../../../data/repositories/product_repository.dart';

import 'offer_create_form.dart';
import '../view_models/offer_viewmodel.dart';
import '../../../data/model/product_model.dart';

import 'widget_appbar_offer.dart';

class OfferCreateScreen extends StatefulWidget {
  const OfferCreateScreen({super.key});

  @override
  State<OfferCreateScreen> createState() => _OfferCreateScreenState();
}

class _OfferCreateScreenState extends State<OfferCreateScreen> {
  bool loading = true;
  List<Product> produtos = [];

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
  final productService = ProductService(ProductRepository());

  try {
    final lista = await productService.getAll();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => OfferViewModel(OfferService(OfferRepository())),
        child: Scaffold(
          backgroundColor: Colors.white,

          appBar: const AppBarPadrao(titulo: "Criar Oferta"),

          body: loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: OfferCreateForm(produtos: produtos),
                ),
        ),
      ),
    );
  }
}
