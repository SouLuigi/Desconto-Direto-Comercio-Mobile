import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const WidgetButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.black,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        )
      ),
    );
  }
}