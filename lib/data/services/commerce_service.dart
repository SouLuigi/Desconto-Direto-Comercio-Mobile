
import '../model/register_model.dart';
import '../model/commerce_model.dart';
import '../repositories/commerce_repository.dart';

class RegisterService {
  final RegisterRepository _repository;

  RegisterService(this._repository);

  Future<Commerce> createCommerce(RegisterModel data) async {
    if (data.nome.isEmpty ||
        data.email.isEmpty ||
        !data.email.contains('@') ||
        data.senha.isEmpty) {
      throw Exception('Dados inválidos para registro.');
    }
    try {
      final jsonResponse = await _repository.createCommerce(data);
      return jsonResponse;
    } catch (e) {
      throw Exception(
        'Falha completa ao cadastrar o comércio. Tente novamente. Detalhes: $e',
      );
    }
  }
}
