import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';

class Offer {
  final int id;
  final DateTime validade;
  final DateTime dataPostagem;
  final int comercioId;
  final int likes;
  final Product product;

  Offer({
    required this.id,
    required this.validade,
    required this.dataPostagem,
    required this.comercioId,
    required this.likes,
    required this.product,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as int,
      validade: DateTime.parse(json['validade'] as String),
      dataPostagem: DateTime.parse(json['dataPostagem'] as String),
      comercioId: json['comercioId'] as int,
      likes: json['likes'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'validade': validade.toIso8601String(),
      'dataPostagem': dataPostagem.toIso8601String(),
      'comercioId': comercioId,
      'likes': likes,
      'product': product.toJson(),
    };
  }
}