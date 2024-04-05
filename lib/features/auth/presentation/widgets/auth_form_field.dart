import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  const AuthFormField(
      {super.key, required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$labelText is empty ";
        }
        return null;
      },
      decoration: InputDecoration(
          enabledBorder: _border(),
          focusedBorder: _border(),
          label: Text(
            labelText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
        borderSide: const BorderSide(width: 3),
        borderRadius: BorderRadius.circular(8));
  }
}
