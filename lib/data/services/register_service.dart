// Dart imports:

// Package imports:

// Project imports:
import '../model/register_model.dart';
import '../model/commerce_model.dart';
import '../repositories/register_repository.dart';

class RegisterService {
  final RegisterRepository _repository;

  RegisterService(this._repository);

  Future<CommerceModel> createCommerce(RegisterModel data) async {
    // 1. **(Regra de Negócio Aqui)** Ex: if (data.name == null) throw Exception('Nome obrigatório');

    try {
      // 2. Chama o Repository para acessar a API
      final jsonResponse = await _repository.sendCreationRequest(data);

      // 3. Converte o JSON em Model de Negócio
      return CommerceModel.fromJson(jsonResponse);
    } catch (e) {
      // 4. Trata ou re-lança exceções para a camada de UI
      throw Exception(
        'Falha completa ao cadastrar o comércio. Tente novamente. Detalhes: $e',
      );
    }
  }
}
