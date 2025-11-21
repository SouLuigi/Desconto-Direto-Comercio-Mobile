class SearchController {
  Future<List<String>> buscarProdutos(String termo) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Exemplo — aqui você liga com API real depois
    return [
      "Arroz Branco",
      "Feijão Carioca",
      "Café Torrado",
      "Macarrão Espaguete"
    ].where((p) => p.toLowerCase().contains(termo.toLowerCase())).toList();
  }
}
