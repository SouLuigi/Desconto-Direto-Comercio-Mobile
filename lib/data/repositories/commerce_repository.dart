// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:desconto_direto_comercio_mobile/config/api_config.dart';
import 'package:desconto_direto_comercio_mobile/data/model/commerce_model.dart';
import 'package:desconto_direto_comercio_mobile/data/model/login_model.dart';
import 'package:http/http.dart' as http;

// Project imports:
import '../model/register_model.dart';

class CommerceRepository {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<bool> verificarApi() async {
    try {
      // Tente acessar uma rota leve, idealmente um health-check ou a raiz
      // Nota: Se estiver no emulador Android, use 10.0.2.2 em vez de localhost
      final response = await http.get(
        Uri.parse('$_baseUrl/comercios/login'),
      ).timeout(const Duration(seconds: 5)); // Define um limite de tempo (timeout)

      if (response.statusCode == 200) {
        print("✅ API Online!");
        return true;
      } else {
        print("⚠️ API respondeu, mas com erro: ${response.statusCode}");
        return false;
      }

    } on SocketException catch (_) {
      print("❌ Falha de conexão: Verifique a internet ou se o servidor está rodando.");
      return false;
    } catch (e) {
      print("❌ Erro desconhecido: $e");
      return false;
    }
  }

  Future<Commerce> login(String email, String password) async {
    final uri = Uri.parse('$_baseUrl/comercios/login');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'senha': password,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {

      return Commerce.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Commerce> create(RegisterModel data) async {
    final uri = Uri.parse('$_baseUrl/comercios/add');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Commerce.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<List<Commerce>> getAll() async {
    final uri = Uri.parse('$_baseUrl/comercios/all');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((json) => Commerce.fromJson(json)).toList();
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Commerce> getById(String id) async {
    final uri = Uri.parse('$_baseUrl/comercios/find/$id');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Commerce.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<Commerce> update(Commerce data) async {
    final uri = Uri.parse('$_baseUrl/comercios/edit');
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Commerce.fromJson(json);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }

  Future<void> delete(String id) async {
    final uri = Uri.parse('$_baseUrl/comercios/delete/$id');
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
    final uri = Uri.parse('$baseUrl/comercios/upload-foto-comercio/$id');
    final request = http.MultipartRequest('POST', uri);
    final fileMultipart = await http.MultipartFile.fromPath('photo', image.path);
    request.files.add(fileMultipart);
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Upload realizado com sucesso!");
    } else {
      print("Erro detalhado: ${response.body}");
      throw Exception(
        'Erro no upload: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
