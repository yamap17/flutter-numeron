import 'package:flutter/material.dart';

class TextElevatedButton extends StatelessWidget {
  const TextElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text),
        ));
  }
}
