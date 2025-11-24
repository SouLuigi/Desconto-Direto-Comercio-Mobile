import 'package:flutter/material.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/services/offer_service.dart';

class OfferViewModel extends ChangeNotifier {
  final OfferService _service;

  OfferViewModel(this._service);

  bool isLoading = false;
  String? errorMessage;

  List<Offer> offers = [];
  Offer? selectedOffer;

  // ----------------------------
  // SELECIONAR OFERTA PARA EDIÇÃO
  // ----------------------------
  void selectOffer(Offer offer) {
    selectedOffer = offer;
    notifyListeners();
  }

  // ----------------------------
  // GET ALL OFFERS
  // ----------------------------
  Future<void> fetchAllOffers() async {
    try {
      isLoading = true;
      notifyListeners();

      offers = await _service.getAllOffers();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ----------------------------
  // GET OFFER BY ID  (ainda funciona caso precise)
  // ----------------------------
  Future<void> fetchOfferById(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      selectedOffer = await _service.getOfferById(id);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // ----------------------------
  // CREATE OFFER
  // ----------------------------
  Future<bool> createOffer(Offer offer) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.createNewOffer(offer);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ----------------------------
  // EDIT OFFER
  // ----------------------------
  Future<bool> updateOffer(Offer offer) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.editOffer(offer);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // ----------------------------
  // DELETE OFFER
  // ----------------------------
  Future<bool> deleteOffer(String id) async {
    try {
      isLoading = true;
      notifyListeners();

      await _service.deleteOffer(id);

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
