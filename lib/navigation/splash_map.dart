import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import '../flows/splash/presentation/pages/splash/splash_page.dart';
import 'helpers/route_map_initial_page.dart';

class SplashRouteMap extends RouteMap {
  SplashRouteMap()
      : super(
          onUnknownRoute: _onUnknownRoute,
          routes: _routes,
        );

  static RouteSettings _onUnknownRoute(String route) =>
      const Redirect(SplashPage.path);

  static final Map<String, PageBuilder> _routes = {
    SplashPage.path: (_) => const MaterialPage(
          child: RouteMapInitialPage(
            child: SplashPage(),
          ),
        ),
  };
}
