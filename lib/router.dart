// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/bottom_navigation/nested_navigation.dart';

// Project imports:
import './screens/home/home.dart';
import './utils/custom_page_transitions.dart';
import './screens/splash/splash.dart';
import 'screens/login/login.dart';

enum transitionType { cupertino, material, fade, scale, slideTop, slideBottom }

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case "/":
      return getPageRoute(
          builder: Splash.create(),
          name: routeSettings.name,
          arguments: routeSettings.arguments);
      break;
    case "/login":
      return getPageRoute(
          builder: Login.create(),
          name: routeSettings.name,
          arguments: routeSettings.arguments,
          transition: transitionType.fade);
    case "/home":
      return getPageRoute(
          builder: const Home(),
          name: routeSettings.name,
          arguments: routeSettings.arguments,
          transition: transitionType.fade
      );
      break;

    case "/mainTab":
      return getPageRoute(
          builder: NestedNavigation(),
          name: routeSettings.name,
          arguments: routeSettings.arguments,
          transition: transitionType.fade);
      break;

    default:
      return getPageRoute(
        builder: Scaffold(
          body: Center(
            child: Text("No route defined for ${routeSettings.name}"),
          ),
        ),
      );
      break;
  }
}

Route<dynamic> getPageRoute(
    {Widget builder,
    String name,
    Object arguments,
    transitionType transition = transitionType.cupertino}) {
  switch (transition) {
    case transitionType.cupertino:
      return CupertinoPageRoute(
        builder: (_) => builder,
        settings: RouteSettings(name: name, arguments: arguments),
      );
      break;
    case transitionType.material:
      return MaterialPageRoute(
        builder: (_) => builder,
        settings: RouteSettings(name: name, arguments: arguments),
      );
      break;
    case transitionType.fade:
      return FadeTransitionPageRoute(
        page: builder,
        settings: RouteSettings(name: name, arguments: arguments),
      );
      break;
    case transitionType.scale:
      return ScaleTransitionPageRoute(
        page: builder,
      );
      break;
    case transitionType.slideTop:
      return SlideTopPageRoute(
        page: builder,
      );
      break;
    case transitionType.slideBottom:
      return SlideBottomPageRoute(
        page: builder,
      );
      break;
    default:
      return CupertinoPageRoute(
        builder: (_) => builder,
        settings: RouteSettings(name: name, arguments: arguments),
      );
      break;
  }
}
