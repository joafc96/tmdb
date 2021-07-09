import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/styles.dart';
import 'package:tmdb/utils/assets_helper.dart';
import 'package:tmdb/utils/enums.dart';
import 'package:tmdb/view_models/theme_view_model.dart';

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

  const CategoryName(
      {Key key, @required this.homeCategory, this.isMovie = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Provider.of<ThemeViewModel>(context).curTheme.primary
              ),
            ),
            const SizedBox(width: 6.0,),

            Text(
              homeCategoryName[homeCategory],
              style: AppStyles.textStyleHeader(context),
            ),
            const SizedBox(width: 6.0,),

            Text(
              isMovie ? "MOVIES" : "TV SHOWS",
              style: AppStyles.textStyleCategorySubTitle(context),
            ),


            const Spacer(),
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                // _navigateToSeeAllMovies(context, category, moviesList);
              },
              child: SizedBox(
                height: 35,
                width: 35,
                child: SvgPicture.asset(ImageAssets.chevron_right, color: Provider.of<ThemeViewModel>(context).curTheme.text),

              )
            )
          ],
        ),

    );
  }
}
