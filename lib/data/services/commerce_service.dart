import 'package:desconto_direto_comercio_mobile/data/model/login_model.dart';

import '../model/register_model.dart';
import '../model/commerce_model.dart';
import '../repositories/commerce_repository.dart';

class RegisterService {
  final RegisterRepository _repository;

  RegisterService(this._repository);

  Future<Commerce> createCommerce(RegisterModel data) async {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (data.nome.isEmpty ||
        data.email.isEmpty ||
        !emailRegex.hasMatch(data.email) ||
        data.senha.isEmpty) {
      throw Exception('Dados inválidos para registro.');
    }
    try {
      final jsonResponse = await _repository.create(data);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Commerce> login(LoginModel data) async {
    if (data.email.isEmpty || data.senha.isEmpty) {
      throw Exception('E-mail e senha são obrigatórios.');
    }
    try {
      final List<Commerce> allCommerces = await _repository.getAll();
      final commerceLogin = allCommerces.firstWhere(
        (commerce) =>
            commerce.email == data.email && commerce.senha == data.senha,
        orElse: () => throw Exception("Email ou senhas incorretos!"),
      );
      return commerceLogin;
    } catch (e) {
      rethrow;
    }
  }
}
