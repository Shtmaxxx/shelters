import 'package:flutter/cupertino.dart';

class AppleAlertDialog extends StatelessWidget {
  const AppleAlertDialog({
    required this.message,
    required this.actionTitle,
    required this.onActionPressed,
    super.key,
  });

  final String message;
  final String actionTitle;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(message),
      actions: [
        CupertinoDialogAction(
          onPressed: Navigator.of(context).pop,
          isDefaultAction: true,
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
            onActionPressed();
          },
          isDestructiveAction: true,
          child: Text(
            actionTitle,
          ),
        ),
      ],
    );
  }
}
