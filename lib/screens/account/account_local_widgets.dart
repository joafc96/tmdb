import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../styles.dart';
import '../../utils/assets_helper.dart';
import '../../utils/constants.dart';
import '../../view_models/theme_view_model.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final VoidCallback onTap;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppConstants.kSpacingUnit * 5.5,
        margin: EdgeInsets.symmetric(
          horizontal: AppConstants.kSpacingUnit * 4.0,
        ).copyWith(
          bottom: AppConstants.kSpacingUnit * 2.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.kSpacingUnit * 2.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.kSpacingUnit * 3.0),
          color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: AppConstants.kSpacingUnit * 2.0,
            ),
            SizedBox(width: AppConstants.kSpacingUnit * 2.0),
            Text(
              this.text,
              style: AppStyles.textStyleParagraphThinPrimary(context),
            ),
            Spacer(),
            if (this.hasNavigation)
              SvgPicture.asset(
                ImageAssets.chevron_right,
                color: Provider.of<ThemeViewModel>(context).curTheme.text,
                height: (AppConstants.kSpacingUnit * 2.5),
              ),
          ],
        ),
      ),
    );
  }
}
