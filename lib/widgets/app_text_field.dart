import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    this.obsureText = false,
    this.focusNode,
    this.maxLength,
    this.maxLines = 1,
    this.color = Colors.white,
    this.textColor,
    this.errorColor = const Color(0xffede737),
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final bool obsureText;
  final FocusNode? focusNode;
  final int? maxLength;
  final int maxLines;
  final Color color;
  final Color? textColor;
  final Color errorColor;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsureText,
      cursorColor: Theme.of(context).primaryColorDark,
      maxLength: maxLength,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 16,
        color: textColor,
      ),
      focusNode: focusNode,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
          ),
        ),
        errorStyle: TextStyle(
          color: errorColor,
          fontWeight: FontWeight.w500,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorColor,
          ),
        ),
        isDense: true,
        labelText: label,
        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            final Color color =
                states.contains(MaterialState.error) ? errorColor : this.color;
            return TextStyle(
              fontSize: 16,
              color: color,
            );
          },
        ),
        labelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            final Color color =
                states.contains(MaterialState.error) ? errorColor : this.color;
            return TextStyle(
              fontSize: 16,
              color: color,
            );
          },
        ),
      ),
      validator: validator,
    );
  }
}
