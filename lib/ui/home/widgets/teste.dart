import 'package:flutter/material.dart';
import 'package:desconto_direto_comercio_mobile/ui/home/widgets/widget_card_offer.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';

class OfferTestPage extends StatelessWidget {
  const OfferTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ===========================
    // FAKE PRODUCTS
    // ===========================
    final product1 = Product(
      id: 1,
      nome: "Detergente Ypê",
      medida: "500",
      unidadeMedida: "ml",
      categoria: "Limpeza",
      fotoUrl:
          "https://mercadosaojoao.vteximg.com.br/arquivos/ids/287640-1000-1000/7896102500789_1.jpg?v=637680804975030000",
    );

    final product2 = Product(
      id: 2,
      nome: "Arroz Tio João",
      medida: "1",
      unidadeMedida: "kg",
      categoria: "Alimentos",
      fotoUrl:
          "https://emporioquatroestrelas.com.br/wp-content/uploads/2021/01/arroz-tio-joao.jpg",
    );

    // ===========================
    // FAKE OFFERS
    // ===========================
    final offers = [
      Offer(
        id: 1,
        validade: DateTime(2025, 12, 10),
        dataPostagem: DateTime(2025, 11, 22),
        comercioId: 1,
        likes: 3,
        produto: product1,
        preco: 3.99,
      ),
      Offer(
        id: 2,
        validade: DateTime(2025, 12, 20),
        dataPostagem: DateTime(2025, 11, 18),
        comercioId: 1,
        likes: 5,
        produto: product2,
        preco: 8.49,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ofertas (Teste UI)"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: offers
              .map((offer) => WidgetCardOffer(offer: offer))
              .toList(),
        ),
      ),
    );
  }
}
