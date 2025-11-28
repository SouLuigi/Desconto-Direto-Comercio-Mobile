import 'package:flutter/material.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/services/offer_service.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';

class OfferViewModel extends ChangeNotifier {
  final OfferService service;
  final LocalStorageService storage = LocalStorageService();

  OfferViewModel(this.service);

  // ESTADOS
  final ValueNotifier<bool> loading = ValueNotifier(false);
  String? errorMessage;

  List<Offer> offers = [];
  Offer? selectedOffer;

  // ============================================================
  // SELECIONAR OFERTA PARA EDIÇÃO
  // ============================================================
  void selectOffer(Offer offer) {
    selectedOffer = offer;
    notifyListeners();
  }

  // ============================================================
  // CARREGAR TODAS AS OFERTAS DO COMÉRCIO LOGADO
  // ============================================================
  Future<void> fetchAllOffers() async {
    loading.value = true;
    errorMessage = null;

    try {
      // 1️⃣ Identifica comércio logado
      final token = await storage.getToken();
      if (token == null) throw Exception("Usuário não autenticado.");
      final comercioIdLogado = int.parse(token);

      // 2️⃣ Busca TODAS da API
      final lista = await service.getAllOffers();

      // 3️⃣ Filtra apenas do comércio logado
      offers = lista.where((o) => o.comercioId == comercioIdLogado).toList();

    } catch (e) {
      errorMessage = e.toString();
    }

    loading.value = false;
    notifyListeners();
  }

  // ============================================================
  // CREATE (Comércio já aplicado via token)
  // ============================================================
  Future<bool> createOffer(Offer originalOffer) async {
    loading.value = true;
    errorMessage = null;

    try {
      final token = await storage.getToken();
      if (token == null) throw Exception("Usuário não autenticado.");
      final comercioId = int.parse(token);

      // 🔥 Monta oferta final com comercioId correto
      final newOffer = Offer(
        id: 0,
        comercioId: comercioId,
        dataPostagem: originalOffer.dataPostagem,
        validade: originalOffer.validade,
        likes: 0,
        preco: originalOffer.preco,
        produto: originalOffer.produto,
      );

      await service.createNewOffer(newOffer);

      loading.value = false;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      loading.value = false;
      return false;
    }
  }

  // ============================================================
  // UPDATE
  // ============================================================
  Future<bool> updateOffer(Offer updated) async {
    loading.value = true;
    errorMessage = null;

    try {
      final token = await storage.getToken();
      if (token == null) throw Exception("Usuário não autenticado.");
      final comercioId = int.parse(token);

      // 🔥 Garante que comercioId é o do usuário logado
      final offerToSend = Offer(
        id: updated.id,
        comercioId: comercioId,
        dataPostagem: updated.dataPostagem,
        validade: updated.validade,
        produto: updated.produto,
        likes: updated.likes,
        preco: updated.preco,
      );

      await service.editOffer(offerToSend);

      loading.value = false;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      loading.value = false;
      return false;
    }
  }

  // ============================================================
  // DELETE
  // ============================================================
 Future<bool> deleteOffer(int id) async {
  loading.value = true;
  errorMessage = null;

  try {
    await service.deleteOffer(id);

    // Remove local
    offers.removeWhere((o) => o.id == id);

    // 🔥 Atualiza lista completa da API
    await fetchAllOffers();

    loading.value = false;
    notifyListeners();
    return true;
  } catch (e) {
    errorMessage = e.toString();
    loading.value = false;
    return false;
  }
}

}
