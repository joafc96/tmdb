// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../locator.dart';
import '../../screens/login/login_local_widgets.dart';
import '../../utils/assets_helper.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/universal_functions.dart';
import '../../view_models/login_view_model.dart';
import '../../view_models/setting_view_models/theme_view_model.dart';

class Login extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => locator<LoginViewModel>(),
      child: Login(),
    );
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _opacityAnim =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        closeKeyboard(
          context: context,
          onClose: () {},
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, left: kSpacingUnit * 2.0, right: kSpacingUnit * 2.0),
          width: double.maxFinite,
          height: double.maxFinite,
          child: Form(
            key: context.read<LoginViewModel>().loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Visibility(
                      replacement: const SizedBox(
                        height: kSpacingUnit * 0.4,
                      ),
                      visible: context.watch<LoginViewModel>().state ==
                          ViewState.loading,
                      child: LinearProgressIndicator(
                        backgroundColor:
                            context.watch<ThemeViewModel>().curTheme.primary,
                      )),
                  SizedBox(
                    height: getScreenSize(context: context).height * 0.1,
                  ),
                  FadeTransition(
                    opacity: _opacityAnim,
                    child: SizedBox(
                      width: kSpacingUnit * 10.0,
                      height: kSpacingUnit * 10.0,
                      child: SvgPicture.asset(
                        ImageAssets.appLogo,
                        color: Provider.of<ThemeViewModel>(context)
                            .curTheme
                            .primary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: kSpacingUnit * 3.0,
                  ),
                  //email widget
                  const EmailTextFormField(),
                  const SizedBox(
                    height: kSpacingUnit * 2.0,
                  ),
                  //password widget
                  const PasswordTextFormField(),
                  const SizedBox(
                    height: kSpacingUnit * 2.0,
                  ),
                  //login widget
                  const LoginButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  // register widget
                  const RegisterButton(),
                  const SizedBox(
                    height: kSpacingUnit * 2.0,
                  ),
                  // or widget
                  const OrDivider(),
                  const SizedBox(
                    height: kSpacingUnit * 2.0,
                  ),
                  // continue widget
                  const ContinueWithGoogleButton(),
                  const SizedBox(
                    height: kSpacingUnit * 2.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
