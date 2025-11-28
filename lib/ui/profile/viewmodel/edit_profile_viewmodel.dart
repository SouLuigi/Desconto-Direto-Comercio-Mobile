import 'dart:io';

import 'package:desconto_direto_comercio_mobile/data/model/commerce_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/commerce_repository.dart';
import 'package:desconto_direto_comercio_mobile/data/services/commerce_service.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileViewModel extends ChangeNotifier {
  final _repository = CommerceRepository();
  final _localStorage = LocalStorageService();

  late final CommerceService _service = CommerceService(
    _repository,
    _localStorage,
  );

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
  final List<String> _delivery = const ['Sim', 'Não'];

  bool _isLoading = false;
  String? _errorMessage;
  Commerce? _commerce;
  late final String? _token;


  File? _selectedImageFile;

  File? get selectedImageFile => _selectedImageFile;

  final ImagePicker _picker = ImagePicker();

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Commerce? get commerce => _commerce;

  List<String> get categories => _categories;

  List<String> get delivery => _delivery;

  Future<void> loadCommerce() async {
    _setLoading(true);
    _token = await _localStorage.getToken();
    try {
      _commerce = await _service.getCommerceById(_token!);
      print(_commerce);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Erro ao carregar dados: $e";
      _commerce = null;
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateCommerce(Commerce commerce) async {
    try {
      _setLoading(true);
      _errorMessage = null;
      notifyListeners();

      print("Enviando: ${commerce.toJson()}");

      await _service.editCommerce(commerce);
    } catch (e) {
      print("Erro no update: $e");
      _errorMessage = "Falha ao atualizar dados. Verifique sua conexão.";
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
