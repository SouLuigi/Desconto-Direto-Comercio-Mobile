import 'package:desconto_direto_comercio_mobile/data/model/commerce_add_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/commerce_add_repository.dart';
import 'package:desconto_direto_comercio_mobile/data/services/commerce_add_service.dart';

void main() async {
  final repository = CommerceAddRepository();
  final service = CommerceAddService(repository);
  final data = CommerceAddModel(
    nome: 'Casa da Ração',
    categoria: 'paiol',
    telefone: '64666666666',
    email: 'casadaracao@gmail.com',
    senha: 'casadaracao123',
  );
  try {
    print('🔄 Cadastrando novo comércio...');
    final commerce = await service.createCommerce(data);
    print('✅ Comércio cadastrado com sucesso: $commerce');
  } catch (e) {
    print('❌ Erro ao enviar os dados e cadastrar o comércio: $e');
  }
}