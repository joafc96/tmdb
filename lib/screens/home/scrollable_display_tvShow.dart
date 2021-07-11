// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tmdb/view_models/setting_view_models/image_quality_view_model.dart';

// Project imports:
import '../../models/tv_shows/tv_shows_data.dart';
import '../../models/tv_shows/tv_shows_list.dart';
import '../../styles.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';

import '../../utils/widgets/poster.dart';
import '../../view_models/setting_view_models/theme_view_model.dart';

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

    return SizedBox(
      height: kSpacingUnit * 18.0,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: !isLoading
            ? tvShows.length < 20
                ? tvShows.length
                : 20
            : 5,
        padding: const EdgeInsets.only(left: kSpacingUnit * 0.8, right: kSpacingUnit * 0.8),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: kSpacingUnit * 0.8,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return !isLoading
              ? RepaintBoundary(
                child: SizedBox(
                  width: kSpacingUnit * 9.0,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(kSpacingUnit * 0.6),
                              color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
                            ),
                            height: kSpacingUnit * 13.0,
                            child: Poster(
                              imageUrl: context.watch<ImageQualityViewModel>().curImageQuality + tvShows[index].posterPath,
                              heroTag:
                                  '${tvShows[index].id}${homeCategory}',
                            )),
                      ),
                      const SizedBox(height: kSpacingUnit * 0.8),
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
                  width: kSpacingUnit * 9.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: kSpacingUnit * 13.0,
                        width: kSpacingUnit * 9.0,
                        decoration: BoxDecoration(
                          color: Provider.of<ThemeViewModel>(context)
                              .curTheme
                              .backgroundLight,
                          borderRadius: BorderRadius.circular(kSpacingUnit * 0.6),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: kSpacingUnit * 0.8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: kSpacingUnit * 7.5,
                            height: kSpacingUnit * 1.5,
                            decoration: BoxDecoration(
                              color: Provider.of<ThemeViewModel>(context)
                                  .curTheme
                                  .backgroundLight,
                              borderRadius: BorderRadius.circular(kSpacingUnit * 0.3),
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
