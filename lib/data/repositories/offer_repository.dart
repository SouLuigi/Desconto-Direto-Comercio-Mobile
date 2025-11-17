import 'dart:convert';

import 'package:desconto_direto_comercio_mobile/config/api_config.dart';
import 'package:desconto_direto_comercio_mobile/data/model/offer_model.dart';
import 'package:http/http.dart' as http;

class OfferRegister {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<List<Offer>> getAll() async {
    final uri = Uri.parse("$_baseUrl/ofertas/all");
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((json) => Offer.fromJson(json)).toList();
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<List<Offer>> getAllRecents() async {
    final uri = Uri.parse("$_baseUrl/ofertas/recentes");
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((json) => Offer.fromJson(json)).toList();
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<List<Offer>> getMostLiked() async {
    final uri = Uri.parse("$_baseUrl/ofertas/top");
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((json) => Offer.fromJson(json)).toList();
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Offer> getById(int id) async {
    final uri = Uri.parse('$_baseUrl/ofertas/find/$id');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Offer.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }


  Future<Offer> create(Offer offer) async {
    final uri = Uri.parse('$_baseUrl/ofertas');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(offer.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Offer.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Offer> update(Offer offer) async {
    final uri = Uri.parse('$_baseUrl/ofertas/edit');
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(offer.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Offer.fromJson(json);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<void> delete(int id) async {
    final uri = Uri.parse('$_baseUrl/ofertas/delete/$id');
    final response = await http.delete(
      uri,
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      return;
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception('Erro de API [DELETE]: ${errorBody['message']}');
    }
  }
}
