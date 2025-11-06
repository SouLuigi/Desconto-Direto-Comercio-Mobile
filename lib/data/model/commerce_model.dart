class CommerceModel{
  final int id;
  final String nome;
  final String categoria;
  final String telefone;
  final String email;

  CommerceModel({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.telefone,
    required this.email,
});  factory CommerceModel.fromJson(Map<String, dynamic> json){
    return CommerceModel(
      id: json['id'] as int,
      nome: json['nome'] as String,
      categoria: json['categoria'] as String,
      telefone: json['telefone'] as String,
      email: json['email'] as String,
    );
  }
}