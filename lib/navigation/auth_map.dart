import 'package:shelters/flows/auth/presentation/pages/sign_in/sign_in_page.dart';
import 'package:shelters/flows/auth/presentation/pages/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'helpers/route_map_initial_page.dart';

class AuthRouteMap extends RouteMap {
  AuthRouteMap() : super(onUnknownRoute: _onUnknownRoute, routes: _routes);

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');
  static final Map<String, PageBuilder> _routes = {
    /// Should always start with [RouteMapInitialPage] to maintain push and link subscription
    SignInPage.path: (_) => const MaterialPage(
          child: RouteMapInitialPage(
            child: SignInPage(),
          ),
        ),
    SignUpPage.path: (_) => const MaterialPage(
          child: SignUpPage(),
        ),
  };
}
