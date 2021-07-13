// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/screens/see_all/see_all_movies.dart';
import 'package:tmdb/screens/see_all/see_all_tv_shows.dart';

// Project imports:
import './screens/bottom_navigation/nested_navigation.dart';
import './screens/home/home.dart';
import './screens/splash/splash.dart';
import './utils/custom_page_transitions.dart';
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
          transition: transitionType.fade);
      break;

    case "/mainTab":
      return getPageRoute(
          builder: NestedNavigation(),
          name: routeSettings.name,
          arguments: routeSettings.arguments,
          transition: transitionType.fade);
      break;
    case "/seeAllTvShows":
      var args = routeSettings.arguments as Map;
      return getPageRoute(
          builder: SeeAllTvShows.create(args),
          name: routeSettings.name,
          arguments: routeSettings.arguments,
          transition: transitionType.cupertino);
      break;
    case "/seeAllMovies":
      var args = routeSettings.arguments as Map;
      return getPageRoute(
          builder: SeeAllMovies.create(args),
          name: routeSettings.name,
          arguments: routeSettings.arguments,
          transition: transitionType.cupertino);
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
