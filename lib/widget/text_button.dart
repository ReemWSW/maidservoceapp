import 'package:flutter/material.dart';

class ButtonTextCustom extends StatelessWidget {
  const ButtonTextCustom({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextButton(
          onPressed: () {},
          child: Text(
            label,
            style: const TextStyle(color: Colors.green, fontSize: 16),
          )),
    );
  }
}
