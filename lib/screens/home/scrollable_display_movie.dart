// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tmdb/view_models/image_quality_view_model.dart';

// Project imports:
import 'package:tmdb/view_models/theme_view_model.dart';
import '../../models/movies/movie_data.dart';
import '../../models/movies/movie_list.dart';
import '../../styles.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';
import '../../utils/tmdb_configs.dart';
import '../../utils/urls.dart';
import '../../utils/widgets/poster.dart';

class ScrollableMovie extends StatelessWidget {
  final MoviesList moviesList;
  final homeCategories homeCategory;
  final bool isLoading;

  const ScrollableMovie(
      {Key key, this.homeCategory, this.moviesList, this.isLoading = false})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    List<MoviesData> movies = !isLoading ? moviesList.movies : [];



    return Container(
      height: AppConstants.kSpacingUnit * 18.0,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: !isLoading
            ? movies.length < 20
                ? movies.length
                : 20
            : 5,
        padding: const EdgeInsets.only(left: AppConstants.kSpacingUnit * 1.2, right: AppConstants.kSpacingUnit * 1.2),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: AppConstants.kSpacingUnit * 1.2,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return !isLoading
              ? RepaintBoundary(
                child: SizedBox(
                  width: AppConstants.kSpacingUnit * 9.0,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.kSpacingUnit * 0.6),
                            color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,

                          ),
                            height: AppConstants.kSpacingUnit * 13.0,
                            child: Poster(
                              imageUrl: context.watch<ImageQualityViewModel>().curImageQuality + movies[index].posterPath,
                              heroTag:
                                  '${movies[index].id}${homeCategory}',
                            )),
                      ),
                      const SizedBox(height: AppConstants.kSpacingUnit * 0.8),
                      SizedBox(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            movies[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style:
                                AppStyles.textStyleMovieTvShowTitle(context),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              : SizedBox(
                  width: AppConstants.kSpacingUnit * 9.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: AppConstants.kSpacingUnit * 13.0,
                        width: AppConstants.kSpacingUnit * 9.0,
                        decoration: BoxDecoration(
                          color: Provider.of<ThemeViewModel>(context)
                              .curTheme
                              .backgroundLight,
                          borderRadius: BorderRadius.circular(AppConstants.kSpacingUnit * 0.6),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: AppConstants.kSpacingUnit * 0.8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: AppConstants.kSpacingUnit * 7.5,
                            height: AppConstants.kSpacingUnit * 1.5,
                            decoration: BoxDecoration(
                              color: Provider.of<ThemeViewModel>(context)
                                  .curTheme
                                  .backgroundLight,
                              borderRadius: BorderRadius.circular(AppConstants.kSpacingUnit * 0.3),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
