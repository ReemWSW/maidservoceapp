import 'package:flutter/material.dart';

class ButtonLong extends StatelessWidget {
  const ButtonLong({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
