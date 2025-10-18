import 'dart:convert';
import 'package:desconto_direto_comercio_mobile/data/repositories/commerce_add_repository.dart';
import 'package:http/http.dart' as http;
import '../model/commerce_add_model.dart';
import '../model/commerce_model.dart';

class CommerceAddService {
  final CommerceAddRepository _repository;

  CommerceAddService(this._repository);

  Future<CommerceModel> createCommerce(CommerceAddModel data) async {
    // 1. **(Regra de Negócio Aqui)** Ex: if (data.name == null) throw Exception('Nome obrigatório');

    try {
      // 2. Chama o Repository para acessar a API
      final jsonResponse = await _repository.sendCreationRequest(data);

      // 3. Converte o JSON em Model de Negócio
     return CommerceModel.fromJson(jsonResponse);
    } catch (e) {
      // 4. Trata ou re-lança exceções para a camada de UI
      throw Exception('Falha completa ao cadastrar o comércio. Tente novamente. Detalhes: $e');
    }
  }
}