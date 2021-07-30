import 'package:flutter/material.dart';
import 'package:flutter_task/all.exports.dart';
import 'package:flutter_task/src/features/auth/register/screen/register.screen.dart';
import 'package:flutter_task/src/features/other/unknown/screen/unknown.screen.dart';

/// The [RouteType] determines what [PageRoute] is used for the new route.
///
/// This determines the transition animation for the new route.
enum RouteType {
  defaultRoute,
  fade,
  slideIn,
}

/// A convenience class to wrap [Navigator] functionality.
///
/// Since a [GlobalKey] is used for the [Navigator], the [BuildContext] is not
/// necessary when changing the current route.
class NavigationUtilities {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  /// A convenience method to push a new [MaterialPageRoute] to the [Navigator].
  static Future push(Widget widget, {String? name}) {
    if (key.currentState == null) {
      key.currentState?.overlay?.context.showMessage("Current state not found");
      return Future.value();
    }
    return key.currentState!.push(MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: name),
    ));
  }

  /// A convenience method to push a new [route] to the [Navigator].
  static Future pushRoute(String route,
      {RouteType type = RouteType.fade, Map? args}) {
    if (args == null) {
      args = Map<String, dynamic>();
    }
    if (key.currentState == null) {
      key.currentState?.overlay?.context.showMessage("Current state not found");
      return Future.value();
    }
    args["routeType"] = type;
    return key.currentState!.pushNamed(route, arguments: args);
  }

  /// A convenience method to push a new [route] to the [Navigator].
  static Future pushNamedAndRemoveUntil(String route,
      {RouteType type = RouteType.fade, Map? args}) {
    if (args == null) {
      args = Map<String, dynamic>();
    }
    if (key.currentState == null) {
      key.currentState?.overlay?.context.showMessage("Current state not found");
      return Future.value();
    }
    args["routeType"] = type;
    return key.currentState!
        .pushNamedAndRemoveUntil(route, (_) => false, arguments: args);
  }

  /// A convenience method to push a new [route] to the [Navigator].
  static Future<dynamic> pushBlurred(Widget route) {
    if (key.currentState == null) {
      key.currentState?.overlay?.context.showMessage("Current state not found");
      return Future.value();
    }
    return Navigator.of(key.currentState!.overlay!.context).push(
      PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => route,
          fullscreenDialog: true),
    );
  }

  /// A convenience method to push a named replacement route.
  static Future pushReplacementNamed(String route,
      {RouteType type = RouteType.fade, Map? args}) {
    if (args == null) {
      args = Map<String, dynamic>();
    }
    args["routeType"] = type;
    if (key.currentState == null) {
      key.currentState?.overlay?.context.showMessage("Current state not found");
      return Future.value();
    }

    return key.currentState!.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  /// Returns a [RoutePredicate] similar to [ModalRoute.withName] except it
  /// compares a list of route names.
  ///
  /// Can be used in combination with [Navigator.pushNamedAndRemoveUntil] to
  /// pop until a route has one of the name in [names].
  static RoutePredicate namePredicate(List<String> names) {
    return (route) =>
        !route.willHandlePopInternally &&
        route is ModalRoute &&
        (names.contains(route.settings.name));
  }
}

/// [onGenerateRoute] is called whenever a new named route is being pushed to
/// the app.
///
/// The [RouteSettings.arguments] that can be passed along the named route
/// needs to be a `Map<String, dynamic>` and can be used to pass along
/// arguments for the screen.
///

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final routeName = settings.name;
  final arguments = settings.arguments as Map<String, dynamic>? ?? {};
  final routeType =
      arguments["routeType"] as RouteType? ?? RouteType.defaultRoute;

  var screen;

  switch (routeName) {
    case RegisterScreen.route:
      screen = RegisterScreen();
      break;
    default:
      screen = UnknownScreen();
      break;
  }
  switch (routeType) {
    case RouteType.fade:
      return FadeRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: routeName, arguments: arguments),
      );
    case RouteType.defaultRoute:
      return MaterialPageRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: routeName, arguments: arguments),
      );
    case RouteType.slideIn:
      return SlideRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: routeName, arguments: arguments),
      );
  }
}
