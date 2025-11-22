import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchController {
  final String baseUrl = ""; // link api

  Future<List<String>> buscarProdutos(String termo) async {
    try {
      final url = Uri.parse("$baseUrl/api/produtos/buscar?nome=$termo");

      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return List<String>.from(
          data.map((item) => item["nome"]),
        );
      } else {
        print("Erro ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar produtos: $e");
      return [];
    }
  }
}
