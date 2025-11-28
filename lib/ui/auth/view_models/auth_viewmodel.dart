import 'package:flutter/foundation.dart';

import '../../../data/model/commerce_model.dart';
import '../../../data/repositories/commerce_repository.dart';
import '../../../data/services/commerce_service.dart';
import '../../../data/services/flutter_secure_storage.dart';

class AuthViewModel extends ChangeNotifier {
  final LocalStorageService _localStorageService;
  final CommerceRepository _commerceRepository;

  AuthViewModel(this._localStorageService, this._commerceRepository);

  late final CommerceService _service = CommerceService(
    _commerceRepository,
    _localStorageService,
  );

  bool _isLoading = false;
  String? _errorMessage;
  String? _token; // NÃO é late final!
  Commerce? _currentCommerce;

  bool get isLoading => _isLoading;

  bool get isAuthenticated => _currentCommerce != null;

  String? get errorMessage => _errorMessage;

  Commerce? get currentCommerce => _currentCommerce;

  // ------------------------------ CHECK LOGIN ----------------------------------

  Future<void> checkAuthenticationStatus() async {
    _token = await _localStorageService.getToken();

    if (_token == null) return;

    _setLoading(true);

    try {
      final commerce = await _service.getCommerceById(_token!);
      _currentCommerce = commerce;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = _cleanError(e);
      _currentCommerce = null;
    } finally {
      _setLoading(false);
    }
  }

  // ------------------------------ LOGIN ----------------------------------

  Future<void> login({required String email, required String senha}) async {
    _setLoading(true);
    print(email + senha);
    _errorMessage = null;

    try {
      _currentCommerce = await _service.login(email, senha);
    } catch (e) {
      _errorMessage = _cleanError(e);
      _currentCommerce = null;
    } finally {
      _setLoading(false);
    }
  }

  // ------------------------------ HELPERS ----------------------------------

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _cleanError(Object e) {
    return e.toString().replaceAll('Exception: ', '');
  }

  void resetStatus() {
    _errorMessage = null;
    notifyListeners();
  }
}
