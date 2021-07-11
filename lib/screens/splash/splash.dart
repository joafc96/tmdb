// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:tmdb/locator.dart';
import 'package:tmdb/utils/assets_helper.dart';
import 'package:tmdb/view_models/splash_view_model.dart';
import 'package:tmdb/view_models/setting_view_models/theme_view_model.dart';

class Splash extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => locator<SplashViewModel>(),
      child: Splash(),
    );
  }

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    // controller to provide scale animation for the tmdb logo
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    _scaleAnim = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.decelerate),
    );
    _animationController.forward();

    // checks whether the user has to be navigated to home or login
    Future.delayed(const Duration(milliseconds: 1200), () {
      Provider.of<SplashViewModel>(context, listen: false).setUpApp(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            child: ScaleTransition(
              scale: _scaleAnim,
              child: SizedBox(
                width: 200,
                child: SvgPicture.asset(
                  ImageAssets.poweredBy,
                  color: Provider.of<ThemeViewModel>(context).curTheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
