import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'offer_create_form.dart';
import '../../../data/services/offer_service.dart';
import '../../../data/services/product_service.dart';
import '../../../data/repositories/offer_repository.dart';
import '../../../data/repositories/product_repository.dart';
import '../view_models/offer_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';

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
      final lista = await productService.getAllProduct(); 
      // use o nome exato do seu método (getAllProducts, getAll, etc.)

      setState(() {
        produtos = lista;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF003049),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Criar Oferta",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),

        body: loading
            ? const Center(child: CircularProgressIndicator())
            : ChangeNotifierProvider(
                create: (_) =>
                    OfferViewModel(OfferService(OfferRepository())),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: OfferCreateForm(produtos: produtos),
                ),
              ),
      ),
    );
  }
}
