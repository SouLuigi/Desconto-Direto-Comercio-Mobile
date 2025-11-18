import 'dart:io';

import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';

import '../model/commerce_model.dart';
import '../model/register_model.dart';
import '../repositories/commerce_repository.dart';

class CommerceService {
  final CommerceRepository _repository;
  final LocalStorageService _localStorage;

  CommerceService(this._repository, this._localStorage);

  Future<Commerce> createCommerce(RegisterModel data) async {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (data.nome.isEmpty ||
        data.email.isEmpty ||
        !emailRegex.hasMatch(data.email) ||
        data.categoria.isEmpty ||
        data.senha.isEmpty) {
      throw Exception('Dados inválidos para registro.');
    }
    try {
      return await _repository.create(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Commerce> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('E-mail e senha são obrigatórios.');
    }
    try {
      final commerce = await _repository.login(email, password);
      await _localStorage.saveToken(commerce.id.toString());
      return commerce;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _localStorage.deleteToken();
  }

  Future<List<Commerce>> getAllCommerces() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<Commerce> getCommerceById(int id) async {
    try {
      return await _repository.getById(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<Offer?> getOffersByIdCommerce(int id) async {
    try {
      final jsonResponse = await _repository.getById(id);
      return jsonResponse.offer;
    } catch (e) {
      rethrow;
    }
  }

  Future<Flyer?> getFlyersByIdCommerce(int id) async {
    try {
      final jsonResponse = await _repository.getById(id);
      return jsonResponse.flyer;
    } catch (e) {
      rethrow;
    }
  }

  Future<Commerce> editCommerce(Commerce commerce) async {
    if (commerce.categoria.isEmpty || commerce.nome.isEmpty) {
      throw Exception("Nome e categoria são dados obrigatórios");
    }
    try {
      return await _repository.update(commerce);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCommerce(int id) async {
    try {
      return await _repository.delete(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> uploadImageOfCommerce(int id, File image) async {
    try {
      await _repository.uploadImage(id, image);
      return true;
    } catch (e) {
      print('Erro ao salvar foto no repository: $e');
      return false;
    }
  }
}

