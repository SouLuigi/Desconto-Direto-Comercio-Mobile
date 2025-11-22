import 'dart:convert';
import 'package:http/http.dart' as http;

class FlyersController {
  final String baseUrl = ""; // link da api

  Future<List<String>> buscarFlyers() async {
    try {
      final url = Uri.parse("$baseUrl/"); // colocar endpoint dos panfletos

      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer SEU_TOKEN",  // se necessário
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return List<String>.from(
          data.map((item) => item["imageUrl"]),
        );
      } else {
        print("Erro: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro ao buscar panfletos: $e");
      return [];
    }
  }
}
