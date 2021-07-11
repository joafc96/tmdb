import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../../view_models/bottom_nav_view_model.dart';
import '../../view_models/setting_view_models/grid_count_view_model.dart';
import '../../models/movies/movie_data.dart';
import '../../models/movies/movie_list.dart';
import '../../styles.dart';
import '../../utils/assets_helper.dart';
import '../../utils/constants.dart';
import '../../view_models/setting_view_models/image_quality_view_model.dart';
import '../../view_models/see_all_movies_view_model.dart';
import '../../view_models/setting_view_models/theme_view_model.dart';
import '../../utils/enums.dart';
import '../../utils/scroll_controller_util.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
      {Key key,
      this.moviesCategory,
      @required this.moviesList,
      this.movieId})
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
      if (!(context.read<SeeAllMoviesViewModel>().state ==
          ViewState.loading)) {
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
          onPressed: () => context.read<BottomNavigationViewModel>().pop(),
        ),
        controller:
            _scrollControllerUtil.scrollController,
        title: Text(
          movieCategoryName[widget.moviesCategory],
          style: AppStyles.headerPrimary(context)
              .copyWith(fontSize: 22, letterSpacing: 0.2),
        ),
      ),
      body: Builder(builder: (context) {
        final MoviesList moviesList =
            Provider.of<SeeAllMoviesViewModel>(context).moviesList;
        final movies = moviesList.movies;

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpacingUnit * 0.8, vertical: kSpacingUnit * 0.8),
            child: StaggeredGridView.countBuilder(
              itemCount: movies.length,
              controller: _scrollControllerUtil.scrollController,
              // primary: false,
              crossAxisCount: Provider.of<GridCountViewModel>(context).curGridCount,
              crossAxisSpacing: kSpacingUnit * 0.8,
              mainAxisSpacing: kSpacingUnit * 0.8,
              itemBuilder: (context, index) => _Tile(index, movies[index]),
              staggeredTileBuilder: (index) =>
                  StaggeredTile.count(1, 1.6),
            ),
          );
      }),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.movieData);

  final MoviesData movieData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
          borderRadius: const BorderRadius.all(Radius.circular(kSpacingUnit * 0.6))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(kSpacingUnit * 0.6)),
        child: FadeInImage.memoryNetwork(
          // fadeInDuration: const Duration(milliseconds: 300),
          placeholder:   kTransparentImage,
          image: Provider.of<ImageQualityViewModel>(context).curImageQuality +
              movieData.posterPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
