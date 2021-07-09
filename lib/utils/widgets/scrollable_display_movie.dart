import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/view_models/theme_view_model.dart';
import '../../models/movies/movie_data.dart';
import '../../models/movies/movie_list.dart';
import '../../utils/enums.dart';
import '../../utils/urls.dart';
import '../../utils/widgets/poster.dart';

import '../../styles.dart';
import '../tmdb_configs.dart';

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

    String imageUrl = URLS.imageBaseUrl;

    imageUrl = imageUrl + PosterSizes.w500;

    return Container(
      height: 180,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: !isLoading
            ? movies.length < 20
                ? movies.length
                : 20
            : 5,
        padding: const EdgeInsets.only(left: 12, right: 12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
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
                              imageUrl: imageUrl + movies[index].posterPath,
                              heroTag:
                                  '${movies[index].id}${homeCategory}',
                            )),
                      ),
                      const SizedBox(height: 8.0,),
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
