import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:desconto_direto_comercio_mobile/ui/home/widgets/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[HomeScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.Blue1,
        leading: IconButton(
          icon: Icon(Icons.account_circle_outlined, color: AppColors.Yellow1, size: 35,),
          onPressed: () {},
          tooltip: 'Perfil',
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.push(Routes.register);
        },
        backgroundColor: AppColors.Yellow1,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.White1, size: 35),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            backgroundColor: AppColors.Blue1,

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: 'panfletos',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.Yellow1,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            iconSize: 28,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
