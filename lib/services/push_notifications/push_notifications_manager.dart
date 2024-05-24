import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class PushNotificationManager {
  final FirebaseMessaging firebaseMessaging;

  PushNotificationManager({required this.firebaseMessaging});

  Future<void> askPermission(BuildContext context) async {
    //final NotificationSettings settings = await firebaseMessaging.getNotificationSettings();
    //if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
    // await showCupertinoModalPopup(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoAlertDialog(
    //         title: const Text('Notifications setting'),
    //         actions: <CupertinoDialogAction>[
    //           CupertinoDialogAction(
    //             child: const Text('Settings'),
    //             onPressed: () {
    //               AppSettings.openAppSettings();
    //             },
    //           ),
    //           CupertinoDialogAction(
    //             isDestructiveAction: false,
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: const Text('No, thanks'),
    //           )
    //         ],
    //       );
    //     });
    //}
    final NotificationSettings newSettings = await firebaseMessaging.requestPermission();
    if (newSettings.authorizationStatus == AuthorizationStatus.authorized) {
      firebaseMessaging.setForegroundNotificationPresentationOptions(alert: true, badge: true);
    }
  }

  Future<AuthorizationStatus> getPermissionStatus() async {
    final NotificationSettings settings = await firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus;
  }
}
