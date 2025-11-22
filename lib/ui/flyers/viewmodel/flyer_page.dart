import 'package:flutter/material.dart';
import 'package:desconto_direto_comercio_mobile/data/model/flyer_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/flyer_repository.dart';
import '../../../data/services/flyer_service.dart';
import '../widgets/flyer_item_widget.dart';

class FlyersPage extends StatefulWidget {
  const FlyersPage({super.key});

  @override
  State<FlyersPage> createState() => _FlyersPageState();
}

class _FlyersPageState extends State<FlyersPage> {
  late final FlyerService flyerService;

  _FlyersPageState() {
    flyerService = FlyerService(FlyerRepository());
  }

  List<Flyer> flyers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    carregarFlyers();
  }

  Future<void> carregarFlyers() async {
    setState(() => loading = true);

    try {
      final data = await flyerService.getAllFlyers();
      setState(() => flyers = data);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar panfletos: $e")),
      );
    }

    setState(() => loading = false);
  }

  Future<void> deletarFlyer(int id) async {
    try {
      await flyerService.deleteFlyer(id);

      setState(() {
        flyers.removeWhere((f) => f.id == id);
      });

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Panfleto excluído com sucesso!")),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao excluir panfleto: $e")),
      );
    }
  }

  void abrirModal(Flyer flyer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.93,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Foto grande
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      flyer.fotoUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Botão excluir
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => deletarFlyer(flyer.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Excluir",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Fechar",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade700,
        onPressed: () {
          Navigator.pushNamed(context, "/flyer-create")
              .then((_) => carregarFlyers());
        },
        child: const Icon(Icons.add, color: Colors.black, size: 32),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home, color: Colors.grey, size: 28),
              SizedBox(width: 40),
              Icon(Icons.newspaper, color: Colors.black, size: 28),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: flyers.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final flyer = flyers[index];
                  return GestureDetector(
                    onTap: () => abrirModal(flyer),
                    child: FlyerItemWidget(imageUrl: flyer.fotoUrl),
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
