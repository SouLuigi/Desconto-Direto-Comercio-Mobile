import 'package:flutter/material.dart';

class CampoNaoEditavel extends StatelessWidget {
  final String label;
  final String value;

  const CampoNaoEditavel({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 5),

        AbsorbPointer(
          child: Opacity(
            opacity: 0.75,
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
