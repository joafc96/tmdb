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
import '../tmdb_configs.dart';

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
      height: 180,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: !isLoading
            ? tvShows.length < 20
                ? tvShows.length
                : 20
            : 5,
        padding: const EdgeInsets.only(left: 12, right: 12),
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 12,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return !isLoading
              ? RepaintBoundary(
                child: SizedBox(
                  width: 90,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
                            ),
                            height: 130,
                            child: Poster(
                              imageUrl: imageUrl + tvShows[index].posterPath,
                              heroTag:
                                  '${tvShows[index].id}${homeCategory}',
                            )),
                      ),
                      const SizedBox(height: 8.0,),
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
                  width: 90,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 130,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Provider.of<ThemeViewModel>(context)
                              .curTheme
                              .backgroundLight,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 75,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Provider.of<ThemeViewModel>(context)
                                  .curTheme
                                  .backgroundLight,
                              borderRadius: BorderRadius.circular(3.0),
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
