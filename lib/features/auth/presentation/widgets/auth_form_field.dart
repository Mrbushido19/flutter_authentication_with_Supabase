import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  const AuthFormField(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.isObscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
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
