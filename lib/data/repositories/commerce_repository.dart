// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:desconto_direto_comercio_mobile/config/api_config.dart';
import 'package:desconto_direto_comercio_mobile/data/model/commerce_model.dart';
import 'package:http/http.dart' as http;

// Project imports:
import '../model/register_model.dart';

class RegisterRepository {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<Commerce> createCommerce(RegisterModel data) async {
    final uri = Uri.parse('$_baseUrl/comercios/add');
    final response = await http.post(
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
}
