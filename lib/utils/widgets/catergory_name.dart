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
import 'package:tmdb/view_models/theme_view_model.dart';
import '../constants.dart';

Map<homeCategories, String> homeCategoryName = {
  homeCategories.trendingMovies: "Trending",
  homeCategories.trendingTvShows: "Trending",
  homeCategories.nowPlayingMovies: "Now Playing",
  homeCategories.airingTodayTvShows: "Airing Today",
  homeCategories.upcomingMovies: "Upcoming",
  homeCategories.netflixTvSHows: "Netflix",
  homeCategories.amazonTvSHows: "Amazon",
  homeCategories.disneyTvSHows: "Disney+",
  homeCategories.appleTvSHows: "Apple TV+",
  homeCategories.hboTvShows: "HBO",
};

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
      padding: const EdgeInsets.only(left: AppConstants.kSpacingUnit * 1.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: AppConstants.kSpacingUnit * 0.4,
            height: AppConstants.kSpacingUnit * 2.0,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppConstants.kSpacingUnit * 0.6),
                color: Provider.of<ThemeViewModel>(context).curTheme.primary),
          ),
          const SizedBox(
            width: AppConstants.kSpacingUnit * 0.6,
          ),
          Text(
            homeCategoryName[homeCategory],
            style: AppStyles.textStyleHeader(context),
          ),
          const SizedBox(
            width: AppConstants.kSpacingUnit * 0.6,
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
                width: AppConstants.kSpacingUnit * 3.5,
                height: AppConstants.kSpacingUnit * 3.5,
                color: Provider.of<ThemeViewModel>(context).curTheme.text),
          )
        ],
      ),
    );
  }
}
