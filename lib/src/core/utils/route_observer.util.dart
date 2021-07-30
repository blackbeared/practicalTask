import 'package:flutter/cupertino.dart';

final routeObserver = _AppRouteObserver();

class _AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  void _onRouteChanged(PageRoute<dynamic> route) {
    final routeName = route.settings.name;
    if (routeName != null) {
//      analytics.setCurrentScreen(screenName: routeName);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _onRouteChanged(route);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute && previousRoute is PageRoute) {
      _onRouteChanged(previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute is PageRoute) {
      _onRouteChanged(newRoute);
    }
  }
}
