import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    required this.hintText,
    this.icon = null,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.keyboardType = TextInputType.text,
    this.onTap,
  }) : super(key: key);

  final String hintText;
  final IconData? icon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String? Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText!,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      //   return null;
      // },
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      onTap: onTap,
      maxLines: 3,
      minLines: 1,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
