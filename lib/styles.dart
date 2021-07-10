// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:tmdb/view_models/theme_view_model.dart';

class AppStyles {
  // Version info in settings
  static TextStyle textStyleVersion(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w100,
        color: Provider.of<ThemeViewModel>(context).curTheme.text60);
  }

  // For snackbar/Toast text
  static TextStyle textStyleSnackbar(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context, listen: false)
            .curTheme
            .background);
  }

  // Text style for error text.
  static TextStyle textStyleError(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.smallest,
        fontWeight: FontWeight.w200,
        color: Provider.of<ThemeViewModel>(context).curTheme.error);
  }

  // Text style for paragraph text.
  static TextStyle textStyleParagraph(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w200,
        color: Provider.of<ThemeViewModel>(context).curTheme.text);
  }

  // Text style for title text.
  static TextStyle textStyleMovieTvShowTitle(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes.smallest,
      fontWeight: FontWeight.w200,
      color: Provider.of<ThemeViewModel>(context).curTheme.text60,
    );
  }

  // Text style for category subTitle
  static TextStyle textStyleCategorySubTitle(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes._ssSmallest,
        fontWeight: FontWeight.w100,
        letterSpacing: 0.5,
        color: Provider.of<ThemeViewModel>(context).curTheme.text60);
  }

  // Text style for thin paragraph text with primary color.
  static TextStyle textStyleParagraphThinPrimary(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w400,
        color: Provider.of<ThemeViewModel>(context).curTheme.primary);
  }

  // Text style for paragraph text with primary color.
  static TextStyle textStyleParagraphPrimary(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.primary);
  }

  static TextStyle buttonTextBg(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      color: Provider.of<ThemeViewModel>(context).curTheme.background,
      fontWeight: FontWeight.w700,
    );
  }

  // Text style for primary header
  static TextStyle headerPrimary(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: Provider.of<ThemeViewModel>(context).curTheme.primary,
      fontWeight: FontWeight.w700,
    );
  }

  // Text style for primary color header
  static TextStyle textStyleHeaderPrimary(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes._largest,
      fontWeight: FontWeight.w700,
      color: Provider.of<ThemeViewModel>(context).curTheme.primary,
    );
  }

  // Text style for general headers
  static TextStyle textStyleHeader(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes.largest(context),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      color: Provider.of<ThemeViewModel>(context).curTheme.text,
    );
  }

  // Text style for primary button or background
  static TextStyle textStyleButtonBackGround(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.background);
  }

  // Text style for primary button or background small
  static TextStyle textStyleButtonBackGroundSmall(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.background);
  }

  // Text style for primary button or background medium
  static TextStyle textStyleButtonBackGroundMedium(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.background);
  }

  // Text style for background button
  static TextStyle textStyleButtonPrimary(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.primary);
  }

  // Text style for small background button
  static TextStyle textStyleButtonPrimarySmall(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.primary);
  }

  // Text style for medium background button
  static TextStyle textStyleButtonPrimaryMedium(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.primary);
  }

  static TextStyle textStyleButtonPrimaryDisabled(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.primary60);
  }

  // Text style for  success outline button
  static TextStyle textStyleButtonSuccess(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.success);
  }

  // Text style for small success outline button
  static TextStyle textStyleButtonSuccessSmall(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.success);
  }

  // Text style for small success outline button
  static TextStyle textStyleButtonSuccessMedium(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.success);
  }

  // Text style for  success outline button
  static TextStyle textStyleButtonSuccessDisabled(BuildContext context) {
    return TextStyle(
        fontSize: AppFontSizes._large,
        fontWeight: FontWeight.w700,
        color: Provider.of<ThemeViewModel>(context).curTheme.success60);
  }

   // Text style for alert dialog header
  static TextStyle textStyleDialogHeader(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes._large,
      fontWeight: FontWeight.w700,
      color: Provider.of<ThemeViewModel>(context).curTheme.primary,
    );
  }

  // Text style for dialog options
  static TextStyle textStyleDialogOptions(BuildContext context) {
    return TextStyle(
      fontSize: AppFontSizes.medium,
      fontWeight: FontWeight.w400,
      color: Provider.of<ThemeViewModel>(context).curTheme.text,
    );
  }
}

 

class AppFontSizes {
  static const _ssSmallest = 10.0;
  static const smallest = 12.0;
  static const small = 14.0;
  static const medium = 16.0;
  static const _large = 20.0;
  static const larger = 24.0;
  static const _largest = 28.0;
  static const largestc = 28.0;
  static const _sslarge = 18.0;
  static const _sslargest = 22.0;
  static double largest(BuildContext context) {
    if (smallScreen(context)) {
      return _sslargest;
    }
    return _largest;
  }

  static double large(BuildContext context) {
    if (smallScreen(context)) {
      return _sslarge;
    }
    return _large;
  }

  static double smallText(BuildContext context) {
    if (smallScreen(context)) {
      return smallest;
    }
    return small;
  }
}

bool smallScreen(BuildContext context) {
  if (MediaQuery.of(context).size.height < 667) {
    return true;
  } else {
    return false;
  }
}
