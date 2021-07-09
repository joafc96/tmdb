import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../utils/assets_helper.dart';
import '../../utils/enums.dart';
import '../../view_models/login_view_model.dart';
import '../../view_models/theme_view_model.dart';

import '../../styles.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.disabled,
        controller: Provider.of<LoginViewModel>(context).emailController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter a valid email';
          }
          return null;
        },
        style:
            AppStyles.textStyleParagraph(context).copyWith(letterSpacing: 0.5),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.watch<ThemeViewModel>().curTheme.background,
          errorStyle:
              AppStyles.textStyleError(context).copyWith(letterSpacing: 0.5),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.text)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.primary)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.error)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.error)),
          labelText: "Email",
          labelStyle: AppStyles.textStyleParagraph(context)
              .copyWith(letterSpacing: 0.5),
          alignLabelWithHint: false,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
        cursorColor: context.watch<ThemeViewModel>().curTheme.primary,
      ),
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.disabled,
        controller: context.watch<LoginViewModel>().passwordController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter your password';
          }
          return null;
        },
        style:
            AppStyles.textStyleParagraph(context).copyWith(letterSpacing: 0.5),
        obscureText: true,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: context.watch<ThemeViewModel>().curTheme.background,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.text)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.primary)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.error)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: context.watch<ThemeViewModel>().curTheme.error)),
          errorStyle:
              AppStyles.textStyleError(context).copyWith(letterSpacing: 0.5),
          labelText: "Password",
          labelStyle: AppStyles.textStyleParagraph(context)
              .copyWith(letterSpacing: 0.5),
          alignLabelWithHint: false,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
        cursorColor: context.watch<ThemeViewModel>().curTheme.primary,
      ),
    );
  }
}

class AppThemedElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AppThemedElevatedButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  })  : assert(child == Widget),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.maxFinite,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              primary: context.watch<ThemeViewModel>().curTheme.primary),
          onPressed: onPressed,
          child: child),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemedElevatedButton(
      onPressed: context.watch<LoginViewModel>().state == ViewState.loading
          ? null
          : () {
              context
                  .read<LoginViewModel>()
                  .signUpWithEmailAndPassword(context);
            },
      child: Text(
        "REGISTER",
        style: AppStyles.textStyleButtonBackGroundSmall(context)
            .copyWith(letterSpacing: 0.2),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemedElevatedButton(
      onPressed: context.watch<LoginViewModel>().state == ViewState.loading
          ? null
          : () {
              context
                  .read<LoginViewModel>()
                  .signInWithEmailAndPassword(context);
            },
      child: Text(
        "LOG IN",
        style: AppStyles.textStyleButtonBackGroundSmall(context)
            .copyWith(letterSpacing: 0.2),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 1,
            color: context.watch<ThemeViewModel>().curTheme.primary,
          ),
        ),
        Text(
          'OR',
          style: AppStyles.textStyleParagraph(context),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 1,
            color: context.watch<ThemeViewModel>().curTheme.primary,
          ),
        ),
      ],
    );
  }
}

class ContinueWithGoogleButton extends StatelessWidget {
  const ContinueWithGoogleButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppThemedElevatedButton(
      onPressed: context.watch<LoginViewModel>().state == ViewState.loading
          ? null
          : () {
              context.read<LoginViewModel>().signInWithGoogle(context);
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageAssets.google,
            color: Provider.of<ThemeViewModel>(context).curTheme.background,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "CONTINUE WITH GOOGLE",
            style: AppStyles.textStyleButtonBackGroundSmall(context)
                .copyWith(letterSpacing: 0.2),
          ),
        ],
      ),
    );
  }
}
