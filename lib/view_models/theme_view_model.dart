// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tmdb/utils/enums.dart';

// Project imports:
import '../utils/theme_utils.dart';
import '../themes.dart';

class ThemeViewModel with ChangeNotifier {

  ThemeViewModel({ThemeSetting themeSetting}) {
    setTheme(themeSetting);
  }

  BaseTheme _curTheme = PlutoniumTheme();

  ThemeSetting _curThemeSetting = ThemeSetting(themeOptions.plutonium);


  BaseTheme get curTheme => _curTheme;

  ThemeSetting get curThemeSetting => _curThemeSetting;

  void setTheme(ThemeSetting theme)  {
    _curTheme = theme.getTheme();
    notifyListeners();
  }

  void setThemeSetting(themeOptions theme)  {
    _curThemeSetting = ThemeSetting(theme);
    notifyListeners();
  }


}
