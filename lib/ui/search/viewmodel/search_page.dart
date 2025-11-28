import 'package:flutter/material.dart';
import 'package:desconto_direto_comercio_mobile/data/model/product_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/product_repository.dart';
import '../../../data/services/product_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final ProductService productService;

  final TextEditingController searchCtrl = TextEditingController();

  List<Product> produtos = [];
  List<Product> filtrados = [];

  bool loading = true;

  _SearchPageState() {
    productService = ProductService(ProductRepository());
  }

  @override
  void initState() {
    super.initState();
    carregarProdutos();
  }

  Future<void> carregarProdutos() async {
    try {
      final lista = await productService.getAll();

      setState(() {
        produtos = lista;
        filtrados = lista;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar produtos: $e")),
      );
    }
  }

  void filtrarProdutos(String texto) {
    texto = texto.toLowerCase();

    setState(() {
      filtrados = produtos.where((p) {
        return p.nome.toLowerCase().startsWith(texto) ||
            p.categoria.toLowerCase().startsWith(texto) ||
            p.medida.toLowerCase().startsWith(texto);
      }).toList();
    });
  }

  void abrirModalProduto(Product produto) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  produto.fotoUrl,
                  height: 210,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                produto.nome,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Categoria: ${produto.categoria}"),
              Text("Medida: ${produto.medida} ${produto.unidadeMedida}"),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 👉 Widgets globais do seu app
      // appBar: const CustomTopBar(),      // Se existir
      // bottomNavigationBar: const CustomBottomBar(selectedIndex: 2),

      body: SafeArea(
        child: Column(
          children: [
            // 🔎 Barra de busca
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchCtrl,
                  onChanged: filtrarProdutos,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Procure pelo produto desejado",
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    suffixIcon: Icon(Icons.search, color: Colors.orange),
                  ),
                ),
              ),
            ),

            // 🔄 Lista / Loading / Vazio
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : filtrados.isEmpty
                  ? const Center(
                child: Text(
                  "Nenhum produto encontrado.",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtrados.length,
                itemBuilder: (context, index) {
                  final p = filtrados[index];

                  return GestureDetector(
                    onTap: () => abrirModalProduto(p),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.network(
                              p.fotoUrl,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.nome,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(p.categoria),
                                Text(
                                  "Medida: ${p.medida} ${p.unidadeMedida}",
                                  style: const TextStyle(
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
