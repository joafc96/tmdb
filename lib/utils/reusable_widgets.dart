// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../locator.dart';
import '../styles.dart';
import '../utils/assets_helper.dart';
import '../utils/enums.dart';
import '../utils/universal_functions.dart';
import '../view_models/theme_view_model.dart';

Logger log = locator<Logger>();

// Returns spacer
Widget getSpacer({double height, double width}) {
  return SizedBox(
    height: height ?? 0.0,
    width: width ?? 0.0,
  );
}

Widget textHelper(
        {String title,
        Color textColor = Colors.black,
        double fontSize,
        bool isItalic = false,
        double letterSpacing = 0.0,
        FontWeight fontWeight = FontWeight.normal,
        TextAlign textAlign = TextAlign.center}) =>
    Text(
      title,
      style: TextStyle(
          letterSpacing: letterSpacing,
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
      textAlign: textAlign,
    );

// Returns cached image
Widget getCachedNetworkImage({@required String url, BoxFit fit}) {
  return  CachedNetworkImage(
    width: double.infinity,
    height: double.infinity,
    imageUrl: url ?? "",
    matchTextDirection: true,
    fit: fit,
    // placeholder: (context, String val) {
    //   return Container(
    //     color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
    //   );
    // },
    errorWidget: (BuildContext context, String error, Object obj) {
      return Center(
        child:  Image.asset(
          ImageAssets.appLogo,
          fit: BoxFit.fill,
          color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
          height: 24.0,
        ),
      );
    },
  );
}

void showSnackBar(String content, BuildContext context) {
  showToastWidget(
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.05,
            horizontal: 14),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
          color: Provider.of<ThemeViewModel>(context, listen: false)
              .curTheme
              .primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Provider.of<ThemeViewModel>(context, listen: false)
                    .curTheme
                    .overlay80,
                offset: const Offset(0, 15),
                blurRadius: 30,
                spreadRadius: -5),
          ],
        ),
        child: Text(
          content,
          style: AppStyles.textStyleSnackbar(context),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    dismissOtherToast: true,
    duration: const Duration(milliseconds: 3000),
  );
}

void splitAndShowError(BuildContext context, String error) {
  final List<String> _parts = error.split(':');
  final String _prefix = _parts.first.trim();

  final exceptionPrefix _exception =
      enumFromString(exceptionPrefix.values, _prefix);

  switch (_exception) {
    case exceptionPrefix.invalidInput:
      showSnackBar("Invalid input 😐", context);
      break;
    case exceptionPrefix.unauthorised:
      showSnackBar("Sorry, the account does not exist 👽", context);
      break;
    case exceptionPrefix.noInternet:
      showSnackBar("No internet connection 🤕", context);
      break;
    case exceptionPrefix.internalServerError:
      showSnackBar(
          "Error occurred while communication with Server 💩", context);
      break;
    case exceptionPrefix.invalidRequest:
      showSnackBar("Invalid request 😓", context);
      break;
    case exceptionPrefix.badFormat:
      showSnackBar("Bad format from response 😓", context);
      break;
    case exceptionPrefix.firebaseWeakPassword:
      showSnackBar('The password provided is too weak.', context);
      break;
    case exceptionPrefix.firebaseEmailAlreadyInUse:
      showSnackBar('The account already exists for that email.', context);
      break;
    case exceptionPrefix.firebaseNoUserFound:
      showSnackBar('User with this email doesn\'t exist.', context);
      break;
    case exceptionPrefix.firebaseWrongPassword:
      showSnackBar('Wrong password provided for that user.', context);
      break;
    case exceptionPrefix.fireBaseInvalidEmail:
      showSnackBar('Your email address appears to be malformed.', context);
      break;
    case exceptionPrefix.firebaseNetworkFailed:
      showSnackBar("No internet connection 🤕", context);
      break;
    case exceptionPrefix.googleSignInCancelled:
      showSnackBar("Google sign in cancelled 🤕", context);
      break;
  }
}
