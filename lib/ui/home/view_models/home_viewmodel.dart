import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/commerce_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/model/commerce_model.dart';
import '../../../data/services/commerce_service.dart';
import '../../../data/services/flutter_secure_storage.dart';

class HomeViewmodel extends ChangeNotifier {
  final _repository = CommerceRepository();
  final _localStorage = LocalStorageService();

  late final CommerceService _service = CommerceService(
    _repository,
    _localStorage,
  );
  List<Offer> _offers = [];
  String? _errorMessage;
  bool _isLoading = false;
  Commerce? _commerce;
  late final token = _localStorage.getToken();

  List<Offer> get offers => _offers;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  Commerce? get commerce => _commerce;

  Future<void> loadOffers() async {
    _setLoading(true);
    try {
      final fetchedOffer = await _service.getOffersByIdCommerce('2');
      print("Fetched Offer: ${fetchedOffer?.length}");
      _offers = fetchedOffer!;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Erro ao carregar dados: $e";
      _offers = [];
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
