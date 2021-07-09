import 'package:flutter/material.dart';

// Navigates to other page with "Fade transition"
class FadeTransitionPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  @override
  final RouteSettings settings;

  FadeTransitionPageRoute({this.page, this.settings})
      : super(
      pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return page;
  },
      transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  },
  settings: settings);
}


// Slide top page route
class SlideTopPageRoute extends PageRouteBuilder {
  final Widget page;
  SlideTopPageRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

// Slide bottom page route
class SlideBottomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  SlideBottomPageRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}

class ScaleTransitionPageRoute extends PageRouteBuilder {
  final Widget page;
  ScaleTransitionPageRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            ),
          ),
          child: child,
        ),
  );
}