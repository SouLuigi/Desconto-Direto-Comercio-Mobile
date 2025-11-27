import 'package:flutter/material.dart';
import '../../Navigation/widget/navigation_screen.dart';
import '../viewmodel/flyer_viewmodel.dart';
import 'flyer_item_widget.dart';
import 'flyer_modal_widget.dart';

class FlyersScreen extends StatefulWidget {
  const FlyersScreen({super.key});

  @override
  State<FlyersScreen> createState() => _FlyersScreenState();
}

class _FlyersScreenState extends State<FlyersScreen> {
  final vm = FlyerViewModel();

  @override
  void initState() {
    super.initState();
    vm.carregarFlyers();
  }

  void _openModal(flyer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return FlyerModalWidget(
          flyer: flyer,
          onDelete: () async {
            await vm.deletarFlyer(flyer.id);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: vm.loading,
          builder: (_, loading, __) {
            if (loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ValueListenableBuilder(
              valueListenable: vm.flyers,
              builder: (_, lista, __) {
                if (lista.isEmpty) {
                  return const Center(
                    child: Text("Nenhum panfleto encontrado."),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: lista.length,
                  itemBuilder: (_, i) {
                    final flyer = lista[i];
                    return GestureDetector(
                      onTap: () => _openModal(flyer),
                      child: FlyerItemWidget(imageUrl: flyer.fotoUrl),
                    );
                  },
                );
              },
            );
          },
        ),
      ),


      /*floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow.shade700,
        onPressed: () {
          Navigator.pushNamed(context, "/create_flyers")
              .then((_) => vm.carregarFlyers());
        },
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,*/
    );
  }
}
