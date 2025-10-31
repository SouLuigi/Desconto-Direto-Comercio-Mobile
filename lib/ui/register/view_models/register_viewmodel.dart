// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:desconto_direto_comercio_mobile/data/services/commerce_add_service.dart';
import '../../../data/model/commerce_add_model.dart';
import '../../../data/model/commerce_model.dart';

enum CreationStatus { idle, loading, success, error }

class RegisterViewModel extends ChangeNotifier {
  final CommerceAddService? _service;

  String _nome = '';
  String _categoria = '';
  String _telefone = '';
  String _email = '';
  String _senha = '';
  String _confirmarSenha = '';

  final List<String> _categories = const [
    'Supermercado / Mercearia',
    'Padaria / Confeitaria',
    'Açougue',
    'Peixaria',
    'Lanchonete / Pastelaria',
    'Pizzaria',
    'Oficina Mecânica',
    'Autopeças',
    'Borracharia',
    'Farmácia / Drogaria',
    'Loja de Roupas / Boutique',
    'Loja de Calçados',
    'Salão de Beleza / Barbearia',
    'Pet Shop',
    'Papelaria / Utilidades',
    'Eletrônicos / Informática',
    'Móveis / Decoração',
    'Materiais de Construção',
    'Outros',
  ];
  CreationStatus _status = CreationStatus.idle;
  String? _errorMessage;
  CommerceModel? _creationRegister;

  RegisterViewModel([this._service]);

  String get nome => _nome;

  String get categoria => _categoria;

  String get telefone => _telefone;

  String get email => _email;

  String get senha => _senha;

  String get confirmarSenha => _confirmarSenha;

  List<String> get categories => _categories;

  CreationStatus get status => _status;

  String? get errorMessage => _errorMessage;

  CommerceModel? get creationRegister => _creationRegister;

  void setNome(String value) {
    _nome = value;
  }

  void setCategoria(String value) {
    _categoria = value;
    notifyListeners();
  }

  void setTelefone(String value) {
    _telefone = value;
  }

  void setEmail(String value) {
    _email = value;
  }

  void setSenha(String value) {
    _senha = value;
  }

  void setConfirmarSenha(String value) {
    _confirmarSenha = value;
  }

  bool isFormValid() {
    return _nome.isNotEmpty &&
        _categoria.isNotEmpty &&
        _telefone.isNotEmpty &&
        _email.isNotEmpty &&
        _senha.isNotEmpty &&
        _senha == _confirmarSenha;
  }
  Future<void> createRegister() async {

    print('ViewModel vai enviar dados:');
    print('Nome: $_nome');
    print('Categoria: $_categoria');

    _status = CreationStatus.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      final data = CommerceAddModel(
        nome: _nome,
        categoria: _categoria,
        telefone: _telefone,
        email: _email,
        senha: _senha,
      );
      final newRegister = await _service?.createCommerce(data);
      _creationRegister = newRegister;
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
