// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:desconto_direto_comercio_mobile/data/services/commerce_add_service.dart';
import '../../../data/model/commerce_add_model.dart';
import '../../../data/model/commerce_model.dart';

enum CreationStatus { idle, loading, success, error }

class RegisterViewModel extends ChangeNotifier {
  final CommerceAddService? _service;

  CreationStatus _status = CreationStatus.idle;
  String? _errorMessage;
  CommerceModel? _creationRegister;

  RegisterViewModel([this._service]);

  CreationStatus get status => _status;

  String? get errorMessage => _errorMessage;

  CommerceModel? get creationRegister => _creationRegister;

  Future<void> createRegister({
    required String nome,
    required String categoria,
    required String telefone,
    required String email,
    required String senha,
  }) async {
    _status = CreationStatus.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      final data = CommerceAddModel(
        nome: nome,
        categoria: categoria,
        telefone: telefone,
        email: email,
        senha: senha,
      );
      final NewRegister = await _service?.createCommerce(data);
      _creationRegister = NewRegister;
      _status = CreationStatus.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _status = CreationStatus.error;
    } finally {
      notifyListeners();
    }
  }

  void resetStatus() {
    _status = CreationStatus.idle;
    _errorMessage = null;
    _creationRegister = null;
    notifyListeners();
  }
}
