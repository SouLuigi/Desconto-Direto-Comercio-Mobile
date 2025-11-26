import 'dart:io';
import 'package:flutter/material.dart';

class FlyerImagePickerWidget extends StatelessWidget {
  final File? file;
  final VoidCallback onTap;

  const FlyerImagePickerWidget({
    super.key,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        child: file == null
            ? const Center(
          child: Text(
            "Selecionar imagem",
            style: TextStyle(color: Colors.orange),
          ),
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            file!,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
