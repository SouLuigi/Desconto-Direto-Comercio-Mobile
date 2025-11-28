import 'package:flutter/foundation.dart';

import '../../../data/model/commerce_model.dart';
import '../../../data/repositories/commerce_repository.dart';
import '../../../data/services/commerce_service.dart';
import '../../../data/services/flutter_secure_storage.dart';

class AuthViewModel extends ChangeNotifier {
  late final LocalStorageService _localStorageService;
  late final CommerceRepository _commerceRepository;
  late final CommerceService _service = CommerceService(
    _commerceRepository,
    _localStorageService,
  );

  bool _isLoading = false;
  String? _errorMessage;

  Commerce? _currentCommerce;

  bool get isLoading => _isLoading;

  bool get isAuthenticated => _currentCommerce != null;

  String? get errorMessage => _errorMessage;

  Commerce? get currentCommerce => _currentCommerce;

  AuthViewModel(this._localStorageService, this._commerceRepository);

  Future<void> checkAuthenticationStatus() async {
    final token = await _service.localStorage.getToken();
    if (token != null) {
      _setLoginStatus(true);
      try {
        final commerce = await _service.getCommerceById(token);
        _currentCommerce = commerce;
      }
      catch (e) {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      }
      finally {
        _setLoginStatus(true);
      }
      notifyListeners();
    }
  }

  Future<void> login({required String email, required String password}) async {
    _setLoginStatus(true);
    try {
      final commerce = await _service.login(email, password);
      _currentCommerce = commerce;
      _setLoginStatus(true);
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoginStatus(true);
    }
  }

  void _setLoginStatus(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void resetStatus() {
    _isLoading = false;
    _errorMessage = '';
    notifyListeners();
  }
}
