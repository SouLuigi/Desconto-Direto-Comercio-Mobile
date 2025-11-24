import 'package:flutter/material.dart';

class FlyerItemWidget extends StatelessWidget {
  final String imageUrl;

  const FlyerItemWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
