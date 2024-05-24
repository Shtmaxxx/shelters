part of 'app_intenal_notifications_bloc.dart';

abstract class AppIntenalNotificationEvent {
  const AppIntenalNotificationEvent();
}

class ConnectivityResultCaught extends AppIntenalNotificationEvent {
  final ConnectivityResult result;

  ConnectivityResultCaught({required this.result});
}
