import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../models/tv_shows/tv_shows_data.dart';
import '../../models/tv_shows/tv_shows_list.dart';
import '../../utils/enums.dart';
import '../../utils/urls.dart';
import '../../utils/widgets/poster.dart';
import '../../view_models/theme_view_model.dart';

import '../../styles.dart';
import '../../utils/constants.dart';
import '../../utils/tmdb_configs.dart';

class ScrollableTvShow extends StatelessWidget {
  final TvShowsList tvShowsList;
  final homeCategories homeCategory;
  final bool isLoading;

  const ScrollableTvShow(
      {Key key,
      @required this.homeCategory,
      this.tvShowsList,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TvShowsData> tvShows =
        !isLoading ? tvShowsList.tvShows : [];

    String imageUrl = URLS.imageBaseUrl;

    imageUrl = imageUrl + PosterSizes.w500;

    return SizedBox(
      height: AppConstants.kSpacingUnit * 18.0,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: !isLoading
            ? tvShows.length < 20
                ? tvShows.length
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
                              imageUrl: imageUrl + tvShows[index].posterPath,
                              heroTag:
                                  '${tvShows[index].id}${homeCategory}',
                            )),
                      ),
                      const SizedBox(height: AppConstants.kSpacingUnit * 0.8),
                      SizedBox(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tvShows[index].name,
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
