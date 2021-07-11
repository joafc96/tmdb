// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../styles.dart';
import '../../utils/assets_helper.dart';
import '../../utils/constants.dart';
import '../../view_models/setting_view_models/theme_view_model.dart';

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
        height: kSpacingUnit * 5.0,
        margin: EdgeInsets.symmetric(
          horizontal: kSpacingUnit * 4.0,
        ).copyWith(
          bottom: kSpacingUnit * 2.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingUnit * 2.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit * 0.6),
          color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: kSpacingUnit * 2.0,
            ),
            SizedBox(width: kSpacingUnit * 2.0),
            Text(
              this.text,
              style: AppStyles.textStyleParagraph(context),
            ),
            Spacer(),
            if (this.hasNavigation)
              SvgPicture.asset(
                ImageAssets.chevron_right,
                color: Provider.of<ThemeViewModel>(context).curTheme.text,
                height: (kSpacingUnit * 2.5),
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
