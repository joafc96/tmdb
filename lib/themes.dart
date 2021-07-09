// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  Color primary;
  Color primary60;
  Color primary45;
  Color primary30;
  Color primary20;
  Color primary15;
  Color primary10;

  Color success;
  Color success15;
  Color success30;
  Color success60;
  Color successDark;
  Color successDark30;

  Color error;


  Color background;
  Color background40;
  Color background20;
  Color background10;
  Color background00;

  Color backgroundLight;
  Color backgroundLight10;
  Color backgroundLight00;

  Color backgroundDarkest;

  Color text;
  Color text60;
  Color text45;
  Color text30;
  Color text20;
  Color text15;
  Color text10;
  Color text05;
  Color text03;

  Color overlay20;
  Color overlay30;
  Color overlay50;
  Color overlay70;
  Color overlay80;
  Color overlay85;
  Color overlay90;


  Color animationOverlayMedium;
  Color animationOverlayStrong;

  Brightness brightness;
  SystemUiOverlayStyle statusBar;

  BoxShadow boxShadow;
  BoxShadow boxShadowButton;
}

class NatriumTheme extends BaseTheme {
  static const brightBlue = Color(0xFFA3CDFF);

  static const green = Color(0xFF4AFFAE);

  static const greenDark = Color(0xFF18A264);

  static const blueishGreyDark = Color(0xFF1E2C3D);

  static const blueishGreyLight = Color(0xFF2A3A4D);

  static const blueishGreyDarkest = Color(0xFF1E2C3D);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF000000);

  static const firebrick = Color(0xffff0033);

  Color primary = brightBlue;
  Color primary60 = brightBlue.withOpacity(0.6);
  Color primary45 = brightBlue.withOpacity(0.45);
  Color primary30 = brightBlue.withOpacity(0.3);
  Color primary20 = brightBlue.withOpacity(0.2);
  Color primary15 = brightBlue.withOpacity(0.15);
  Color primary10 = brightBlue.withOpacity(0.1);

  Color success = green;
  Color success60 = green.withOpacity(0.6);
  Color success30 = green.withOpacity(0.3);
  Color success15 = green.withOpacity(0.15);

  Color error = firebrick;

  Color successDark = greenDark;
  Color successDark30 = greenDark.withOpacity(0.3);

  Color background = blueishGreyDark;
  Color background40 = blueishGreyDark.withOpacity(0.4);
  Color background20 = blueishGreyDark.withOpacity(0.2);
  Color background10 = blueishGreyDark.withOpacity(0.1);
  Color background00 = blueishGreyDark.withOpacity(0.0);

  Color backgroundLight = blueishGreyLight;
  Color backgroundLight10 = blueishGreyLight.withOpacity(0.1);
  Color backgroundLight00 = blueishGreyLight.withOpacity(0.0);

  Color backgroundDarkest = blueishGreyDarkest;

  Color text = white.withOpacity(0.9);
  Color text60 = white.withOpacity(0.6);
  Color text45 = white.withOpacity(0.45);
  Color text30 = white.withOpacity(0.3);
  Color text20 = white.withOpacity(0.2);
  Color text15 = white.withOpacity(0.15);
  Color text10 = white.withOpacity(0.1);
  Color text05 = white.withOpacity(0.05);
  Color text03 = white.withOpacity(0.03);

  Color overlay90 = black.withOpacity(0.9);
  Color overlay85 = black.withOpacity(0.85);
  Color overlay80 = black.withOpacity(0.8);
  Color overlay70 = black.withOpacity(0.7);
  Color overlay50 = black.withOpacity(0.5);
  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);

  Color animationOverlayMedium = black.withOpacity(0.7);
  Color animationOverlayStrong = black.withOpacity(0.85);

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  BoxShadow boxShadow = BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = BoxShadow(color: Colors.transparent);
}

class TitaniumTheme extends BaseTheme {
  static const blueishGreen = Color(0xFF61C6AD);

  static const green = Color(0xFFB5ED88);

  static const greenDark = Color(0xFF5F893D);

  static const tealDark = Color(0xFF041920);

  static const tealLight = Color(0xFF052029);

