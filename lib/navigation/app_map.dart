import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/chat_page.dart';
import 'package:shelters/flows/menu/presentation/pages/create_marker/create_marker_page.dart';
import 'package:shelters/flows/menu/presentation/pages/pick_marker_location/pick_marker_location_page.dart';
import 'package:shelters/flows/menu/presentation/pages/profile/profile_page.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/shelters_map_page.dart';
import '../flows/main/presentation/pages/main/main_page.dart';

class AppRouteMap extends RouteMap {
  AppRouteMap()
      : super(
          onUnknownRoute: _onUnknownRoute,
          routes: _routes(),
        );

  static RouteSettings _onUnknownRoute(String route) => const Redirect('/');

  static Map<String, PageBuilder> _routes() {
    return {
      MainPage.path: (_) => _createMaterialPage(
            const MainPage(),
          ),
      ..._chatsPageRoute(),
      ..._sheltersMapRoute(),
      ..._profilePageRoute(),
    };
  }

  static Map<String, PageBuilder> _chatsPageRoute([String path = '']) {
    return {
      path + ChatPage.path: (routeData) => _createMaterialPage(
            ChatPage(
              chatId: routeData.queryParameters['chatId']!,
              chatName: routeData.queryParameters['chatName']!,
              isGroup: routeData.queryParameters['isGroup'] == 'true',
            ),
          ),
      path + SheltersMapPage.path + ChatPage.path: (routeData) =>
          _createMaterialPage(
            ChatPage(
              chatId: routeData.queryParameters['chatId']!,
              chatName: routeData.queryParameters['chatName']!,
              isGroup: routeData.queryParameters['isGroup'] == 'true',
            ),
          ),
    };
  }

  static Map<String, PageBuilder> _profilePageRoute([String path = '']) {
    return {
      path + ProfilePage.path: (routeData) => _createMaterialPage(
            ProfilePage(
              name: routeData.queryParameters['name']!,
              email: routeData.queryParameters['email'],
            ),
          ),
      path + ChatPage.path + ProfilePage.path: (routeData) =>
          _createMaterialPage(
            ProfilePage(
              name: routeData.queryParameters['name']!,
              email: routeData.queryParameters['email'],
            ),
          ),
      path + SheltersMapPage.path + ChatPage.path + ProfilePage.path:
          (routeData) => _createMaterialPage(
                ProfilePage(
                  name: routeData.queryParameters['name']!,
                  email: routeData.queryParameters['email'],
                ),
              ),
    };
  }

  static Map<String, PageBuilder> _sheltersMapRoute([String path = '']) {
    return {
      path + SheltersMapPage.path: (routeData) => _createMaterialPage(
            const SheltersMapPage(),
          ),
      path + SheltersMapPage.path + CreateMarkerPage.path: (_) =>
          _createMaterialPage(
            const CreateMarkerPage(),
          ),
      path + SheltersMapPage.path + CreateMarkerPage.path + PickMarkerLocationPage.path:
          (routeData) => _createMaterialPage(
                PickMarkerLocationPage(
                  name: routeData.queryParameters['name']!,
                  description: routeData.queryParameters['description']!,
                ),
              ),
    };
  }

  static MaterialPage<dynamic> _createMaterialPage(Widget page) {
    return MaterialPage(
      child: page,
      name: page.toString(),
    );
  }
}
