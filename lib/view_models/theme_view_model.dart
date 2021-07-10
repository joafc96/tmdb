// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../utils/enums.dart';
import '../themes.dart';
import '../utils/settings_utils/theme_utils.dart';

class ThemeViewModel with ChangeNotifier {
  ThemeViewModel({ThemeSetting themeSetting}) {
    setTheme(themeSetting);
  }

  BaseTheme _curTheme = PlutoniumTheme();

  ThemeSetting _curThemeSetting = ThemeSetting(themeOptions.plutonium);

  BaseTheme get curTheme => _curTheme;

  ThemeSetting get curThemeSetting => _curThemeSetting;

  void setTheme(ThemeSetting themeSetting) {
    _curTheme = themeSetting.getTheme();
    _curThemeSetting = themeSetting;
    notifyListeners();
  }
}
