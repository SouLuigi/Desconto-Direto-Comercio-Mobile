// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import '../model/register_model.dart';

class RegisterRepository {
  final String _baseUrl = 'http://192.168.0.104:8080';

  Future<Map<String, dynamic>> sendCreationRequest(
    RegisterModel data,
  ) async {
    final uri = Uri.parse('$_baseUrl/comercios/add');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Erro de API. Status: ${response.statusCode}. Mensagem: ${errorBody['message']}',
      );
    }
  }
}
