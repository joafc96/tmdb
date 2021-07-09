import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import '../../styles.dart';
import '../../utils/enums.dart';
import '../../utils/shared_prefs/memory_management.dart';
import '../../utils/theme_utils.dart';
import '../../view_models/theme_view_model.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: themeOptions.values.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      locator.get<Logger>().d(themeOptions.values[index]);
                      Provider.of<ThemeViewModel>(context, listen: false)
                          .setTheme(ThemeSetting(themeOptions.values[index]));
                      Provider.of<ThemeViewModel>(context, listen: false)
                          .setThemeSetting(themeOptions.values[index]);
                      MemoryManagement.setCurrentThemeSetting(
                          themeSetting:
                              ThemeSetting(themeOptions.values[index]));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        ThemeSetting(themeOptions.values[index])
                            .getDisplayName(context),
                        style: AppStyles.textStyleParagraph(context)
                            .copyWith(letterSpacing: 0.5),
                      ),
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
