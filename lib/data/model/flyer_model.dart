class Flyer {
  final int id;
  final String fotoUrl;
  final DateTime dataExpiracao;
  final int comercioId;

  Flyer({
    required this.id,
    required this.fotoUrl,
    required this.dataExpiracao,
    required this.comercioId,
  });

  factory Flyer.fromJson(Map<String, dynamic> json) {
    return Flyer(
      id: json['id'] as int,
      fotoUrl: json['fotoUrl'] as String,
      dataExpiracao: DateTime.parse(json['dataExpiracao'] as String),
      comercioId: json['comercioId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fotoUrl': fotoUrl,
      'dataExpiracao': dataExpiracao.toIso8601String(),
      'comercioId': comercioId,
    };
  }
}
