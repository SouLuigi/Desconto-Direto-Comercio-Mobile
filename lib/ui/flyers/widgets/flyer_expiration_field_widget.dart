import 'package:flutter/material.dart';

class FlyerExpirationFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const FlyerExpirationFieldWidget({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: "Data de expiração",
        suffixIcon: const Icon(Icons.calendar_month),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
