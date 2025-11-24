// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:desconto_direto_comercio_mobile/config/api_config.dart';
import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:http/http.dart' as http;

class FlyerRepository {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<Flyer> create(Flyer flyer) async {
    final uri = Uri.parse('$_baseUrl/panfletos/add');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(flyer.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Flyer.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<List<Flyer>> getAll() async {
    final uri = Uri.parse('$_baseUrl/panfletos/all');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((json) => Flyer.fromJson(json)).toList();
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Flyer> getById(String id) async {
    final uri = Uri.parse('$_baseUrl/panfletos/find/$id');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Flyer.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Flyer> update(Flyer flyer) async {
    final uri = Uri.parse('$_baseUrl/panfletos/edit');
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(flyer.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Flyer.fromJson(json);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<void> delete(String id) async {
    final uri = Uri.parse('$_baseUrl/panfletos/delete/$id');
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

  Future<void> uploadImage(String id, File image) async {
    final baseUrl = ApiConfig.baseUrl;
    final uri = Uri.parse('$baseUrl/panfletos/upload-foto-comercio/$id');
    final request = http.MultipartRequest('POST', uri);
    final fileMultipart = await http.MultipartFile.fromPath('file', image.path);
    request.files.add(fileMultipart);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Upload realizado com sucesso!");
    } else {
      throw Exception(
        'Erro no upload: ${response.statusCode} - ${response.body}',
      );
    }
  }
}


