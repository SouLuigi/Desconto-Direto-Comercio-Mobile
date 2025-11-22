import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/offer_model.dart';
import '../../../data/services/offer_service.dart';
import '../view_models/offer_viewmodel.dart';
import 'offer_edit_screen.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OfferViewModel(context.read<OfferService>())
        ..fetchAllOffers(),

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            "Ofertas",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),

        body: Consumer<OfferViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage != null) {
              return Center(
                child: Text(
                  "Erro: ${viewModel.errorMessage}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (viewModel.offers.isEmpty) {
              return const Center(
                child: Text(
                  "Nenhuma oferta encontrada",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: viewModel.offers.length,
              itemBuilder: (context, index) {
                final offer = viewModel.offers[index];

                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Image.network(
                      offer.product.fotoUrl,
                      width: 55,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(offer.product.nome),
                    subtitle: Text("R\$ ${offer.preco.toStringAsFixed(2)}"),

                    // 👉 EDITAR
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OfferEditScreen(offer: offer),
                        ),
                      );
                    },

                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final ok = await viewModel.deleteOffer(offer.id.toString());

                        if (ok) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Oferta removida com sucesso!"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Erro ao remover oferta"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
