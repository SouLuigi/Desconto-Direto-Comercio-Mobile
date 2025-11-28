import 'package:flutter/material.dart';

class AppBarPadrao extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final bool mostrarVoltar;
  final List<Widget>? actions;

  const AppBarPadrao({
    super.key,
    required this.titulo,
    this.mostrarVoltar = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xFF003049),
      centerTitle: true,

      automaticallyImplyLeading: false,

      leading: mostrarVoltar
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          : null,

      title: Text(
        titulo,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
