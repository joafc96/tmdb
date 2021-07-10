// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../styles.dart';
import '../../utils/assets_helper.dart';
import '../../utils/constants.dart';
import '../../view_models/theme_view_model.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final bool hasDialog;
  final String dialogSelectedText;
  final VoidCallback onTap;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.hasDialog = false,
    this.dialogSelectedText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppConstants.kSpacingUnit * 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: AppConstants.kSpacingUnit * 4.0,
        ).copyWith(
          bottom: AppConstants.kSpacingUnit * 2.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.kSpacingUnit * 2.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.kSpacingUnit * 0.6),
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
              style: AppStyles.textStyleParagraph(context),
            ),
            Spacer(),
            if (this.hasNavigation)
              SvgPicture.asset(
                ImageAssets.chevron_right,
                color: Provider.of<ThemeViewModel>(context).curTheme.text,
                height: (AppConstants.kSpacingUnit * 2.5),
              ),
            if (this.hasDialog)
              Text(
                this.dialogSelectedText,
                style: AppStyles.textStyleParagraphThinPrimary(context).copyWith(fontSize: 10.0),
              ),
          ],
        ),
      ),
    );
  }
}
