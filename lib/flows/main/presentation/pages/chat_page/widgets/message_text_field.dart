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
            horizontal: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(16)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(16)
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
