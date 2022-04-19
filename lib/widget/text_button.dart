import 'package:flutter/material.dart';

class ButtonTextCustom extends StatelessWidget {
  const ButtonTextCustom({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(color: Colors.green, fontSize: 16),
          )),
    );
  }
}
