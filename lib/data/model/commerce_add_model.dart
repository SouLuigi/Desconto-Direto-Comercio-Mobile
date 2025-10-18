class CommerceAddModel {
  final String nome;
  final String categoria;
  final String telefone;
  final String email;
  final String senha;

  CommerceAddModel({
    required this.nome,
    required this.categoria,
    required this.telefone,
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'categoria': categoria,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };
  }
}
