import 'dart:convert';

import 'package:flutter/material.dart';

class ContainerImage extends StatelessWidget {
  const ContainerImage({
    Key? key,
    required String? image,
  })  : _image = image,
        super(key: key);

  final String? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 7,
            spreadRadius: 3,
          ),
        ],
      ),
      child: _image == '-'
          ? const Icon(Icons.account_circle_outlined)
          : Image.memory(base64Decode(_image!)),
    );
  }
}
