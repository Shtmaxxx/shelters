import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'app_intenal_notifications_event.dart';

part 'app_intenal_notifications_state.dart';

@injectable
class AppInternalNotificationsBloc extends Bloc<AppIntenalNotificationEvent, AppInternalNotificationsState> {
  AppInternalNotificationsBloc() : super(AppInternalNotificationsInitial()) {
    on<ConnectivityResultCaught>(
      (event, emit) {
        if (event.result == ConnectivityResult.none) {
          emit(NoInternet());
        } else {
          emit(HaveInternet());
        }
      },
    );
  }
}
