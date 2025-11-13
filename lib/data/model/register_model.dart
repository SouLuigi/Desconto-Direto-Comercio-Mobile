class RegisterModel {
  final String nome;
  final String categoria;
  final String telefone;
  final String email;
  final String senha;

  RegisterModel({
    required this.nome,
    required this.categoria,
    required this.telefone,
    required this.email,
    required this.senha,
  });
  
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      nome: json['nome'],
      categoria: json['categoria'],
      telefone: json['telefone'],
      email: json['email'],
      senha: json['senha'],
    );
  }
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
