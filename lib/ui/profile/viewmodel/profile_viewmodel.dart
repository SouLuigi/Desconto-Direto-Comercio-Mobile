import 'package:desconto_direto_comercio_mobile/data/model/commerce_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/commerce_repository.dart';
import 'package:desconto_direto_comercio_mobile/data/services/commerce_service.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends ChangeNotifier {
  final _repository = CommerceRepository();
  final _localStorage = LocalStorageService();

  late final CommerceService _service = CommerceService(
    _repository,
    _localStorage,
  );

  bool _isLoading = false;
  String? _errorMessage;
  Commerce? _commerce;
  late final token = _localStorage.getToken();

  // Getters
  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Commerce? get commerce => _commerce;

  Future<void> loadCommerce() async {
    _setLoading(true);
    try {
      final resultado = await _service.getCommerceById("2");

      _commerce = resultado;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Erro ao carregar dados: $e";
      _commerce = null;
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteAccount() async {
    await _service.deleteCommerce('2');
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Avisa a tela para redesenhar
  }
}
