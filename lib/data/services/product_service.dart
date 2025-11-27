import 'dart:io';

import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/product_repository.dart';

class ProductService {
  final ProductRepository _repository;

  ProductService(this._repository);

  Future<Product> createNewProduct(Product product) async {
    if (product.nome.isEmpty ||
        product.categoria.isEmpty ||
        product.fotoUrl.isEmpty ||
        product.medida.isEmpty ||
        product.unidadeMedida.isEmpty) {
      throw Exception("Dados inválidos para cadastrar produto!");
    }
    try {
      final jsonResponse = await _repository.create(product);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getAllProduct() async {
    try {
      final jsonResponse = await _repository.getAll();
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final jsonResponse = await _repository.getById(id);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> uploadImageOfFlyer(String id, File image) async {
    try {
      await _repository.uploadImage(id, image);
      return true;
    } catch (e) {
      print('Erro ao salvar foto no repository: $e');
      return false;
    }
  }
}
