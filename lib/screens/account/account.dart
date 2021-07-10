// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tmdb/utils/settings_utils/image_quality_utils.dart';
import 'package:tmdb/view_models/image_quality_view_model.dart';

// Project imports:
import '../../screens/account/account_local_widgets.dart';
import '../../styles.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/reusable_widgets.dart';
import '../../utils/shared_prefs/memory_management.dart';
import '../../utils/settings_utils/theme_utils.dart';
import '../../view_models/bottom_nav_view_model.dart';
import '../../view_models/login_info_model.dart';
import '../../view_models/theme_view_model.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginInfoViewModel _loginInfoViewModel =
        Provider.of<LoginInfoViewModel>(context);

    List<Widget> _buildThemeOptions() {
      List<Widget> ret = [];
      themeOptions.values.forEach((themeOptions value) {
        ret.add(Align(
          alignment: Alignment.center,
          child: SimpleDialogOption(
            onPressed: () {
              context.read<BottomNavigationViewModel>().popWithValue(value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                ThemeSetting(value).getDisplayName(context),
                style: AppStyles.textStyleDialogOptions(context),
              ),
            ),
          ),
        ));
      });
      return ret;
    }

    Future<void> _themeDialog() async {
      themeOptions selection = await showDialog<themeOptions>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              backgroundColor:
                  Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
              children: _buildThemeOptions(),
            );
          });
      if (Provider.of<ThemeViewModel>(context, listen: false).curThemeSetting !=
          ThemeSetting(selection)) {
        MemoryManagement.setCurrentThemeSetting(
            themeSetting: ThemeSetting(selection));
        Provider.of<ThemeViewModel>(context, listen: false)
            .setTheme(ThemeSetting(selection));
      }
    }

    List<Widget> _buildImageQualityDialogOptions() {
      List<Widget> ret = [];
      imageQualityOptions.values.forEach((imageQualityOptions value) {
        ret.add(Align(
          alignment: Alignment.center,
          child: SimpleDialogOption(
            onPressed: () {
              context.read<BottomNavigationViewModel>().popWithValue(value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(
                ImageQualitySetting(value).getDisplayName(context),
                style: AppStyles.textStyleDialogOptions(context),
              ),
            ),
          ),
        ));
      });
      return ret;
    }

    Future<void> _imageQualityDialog() async {
      imageQualityOptions selection = await showDialog<imageQualityOptions>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              backgroundColor:
                  Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
              children: _buildImageQualityDialogOptions(),
            );
          });
      if (Provider.of<ImageQualityViewModel>(context, listen: false)
              .curImageQualitySetting !=
          ImageQualitySetting(selection)) {
        MemoryManagement.setCurrentImageQualitySetting(
            imageQualitySetting: ImageQualitySetting(selection));
        Provider.of<ImageQualityViewModel>(context, listen: false)
            .setImageQuality(ImageQualitySetting(selection));
   
      }
    }

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: AppConstants.kSpacingUnit * 6.0,
                width: AppConstants.kSpacingUnit * 6.0,
                margin: EdgeInsets.only(top: AppConstants.kSpacingUnit * 3.0),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppConstants.kSpacingUnit * 0.6),
                  child: getCachedNetworkImage(
                      url: _loginInfoViewModel.photoUrl, fit: BoxFit.fill),
                ),
              ),
              SizedBox(height: AppConstants.kSpacingUnit * 2.0),
              Text(
                _loginInfoViewModel.displayName ?? '-',
                style: AppStyles.textStyleParagraph(context),
              ),
              SizedBox(height: AppConstants.kSpacingUnit * 0.5),
              Text(
                _loginInfoViewModel.email,
                style: AppStyles.textStyleParagraphThinPrimary(context),
              ),
              SizedBox(height: AppConstants.kSpacingUnit * 2.0),
              // Container(
              //   height: kSpacingUnit * 4.0,
              //   width: kSpacingUnit * 20.0,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(kSpacingUnit * 3.0),
              //     color: context.watch<ThemeViewModel>().curTheme.primary,
              //   ),
              //   child: Center(
              //     child: Text(
              //       'Upgrade to PRO',
              //       // style: AppStyles.textStyleButtonBackGroundSmall(context),
              //     ),
              //   ),
              // ),

              ProfileListItem(
                icon: Icons.format_paint,
                text: 'Theme',
                onTap: () {
                  _themeDialog();
                },
                hasDialog: true,
                hasNavigation: false,
                dialogSelectedText: Provider.of<ThemeViewModel>(context)
                    .curThemeSetting
                    .getDisplayName(context),
              ),

              ProfileListItem(
                icon: Icons.image,
                text: 'Image Quality',
                onTap: () {
                  _imageQualityDialog();
                },
                hasDialog: true,
                hasNavigation: false,
                dialogSelectedText: Provider.of<ImageQualityViewModel>(context).curImageQualitySetting.getDisplayName(context),
              ),

              ProfileListItem(
                icon: Icons.logout,
                text: 'Logout',
                hasNavigation: false,
                onTap: () async {
                  await Provider.of<LoginInfoViewModel>(context, listen: false)
                      .signOut(context);
                  await context
                      .read<BottomNavigationViewModel>()
                      .navigateToAndClear("/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
