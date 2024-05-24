part of 'app_intenal_notifications_bloc.dart';

abstract class AppInternalNotificationsState extends Equatable {
  const AppInternalNotificationsState();

  @override
  List<Object> get props => [];
}

class AppInternalNotificationsInitial extends AppInternalNotificationsState {}

class NoInternet extends AppInternalNotificationsState {}

class HaveInternet extends AppInternalNotificationsState {}
