import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FlyersCreateController {
  final String baseUrl = ""; // link api

  Future<bool> cadastrarFlyer({
    required File imagem,
    required String dataPostagem,
    required String dataVencimento,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/"); //acertar endpoint

      final request = http.MultipartRequest("POST", url);

      // Campos textuais
      request.fields["dataPostagem"] = dataPostagem;
      request.fields["dataVencimento"] = dataVencimento;

      // Upload da imagem
      request.files.add(
        await http.MultipartFile.fromPath("imagem", imagem.path),
      );

      // Cabeçalhos opcionais
      request.headers["Accept"] = "application/json";
      // request.headers["Authorization"] = "Bearer token"; 

      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      print("DEBUG => ${response.statusCode}");
      print("DEBUG => $respStr");

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("ERRO UPLOAD: $e");
      return false;
    }
  }
}
