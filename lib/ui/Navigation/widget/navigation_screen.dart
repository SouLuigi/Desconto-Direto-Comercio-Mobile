import 'package:desconto_direto_comercio_mobile/data/model/commerce_model.dart';
import 'package:desconto_direto_comercio_mobile/data/repositories/commerce_repository.dart';
import 'package:desconto_direto_comercio_mobile/data/services/commerce_service.dart';
import 'package:desconto_direto_comercio_mobile/data/services/flutter_secure_storage.dart';
import 'package:desconto_direto_comercio_mobile/routing/routes.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:desconto_direto_comercio_mobile/ui/home/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  Commerce? _commerce;
  bool _isLoading = true;

  static const List<Widget> _screens = <Widget>[HomeScreen()];
  final _commerceRepository = CommerceRepository();
  final _localStore = LocalStorageService();
  late final String _token;
  late final CommerceService _commerceService;

  @override
  void initState() {
    super.initState();
    _token = "2";
    _commerceService = CommerceService(_commerceRepository, _localStore);
    _fetchCommerce();
  }

  void _fetchCommerce() async {
    try {
      final commerceData = await _commerceService.getCommerceById(_token);
      setState(() {
        _commerce = commerceData;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar comercio: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildDrawerHeader() {
    if (_isLoading) {
      return const DrawerHeader(
        decoration: BoxDecoration(color: AppColors.Blue1),
        child: Center(
          child: CircularProgressIndicator(color: AppColors.Yellow1),
        ),
      );
    }

    if (_commerce == null) {
      return const UserAccountsDrawerHeader(
        accountName: Text("Comércio não encontrado"),
        accountEmail: Text(""),
        currentAccountPicture: CircleAvatar(
          backgroundColor: AppColors.Yellow1,
          child: Icon(Icons.error, color: AppColors.Blue1),
        ),
        decoration: BoxDecoration(color: AppColors.Blue1),
      );
    }

    final bool hasValidImage =
          _commerce!.fotoUrl != null && _commerce!.fotoUrl!.isNotEmpty;

    final Widget profilePicture = CircleAvatar(
      backgroundColor: AppColors.Yellow1,
      backgroundImage: hasValidImage
          ? NetworkImage(_commerce!.fotoUrl!) as ImageProvider<Object>?
          : null,
      child: !hasValidImage
          ? Text(
              _commerce!.nome.isNotEmpty
                  ? _commerce!.nome[0].toUpperCase()
                  : '?',
              style: const TextStyle(fontSize: 40, color: AppColors.Blue1),
            )
          : null,
    );

    return UserAccountsDrawerHeader(
      accountName: Text(
        _commerce!.nome,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      accountEmail: Text(
        _commerce!.categoria,
        style: TextStyle(color: Colors.grey),
      ),
      currentAccountPicture: profilePicture,
      decoration: const BoxDecoration(color: AppColors.Blue1),
    );
  }

  Widget _buildProfileAvatar({double radius = 17.5}) {
    if (_commerce == null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.Yellow1,
        child: Icon(Icons.error, color: AppColors.Blue1, size: radius * 1.5),
      );
    }

    final bool hasValidImage =
        _commerce!.fotoUrl != null && _commerce!.fotoUrl!.isNotEmpty;

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.Yellow1,
      backgroundImage: hasValidImage
          ? NetworkImage(_commerce!.fotoUrl!) as ImageProvider<Object>?
          : null,
      child: !hasValidImage
          ? Text(
              _commerce!.nome.isNotEmpty
                  ? _commerce!.nome[0].toUpperCase()
                  : '?',
              style: TextStyle(
                fontSize: radius,
                color: AppColors.Blue1,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }

  void _logout(BuildContext context) async {
    await _localStore.deleteToken();

    if (context.mounted) {
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      //   (Route<dynamic> route) => false,
      // );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Saindo...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.Blue1,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: _isLoading
                ? const CircularProgressIndicator(color: AppColors.Yellow1)
                : _buildProfileAvatar(),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.Blue1,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
                context.push(Routes.profile);
              },
              child: _buildDrawerHeader(),
            ),
            ListTile(
              leading: Icon(Symbols.add_notes, color: Colors.white),
              title: Text(
                "Adicionar panfleto",
                style: TextStyle(color: Colors.white),
              ),

              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Symbols.new_label, color: Colors.white),
              title: Text(
                "Adicionar oferta",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Symbols.add_shopping_cart, color: Colors.white),
              title: Text(
                "Adicionar produto",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text(
                "Sair",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer primeiro
                _logout(context); // Chama a função de logout
              },
            ),
          ],
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
