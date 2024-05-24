import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    this.obsureText = false,    
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final bool obsureText;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsureText,
      cursorColor: const Color(0xFFFFE500),
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Color(0xFFFFE500),
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFE500),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFE500),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        isDense: true,
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      validator: validator,
    );
  }
}
