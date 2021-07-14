import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:tmdb/utils/reusable_widgets.dart';
import 'package:tmdb/utils/tmdb_configs.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/view_models/setting_view_models/image_quality_view_model.dart';
import '../../view_models/bottom_nav_view_model.dart';
import '../../view_models/setting_view_models/grid_count_view_model.dart';
import '../../models/movies/movie_data.dart';
import '../../models/movies/movie_list.dart';
import '../../styles.dart';
import '../../utils/assets_helper.dart';
import '../../utils/constants.dart';
import '../../view_models/see_all_movies_view_model.dart';
import '../../view_models/setting_view_models/theme_view_model.dart';
import '../../utils/enums.dart';
import '../../utils/scroll_controller_util.dart';

class SeeAllMovies extends StatefulWidget {
  static Widget create(arguments) {
    return ChangeNotifierProvider(
      create: (_) => SeeAllMoviesViewModel(arguments['movies_list']),
      child: SeeAllMovies(
          moviesCategory: arguments['movie_category'],
          moviesList: arguments['movies_list'],
          movieId: arguments['movie_id']),
    );
  }

  final MoviesCategories moviesCategory;
  final MoviesList moviesList;
  final int movieId;

  SeeAllMovies(
      {Key key, this.moviesCategory, @required this.moviesList, this.movieId})
      : assert(moviesList != null),
        super(key: key);

  @override
  _SeeAllMoviesState createState() => _SeeAllMoviesState();
}

class _SeeAllMoviesState extends State<SeeAllMovies> {
  final _scrollControllerUtil = ScrollControllerUtil();

  @override
  void initState() {
    super.initState();
    _scrollControllerUtil.addScrollListener(() {
      if (!(context.read<SeeAllMoviesViewModel>().state == ViewState.loading)) {
        context.read<SeeAllMoviesViewModel>().getMovies(
            context: context,
            movieId: widget.movieId,
            moviesCategory: widget.moviesCategory);
      }
    });
  }

  @override
  void dispose() {
    _scrollControllerUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MoviesList moviesList =
        Provider.of<SeeAllMoviesViewModel>(context).moviesList;
    final movies = moviesList.movies;

    return Scaffold(
        appBar: ScrollAppBar(
          elevation: 0.0,
          centerTitle: true,
          leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: SvgPicture.asset(
                ImageAssets.chevron_left,
                width: kSpacingUnit * 3.5,
                height: kSpacingUnit * 3.5,
                color: Provider.of<ThemeViewModel>(context).curTheme.text,
              ),
              onPressed: () {
                context.read<BottomNavigationViewModel>().pop();
              }),
          controller: _scrollControllerUtil.scrollController,
          title: Text(
            movieCategoryName[widget.moviesCategory],
            style: AppStyles.headerText(context).copyWith(letterSpacing: 0.2),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kSpacingUnit * 1.2, vertical: kSpacingUnit * 1.2),
          child: GridView.builder(
            controller: _scrollControllerUtil.scrollController,
            cacheExtent: 12,
            itemCount: movies.length,
            itemBuilder: (context, index) => _Tile(index, movies[index]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  Provider.of<GridCountViewModel>(context).curGridCount,
              childAspectRatio: 0.8 / 1.2,
              crossAxisSpacing: kSpacingUnit * 1.2,
              mainAxisSpacing: kSpacingUnit * 1.2,
            ),
          ),
        ));
  }
}

class _Tile extends StatefulWidget {
  const _Tile(this.index, this.movieData);

  final MoviesData movieData;
  final int index;

  @override
  __TileState createState() => __TileState();
}

class __TileState extends State<_Tile> {
  String _tilePosterSize;

  @override
  void dispose() {
    CachedNetworkImage.evictFromCache(
        '${URLS.imageBaseUrl}${_tilePosterSize}${widget.movieData.posterPath}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tilePosterSize = Provider.of<GridCountViewModel>(context).curGridCount == 4
        ? PosterSizes.w185
        : Provider.of<GridCountViewModel>(context).curGridCount == 3
            ? PosterSizes.w342
            : PosterSizes.w500;

    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
            color:
                Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
            borderRadius:
                const BorderRadius.all(Radius.circular(kSpacingUnit * 0.6))),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.all(Radius.circular(kSpacingUnit * 0.6)),
                child: getCachedNetworkImage(
                    url:
                        '${URLS.imageBaseUrl}${_tilePosterSize}${widget.movieData.posterPath}')),
            widget.index == 1 || widget.index == 2 || widget.index == 10
                ? Positioned(
                    bottom: -5,
                    right: 8,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Provider.of<ThemeViewModel>(context)
                              .curTheme
                              .background,
                          shape: BoxShape.circle),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: SvgPicture.asset(
                          ImageAssets.bookmark,
                          color: Provider.of<ThemeViewModel>(context)
                              .curTheme
                              .success,
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            widget.index == 1 || widget.index == 2 || widget.index == 10
                ? Positioned(
                    bottom: -5,
                    right: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          color: Provider.of<ThemeViewModel>(context)
                              .curTheme
                              .background,
                          shape: BoxShape.circle),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        child: SvgPicture.asset(
                          ImageAssets.heart,
                          color: Provider.of<ThemeViewModel>(context)
                              .curTheme
                              .primary,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
