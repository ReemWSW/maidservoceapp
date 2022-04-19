import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 24,
        color: Colors.blue,
        fontWeight: FontWeight.w600,
      ),
      onChanged: (value) {},
      decoration: InputDecoration(
        focusColor: Colors.white,
        //add prefix icon
        prefixIcon: const Icon(
          Icons.email,
          color: Colors.grey,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.grey,

        hintText: hintText,

        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),

        //create lable
        labelText: labelText,
        //lable style
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }
}
