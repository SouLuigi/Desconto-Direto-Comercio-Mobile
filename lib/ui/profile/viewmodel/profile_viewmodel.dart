import 'dart:io';

import 'package:desconto_direto_comercio_mobile/data/model/commerce_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/commerce_repository.dart';
import 'package:desconto_direto_comercio_mobile/data/services/commerce_service.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

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
  String? _token;
  File? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  // Getters
  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Commerce? get commerce => _commerce;

  File? get selectedImageFile => _selectedImageFile;



  Future<void> loadCommerce() async {
    _setLoading(true);
    _token= await _localStorage.getToken();
    try {
      _commerce = await _service.getCommerceById(_token!);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Erro ao carregar dados: $e";
      _commerce = null;
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile == null) return;

      _selectedImageFile = File(pickedFile.path);
      notifyListeners();

      await _uploadImageLogic();
    } catch (e) {
      _errorMessage = "Erro ao selecionar imagem: $e";
      _selectedImageFile = null;
      notifyListeners();
    }
  }

  // Função interna para organizar o upload
  Future<void> _uploadImageLogic() async {
    if (_selectedImageFile == null) return;

    _setLoading(true);
    try {
      await _service.uploadImageOfCommerce(_token!, _selectedImageFile!);

      await loadCommerce();

      _selectedImageFile = null;
    } catch (e) {
      _errorMessage = "Falha no upload da imagem: $e";
      print(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteAccount() async {
    _setLoading(true);
    try {
      await _service.deleteCommerce(_token!);
    } catch (e) {
      _errorMessage = "Erro ao deletar conta";
      print(e);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
