import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shelters/widgets/android_alert_dialog.dart';
import 'package:shelters/widgets/apple_alert_dialog.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
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

  static show({
    required BuildContext context,
    required String title,
    required String message,
    required String actionTitle,
    required VoidCallback onActionPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AppAlertDialog(
          title: title,
          message: message,
          actionTitle: actionTitle,
          onActionPressed: onActionPressed,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidAlertDialog(
        title: title,
        message: message,
        actionTitle: actionTitle,
        onActionPressed: onActionPressed,
      );
    }

    return AppleAlertDialog(
      message: message,
      actionTitle: actionTitle,
      onActionPressed: onActionPressed,
    );
  }
}
