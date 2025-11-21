import 'package:flutter/material.dart' hide SearchController;
import 'search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = SearchController();
  final TextEditingController searchText = TextEditingController();

  bool loading = false;
  List<String> resultados = [];

  Future<void> buscar() async {
    setState(() => loading = true);

    resultados = await controller.buscarProdutos(searchText.text);

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade700,
        onPressed: () {},
        child: const Icon(Icons.add, size: 28, color: Colors.black),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home, color: Colors.grey, size: 28),
              SizedBox(width: 40),
              Icon(Icons.newspaper, color: Colors.grey, size: 28),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildSearchBox(),

            if (loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: CircularProgressIndicator(),
                ),
              ),

            if (!loading && resultados.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: resultados.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        resultados[i],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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

  Widget _buildTopBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF003A57),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.local_offer, color: Colors.white, size: 30),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchText,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Procure pelo produto desejado",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            GestureDetector(
              onTap: buscar,
              child: const Icon(Icons.search, color: Colors.orange, size: 28),
            )
          ],
        ),
      ),
    );
  }
}
