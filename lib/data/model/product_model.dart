class Product {
  final int id;
  final String nome;
  final String medida;
  final String unidadeMedida;
  final String fotoUrl;
  final String categoria;

  Product({
    required this.id,
    required this.nome,
    required this.medida,
    required this.unidadeMedida,
    required this.fotoUrl,
    required this.categoria,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      nome: json['nome']?.toString() ?? '',
      medida: json['medida']?.toString() ?? '',
      unidadeMedida: json['unidadeMedida']?.toString() ?? '',
      fotoUrl: json['fotoUrl']?.toString() ?? '',
      categoria: json['categoria']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'medida': medida,
    'unidadeMedida': unidadeMedida,
    'fotoUrl': fotoUrl,
    'categoria': categoria,
  };
}
