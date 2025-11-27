import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';

class Commerce {
  final int id;
  final String nome;
  final String categoria;
  final String? telefone;
  final String email;
  final String senha;
  final String? dataPostagem;
  final String? telefoneCelular;
  final String? instagram;
  final String? bairro;
  final String? cep;
  final bool? fazEntrega;
  final DateTime? horarioAbertura;
  final DateTime? horarioFechamento;
  final bool? aberto;
  final String? fotoUrl;
  final String? endereco;
  final List<Offer>? ofertas;
  final List<Flyer>? panfletos;

  Commerce({
    required this.id,
    required this.nome,
    required this.categoria,
    this.telefone,
    required this.email,
    required this.senha,
    this.dataPostagem,
    this.telefoneCelular,
    this.instagram,
    this.bairro,
    this.cep,
    this.fazEntrega,
    this.horarioAbertura,
    this.horarioFechamento,
    this.aberto,
    this.fotoUrl,
    this.ofertas,
    this.panfletos,
    this.endereco,
  });

  factory Commerce.fromJson(Map<String, dynamic> json) {
    return Commerce(
      id: json['id'] as int,
      nome: json['nome'] as String,
      categoria: json['categoria'] as String,
      telefone: json['telefone'] as String,
      email: json['email'] as String,
      senha: json['senha'] as String,
      telefoneCelular: json['telefoneCelular'] as String?,
      instagram: json['instagram'] as String?,
      bairro: json['bairro'] as String?,
      cep: json['cep'] as String?,
      fazEntrega: json['fazEntrega'] as bool?,
      horarioAbertura: json['horarioAbertura'] != null
          ? DateTime.parse("2025-01-01 ${json['horarioAbertura']}")
          : null,

      horarioFechamento: json['horarioFechamento'] != null
          ? DateTime.parse("2025-01-01 ${json['horarioFechamento']}")
          : null,
      aberto: json['aberto'] as bool?,
      fotoUrl: json['fotoUrl'] as String?,
      ofertas: json['ofertas'] != null
          ? (json['ofertas'] as List).map((i) => Offer.fromJson(i)).toList()
          : [],

      panfletos: json['panfletos'] != null
          ? (json['panfletos'] as List).map((i) => Flyer.fromJson(i)).toList()
          : [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'telefone': telefone,
      'email': email,
      'senha': senha,
      'dataPostagem': dataPostagem,
      'telefoneCelular': telefoneCelular,
      'instagram': instagram,
      'bairro': bairro,
      'cep': cep,
      'fazEntrega': fazEntrega,
      'horarioAbertura': horarioAbertura != null ? _formatTime(horarioAbertura!) : null,
      'horarioFechamento': horarioFechamento != null ? _formatTime(horarioFechamento!) : null,
      'aberto': aberto,
      'fotoUrl': fotoUrl,
      'ofertas': ofertas?.map((e) => e.toJson()).toList(),
      'panfletos': panfletos?.map((e) => e.toJson()).toList(),
    };
  }
  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return "$hour:$minute:00";
  }
}


