import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/offer_repository.dart';

class OfferService {
  final OfferRepository _repository;

  OfferService(this._repository);

  Future<List<Offer>> getAllOffers() async {
    try {
      final jsonResponse = await _repository.getAll();
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Offer>> getAllRecentsOffers() async {
    try {
      final jsonResponse = await _repository.getAllRecents();
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Offer>> getAllRecentsOffer() async {
    try {
      final jsonResponse = await _repository.getAllRecents();
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Offer> getOfferById(String id) async {
    try {
      final jsonResponse = await _repository.getById(id);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Offer> createNewOffer(Offer offer) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final validityDate = DateTime(
      offer.validade.year,
      offer.validade.month,
      offer.validade.day,
    );
    if (offer.comercioId <= 0 ||
        validityDate.isBefore(today)|| offer.preco <= 0) {
      throw Exception("Dados inválidos para cadastrar oferta!");
    }

    try {
      final jsonResponse = await _repository.create(offer);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Offer> editOffer(Offer offer) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final validityDate = DateTime(
      offer.validade.year,
      offer.validade.month,
      offer.validade.day,
    );
    if (offer.comercioId <= 0 ||
        validityDate.isBefore(today) || offer.preco <= 0) {
      throw Exception("Dados inválidos para cadastrar oferta!");
    }
    try {
      final jsonResponse = await _repository.update(offer);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteOffer(int id) async {
    try {
      await _repository.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}