  static const tealDarkest = Color(0xFF041920);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF000000);

  static const firebrick = Color(0xffff0033);

  Color primary = blueishGreen;
  Color primary60 = blueishGreen.withOpacity(0.6);
  Color primary45 = blueishGreen.withOpacity(0.45);
  Color primary30 = blueishGreen.withOpacity(0.3);
  Color primary20 = blueishGreen.withOpacity(0.2);
  Color primary15 = blueishGreen.withOpacity(0.15);
  Color primary10 = blueishGreen.withOpacity(0.1);

  Color success = green;
  Color success60 = green.withOpacity(0.6);
  Color success30 = green.withOpacity(0.3);
  Color success15 = green.withOpacity(0.15);

  Color successDark = greenDark;
  Color successDark30 = greenDark.withOpacity(0.3);

  Color error = firebrick;

  Color background = tealDark;
  Color background40 = tealDark.withOpacity(0.4);
  Color background20 = tealDark.withOpacity(0.2);
  Color background10 = tealDark.withOpacity(0.1);
  Color background00 = tealDark.withOpacity(0.0);

  Color backgroundLight = tealLight;
  Color backgroundLight10 = tealLight.withOpacity(0.1);
  Color backgroundLight00 = tealLight.withOpacity(0.0);

  Color backgroundDarkest = tealDarkest;

  Color text = white.withOpacity(0.9);
  Color text60 = white.withOpacity(0.6);
  Color text45 = white.withOpacity(0.45);
  Color text30 = white.withOpacity(0.3);
  Color text20 = white.withOpacity(0.2);
  Color text15 = white.withOpacity(0.15);
  Color text10 = white.withOpacity(0.1);
  Color text05 = white.withOpacity(0.05);
  Color text03 = white.withOpacity(0.03);

  Color overlay90 = black.withOpacity(0.9);
  Color overlay85 = black.withOpacity(0.85);
  Color overlay80 = black.withOpacity(0.8);
  Color overlay70 = black.withOpacity(0.7);
  Color overlay50 = black.withOpacity(0.5);
  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);

  Color animationOverlayMedium = black.withOpacity(0.7);
  Color animationOverlayStrong = black.withOpacity(0.85);

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  BoxShadow boxShadow = BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = BoxShadow(color: Colors.transparent);
}

class IndiumTheme extends BaseTheme {
  static const deepBlue = Color(0xFF0050BB);

  static const green = Color(0xFF00A873);

  static const greenLight = Color(0xFF9EEDD4);

  static const white = Color(0xFFFFFFFF);

  static const whiteishDark = Color(0xFFE8F0FA);

  static const grey = Color(0xFF454868);

  static const black = Color(0xFF000000);

  static const darkDeepBlue = Color(0xFF0050BB);

  static const firebrick = Color(0xffff0033);


  Color primary = deepBlue;
  Color primary60 = deepBlue.withOpacity(0.6);
  Color primary45 = deepBlue.withOpacity(0.45);
  Color primary30 = deepBlue.withOpacity(0.3);
  Color primary20 = deepBlue.withOpacity(0.2);
  Color primary15 = deepBlue.withOpacity(0.15);
  Color primary10 = deepBlue.withOpacity(0.1);

  Color success = green;
  Color success60 = green.withOpacity(0.6);
  Color success30 = green.withOpacity(0.3);
  Color success15 = green.withOpacity(0.15);

  Color successDark = greenLight;
  Color successDark30 = greenLight.withOpacity(0.3);

  Color error = firebrick;

  Color background = white;
  Color background40 = white.withOpacity(0.4);
  Color background20 = white.withOpacity(0.2);
  Color background10 = white.withOpacity(0.1);
  Color background00 = white.withOpacity(0.0);

  Color backgroundLight = whiteishDark;
  Color backgroundLight10 = whiteishDark.withOpacity(0.1);
  Color backgroundLight00 = white.withOpacity(0.0);

  Color backgroundDarkest = whiteishDark;

  Color text = grey.withOpacity(0.9);
  Color text60 = grey.withOpacity(0.6);
  Color text45 = grey.withOpacity(0.45);
  Color text30 = grey.withOpacity(0.3);
  Color text20 = grey.withOpacity(0.2);
  Color text15 = grey.withOpacity(0.15);
  Color text10 = grey.withOpacity(0.1);
  Color text05 = grey.withOpacity(0.05);
  Color text03 = grey.withOpacity(0.03);

