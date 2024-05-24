import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          labelText: 'Message',
          labelStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
