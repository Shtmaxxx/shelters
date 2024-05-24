import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/app_intenal_notification_system/bloc/app_intenal_notifications_bloc.dart';
import '../app_state_cubit/app_state_cubit.dart';

class RouteMapInitialPage extends StatefulWidget {
  final Widget child;

  const RouteMapInitialPage({
    super.key,
    required this.child,
  });

  @override
  RouteMapInitialPageState createState() => RouteMapInitialPageState();
}

class RouteMapInitialPageState extends State<RouteMapInitialPage> {
  StreamSubscription? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStateCubit, AppState>(
      listener: (context, state) {},
      child: BlocListener<AppInternalNotificationsBloc,
          AppInternalNotificationsState>(
        listener: (context, state) async {},
        child: widget.child,
      ),
    );
  }
}
