import 'package:flutter/material.dart';

class AndroidAlertDialog extends StatelessWidget {
  const AndroidAlertDialog({
    required this.title,
    required this.message,
    required this.actionTitle,
    required this.onActionPressed,
    super.key,
  });

  final String title;
  final String message;
  final String actionTitle;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onActionPressed();
          },
          child: Text(
            actionTitle,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
