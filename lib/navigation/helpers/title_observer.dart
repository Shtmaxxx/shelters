import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:routemaster/routemaster.dart';

/// Title observer that updates the app's title when the route changes
/// This shows in a browser tab's title.
class TitleObserver extends RoutemasterObserver {

  @override
  void didChangeRoute(RouteData routeData, Page page) {
    if (page.name != null) {
      SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: page.name,
          primaryColor: 0xFF00FF00,
        ),
      );
    }
  }

}
