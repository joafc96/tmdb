// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:tmdb/styles.dart';
import 'package:tmdb/utils/assets_helper.dart';
import 'package:tmdb/utils/enums.dart';
import 'package:tmdb/view_models/setting_view_models/theme_view_model.dart';
import '../constants.dart';



class CategoryName extends StatelessWidget {
  final homeCategories homeCategory;
  final bool isMovie;
  final VoidCallback onPressed;

  const CategoryName(
      {Key key, @required this.homeCategory, this.isMovie = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: kSpacingUnit * 1.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: kSpacingUnit * 0.4,
            height: kSpacingUnit * 2.0,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(kSpacingUnit * 0.6),
                color: Provider.of<ThemeViewModel>(context).curTheme.primary),
          ),
          const SizedBox(
            width: kSpacingUnit * 0.6,
          ),
          Text(
            homeCategoryName[homeCategory],
            style: AppStyles.textStyleHeader(context),
          ),
          const SizedBox(
            width: kSpacingUnit * 0.6,
          ),
          Text(
            isMovie ? "MOVIES" : "TV SHOWS",
            style: AppStyles.textStyleCategorySubTitle(context),
          ),
          const Spacer(),
          CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: onPressed,
            child: SvgPicture.asset(ImageAssets.chevron_right,
                width: kSpacingUnit * 3.5,
                height: kSpacingUnit * 3.5,
                color: Provider.of<ThemeViewModel>(context).curTheme.text),
          )
        ],
      ),
    );
  }
}
