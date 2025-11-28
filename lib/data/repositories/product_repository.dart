// Dart imports:
/*import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:desconto_direto_comercio_mobile/config/api_config.dart';
import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<Product> create(Product product) async {
    final uri = Uri.parse('$_baseUrl/produtos/add');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<List<Product>> getAll() async {
    final uri = Uri.parse('$_baseUrl/produtos/all');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((json) => Product.fromJson(json)).toList();
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Product> getById(String id) async {
    final uri = Uri.parse('$_baseUrl/produtos/find/$id');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Product> update(Product product) async {
    final uri = Uri.parse('$_baseUrl/produtos/edit');
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Product.fromJson(json);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<void> delete(String id) async {
    final uri = Uri.parse('$_baseUrl/produtos/delete/$id');
    final response = await http.delete(uri);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return;
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception('Erro de API [DELETE]: ${errorBody['message']}');
    }
  }

  Future<void> uploadImage(String id, File image) async {
    final baseUrl = ApiConfig.baseUrl;
    final uri = Uri.parse('$baseUrl/produtos/upload-foto-produto/$id');
    final request = http.MultipartRequest('POST', uri);
    final fileMultipart = await http.MultipartFile.fromPath('photo', image.path);
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
}*/

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../config/api_config.dart';
import '../model/product_model.dart';

class ProductRepository {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<Product> create(Product product) async {
    final uri = Uri.parse('$_baseUrl/produtos/add');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    return _handleResponse(
      response,
          (json) => Product.fromJson(json),
    );
  }

  Future<List<Product>> getAll() async {
    final uri = Uri.parse('$_baseUrl/produtos/all');

    final response = await http.get(uri);

    return _handleListResponse(
      response,
          (json) => Product.fromJson(json),
    );
  }

  Future<Product> getById(String id) async {
    final uri = Uri.parse('$_baseUrl/produtos/find/$id');

    final response = await http.get(uri);

    return _handleResponse(
      response,
          (json) => Product.fromJson(json),
    );
  }

  Future<Product> update(Product product) async {
    final uri = Uri.parse('$_baseUrl/produtos/edit');

    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    return _handleResponse(
      response,
          (json) => Product.fromJson(json),
    );
  }

  Future<void> delete(String id) async {
    final uri = Uri.parse('$_baseUrl/produtos/delete/$id');
    final response = await http.delete(uri);

    if (response.statusCode != 200 && response.statusCode != 204) {
      _throwError(response);
    }
  }

  Future<void> uploadImage(String id, File image) async {
    final uri = Uri.parse('$_baseUrl/produtos/upload-foto-produto/$id');

    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath(
      'photo',
      image.path,
    ));

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erro no upload: ${response.body}');
    }
  }

  // -------------------------------
  // HELPERS (para evitar repetição)
  // -------------------------------

  T _handleResponse<T>(
      http.Response response,
      T Function(Map<String, dynamic>) converter,
      ) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return converter(json);
    }
    _throwError(response);
    throw Exception('Erro desconhecido.');
  }

  List<T> _handleListResponse<T>(
      http.Response response,
      T Function(Map<String, dynamic>) converter,
      ) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final list = jsonDecode(response.body) as List;
      return list.map((e) => converter(e)).toList();
    }
    _throwError(response);
    throw Exception('Erro desconhecido.');
  }

  void _throwError(http.Response response) {
    final body = jsonDecode(response.body);
    throw Exception("Erro API: ${body['message'] ?? response.body}");
  }
}

