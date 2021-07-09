// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../screens/login/login_local_widgets.dart';
import '../../utils/assets_helper.dart';
import '../../utils/enums.dart';
import '../../styles.dart';
import '../../view_models/login_view_model.dart';

// Project imports:
import '../../utils/universal_functions.dart';
import '../../locator.dart';
import '../../view_models/theme_view_model.dart';

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
              top: MediaQuery.of(context).padding.top, left: 20, right: 20),
          width: double.maxFinite,
          height: double.maxFinite,
          child: Form(
            key: context.read<LoginViewModel>().loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Visibility(
                      replacement: const SizedBox(
                        height: 4,
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
                      width: 100,
                      height: 100,
                      child: SvgPicture.asset(
                        ImageAssets.appLogo,
                        color: Provider.of<ThemeViewModel>(context)
                            .curTheme
                            .primary,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //email widget
                  const EmailTextFormField(),
                  const SizedBox(
                    height: 20,
                  ),
                  //password widget
                  const PasswordTextFormField(),
                  const SizedBox(
                    height: 20,
                  ),
                  //login widget
                  const LoginButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  // register widget
                  const RegisterButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  // or widget
                  const OrDivider(),
                  const SizedBox(
                    height: 20,
                  ),
                  // continue widget
                  const ContinueWithGoogleButton(),
                  const SizedBox(
                    height: 20,
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
