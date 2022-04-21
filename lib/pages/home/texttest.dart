import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.optionStyle,
    required this.label,
  }) : super(key: key);

  final TextStyle optionStyle;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: optionStyle,
    );
  }
}
