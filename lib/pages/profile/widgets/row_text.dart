import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  const RowText({
    Key? key,
    required String this.label,
    required Widget this.widget,
  }) : super(key: key);

  final String? label;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label'),
          widget!,
        ],
      ),
    );
  }
}