  Color overlay90 = black.withOpacity(0.9);
  Color overlay85 = black.withOpacity(0.85);
  Color overlay80 = black.withOpacity(0.8);
  Color overlay70 = black.withOpacity(0.7);
  Color overlay50 = black.withOpacity(0.5);
  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);

  Color animationOverlayMedium = white.withOpacity(0.7);
  Color animationOverlayStrong = white.withOpacity(0.85);

  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);

  BoxShadow boxShadow = BoxShadow(
      color: darkDeepBlue.withOpacity(0.1),
      offset: const Offset(0, 5),
      blurRadius: 15);
  BoxShadow boxShadowButton = BoxShadow(
      color: darkDeepBlue.withOpacity(0.2),
      offset: const Offset(0, 5),
      blurRadius: 15);
}


class NeptuniumTheme extends BaseTheme {
  static const blue = Color(0xFF4A90E2);

  static const orange = Color(0xFFF9AE42);

  static const orangeDark = Color(0xFF9C671E);

  static const blueDark = Color(0xFF000034);

  static const blueLightish = Color(0xFF080840);

  static const blueDarkest = Color(0xFF000034);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF000000);

  static const firebrick = Color(0xffff0033);


  Color primary = blue;
  Color primary60 = blue.withOpacity(0.6);
  Color primary45 = blue.withOpacity(0.45);
  Color primary30 = blue.withOpacity(0.3);
  Color primary20 = blue.withOpacity(0.2);
  Color primary15 = blue.withOpacity(0.15);
  Color primary10 = blue.withOpacity(0.1);

  Color success = orange;
  Color success60 = orange.withOpacity(0.6);
  Color success30 = orange.withOpacity(0.3);
  Color success15 = orange.withOpacity(0.15);

  Color successDark = orangeDark;
  Color successDark30 = orangeDark.withOpacity(0.3);

  Color error = firebrick;

  Color background = blueDark;
  Color background40 = blueDark.withOpacity(0.4);
  Color background20 = blueDark.withOpacity(0.2);
  Color background10 = blueDark.withOpacity(0.1);
  Color background00 = blueDark.withOpacity(0.0);

  Color backgroundLight = blueLightish;
  Color backgroundLight10 = blueLightish.withOpacity(0.1);
  Color backgroundLight00 = blueLightish.withOpacity(0.0);

  Color backgroundDarkest = blueDarkest;

  Color text = white.withOpacity(0.9);
  Color text60 = white.withOpacity(0.6);
  Color text45 = white.withOpacity(0.45);
  Color text30 = white.withOpacity(0.3);
  Color text20 = white.withOpacity(0.2);
  Color text15 = white.withOpacity(0.15);
  Color text10 = white.withOpacity(0.1);
  Color text05 = white.withOpacity(0.05);
  Color text03 = white.withOpacity(0.03);

  Color overlay90 = black.withOpacity(0.9);
  Color overlay85 = black.withOpacity(0.85);
  Color overlay80 = black.withOpacity(0.8);
  Color overlay70 = black.withOpacity(0.7);
  Color overlay50 = black.withOpacity(0.5);
  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);

  Color animationOverlayMedium = black.withOpacity(0.7);
  Color animationOverlayStrong = black.withOpacity(0.85);

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
  SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  BoxShadow boxShadow = const BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = const BoxShadow(color: Colors.transparent);


}

class ThoriumTheme extends BaseTheme {
  static const teal = Color(0xFF75F3FF);

  static const orange = Color(0xFFFFBA59);

  static const orangeDark = Color(0xFFBF8026);

  static const purpleDark = Color(0xFF200A40);

  static const purpleLight = Color(0xFF2A1052);

