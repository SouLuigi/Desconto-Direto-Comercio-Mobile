import 'package:flutter/material.dart';

import '../widgets/flyer_item_widget.dart';
import 'flyer_controller.dart';

class FlyersPage extends StatefulWidget {
  const FlyersPage({super.key});

  @override
  State<FlyersPage> createState() => _FlyersPageState();
}

class _FlyersPageState extends State<FlyersPage> {
  final controller = FlyersController();
  List<String> flyers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await controller.loadFlyers();
    setState(() {
      flyers = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.yellow.shade700,
        child: const Icon(Icons.add, color: Colors.black, size: 30),
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
              Icon(Icons.newspaper, color: Colors.black, size: 28),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),

            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemCount: flyers.length,
                itemBuilder: (context, i) {
                  return FlyerItemWidget(imageUrl: flyers[i]);
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
            child: Icon(Icons.local_offer, color: Colors.white, size: 32),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
