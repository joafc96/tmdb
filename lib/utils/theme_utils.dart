// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../themes.dart';
import 'enums.dart';

/// Represent notification on/off setting
class ThemeSetting {
  themeOptions theme;

  ThemeSetting(this.theme);

  String getDisplayName(BuildContext context) {
    switch (theme) {
      case themeOptions.thorium:
        return "Thorium";
      case themeOptions.neptunium:
        return "Neptunium";
      case themeOptions.indium:
        return "Indium";
      case themeOptions.titanium:
        return "Titanium";
      case themeOptions.plutonium:
        return "Plutonium";
      case themeOptions.natrium:
      default:
        return "Natrium";
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case themeOptions.thorium:
        return ThoriumTheme();
      case themeOptions.neptunium:
        return NeptuniumTheme();
      case themeOptions.indium:
        return IndiumTheme();
      case themeOptions.titanium:
        return TitaniumTheme();
      case themeOptions.plutonium:
        return PlutoniumTheme();
      case themeOptions.natrium:
      default:
        return NatriumTheme();
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return theme.index;
  }
}