  static const purpleDarkest = Color(0xFF200A40);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF000000);

  static const firebrick = Color(0xffff0033);


  Color primary = teal;
  Color primary60 = teal.withOpacity(0.6);
  Color primary45 = teal.withOpacity(0.45);
  Color primary30 = teal.withOpacity(0.3);
  Color primary20 = teal.withOpacity(0.2);
  Color primary15 = teal.withOpacity(0.15);
  Color primary10 = teal.withOpacity(0.1);

  Color success = orange;
  Color success60 = orange.withOpacity(0.6);
  Color success30 = orange.withOpacity(0.3);
  Color success15 = orange.withOpacity(0.15);

  Color successDark = orangeDark;
  Color successDark30 = orangeDark.withOpacity(0.3);

  Color error = firebrick;

  Color background = purpleDark;
  Color background40 = purpleDark.withOpacity(0.4);
  Color background20 = purpleDark.withOpacity(0.2);
  Color background10 = purpleDark.withOpacity(0.1);
  Color background00 = purpleDark.withOpacity(0.0);

  Color backgroundLight = purpleLight;
  Color backgroundLight10 = purpleLight.withOpacity(0.1);
  Color backgroundLight00 = purpleLight.withOpacity(0.0);

  Color backgroundDarkest = purpleDarkest;

  Color text = white.withOpacity(0.9);
  Color text60 = white.withOpacity(0.6);
  Color text45 = white.withOpacity(0.45);
  Color text30 = white.withOpacity(0.3);
  Color text20 = white.withOpacity(0.2);
  Color text15 = white.withOpacity(0.15);
  Color text10 = white.withOpacity(0.1);
  Color text05 = white.withOpacity(0.05);
  Color text03 = white.withOpacity(0.03);

  Color overlay90 = black.withOpacity(0.9);
  Color overlay85 = black.withOpacity(0.85);
  Color overlay80 = black.withOpacity(0.8);
  Color overlay70 = black.withOpacity(0.7);
  Color overlay50 = black.withOpacity(0.5);
  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);

  Color animationOverlayMedium = black.withOpacity(0.7);
  Color animationOverlayStrong = black.withOpacity(0.85);

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
  SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  BoxShadow boxShadow = const BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = const BoxShadow(color: Colors.transparent);
}



class PlutoniumTheme extends BaseTheme {
  static const vividYellow = Color(0xFFFFC107);

  static const green = Color(0xFF00A873);

  static const greenLight = Color(0xFF9EEDD4);

  static const grayDark = Color(0xFF212121);

  static const grayLight = Color(0xFF2e2e2e);

  static const grayDarkest = Color(0xFF080808);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF000000);

  static const firebrick = Color(0xffff0033);


  Color primary = vividYellow;
  Color primary60 = vividYellow.withOpacity(0.6);
  Color primary45 = vividYellow.withOpacity(0.45);
  Color primary30 = vividYellow.withOpacity(0.3);
  Color primary20 = vividYellow.withOpacity(0.2);
  Color primary15 = vividYellow.withOpacity(0.15);
  Color primary10 = vividYellow.withOpacity(0.1);

  Color success = green;
  Color success60 = green.withOpacity(0.6);
  Color success30 = green.withOpacity(0.3);
  Color success15 = green.withOpacity(0.15);

  Color successDark = greenLight;
  Color successDark30 = greenLight.withOpacity(0.3);

  Color error = firebrick;

  Color background = grayDark;
  Color background40 = grayDark.withOpacity(0.4);
  Color background20 = grayDark.withOpacity(0.2);
  Color background10 = grayDark.withOpacity(0.1);
  Color background00 = grayDark.withOpacity(0.0);

  Color backgroundLight = grayLight;
  Color backgroundLight10 = grayLight.withOpacity(0.1);
  Color backgroundLight00 = grayLight.withOpacity(0.0);

  Color backgroundDarkest = grayDarkest;

  Color text = white.withOpacity(0.9);
  Color text60 = white.withOpacity(0.6);
  Color text45 = white.withOpacity(0.45);
  Color text30 = white.withOpacity(0.3);
  Color text20 = white.withOpacity(0.2);
  Color text15 = white.withOpacity(0.15);
  Color text10 = white.withOpacity(0.1);
  Color text05 = white.withOpacity(0.05);
  Color text03 = white.withOpacity(0.03);

  Color overlay90 = black.withOpacity(0.9);
  Color overlay85 = black.withOpacity(0.85);
  Color overlay80 = black.withOpacity(0.8);
  Color overlay70 = black.withOpacity(0.7);
  Color overlay50 = black.withOpacity(0.5);
  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);

  Color animationOverlayMedium = black.withOpacity(0.7);
  Color animationOverlayStrong = black.withOpacity(0.85);

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
  SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);

  BoxShadow boxShadow = const BoxShadow(color: Colors.transparent);
  BoxShadow boxShadowButton = const BoxShadow(color: Colors.transparent);
}



