// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import '../../models/movies/movie_list.dart';
import '../../models/tv_shows/tv_shows_list.dart';
import '../../screens/home/scrollable_display_movie.dart';
import '../../view_models/bottom_nav_view_model.dart';

// Project imports:
import '../../utils/assets_helper.dart';
import '../../utils/enums.dart';
import '../../utils/widgets/catergory_name.dart';
import '../../view_models/home_view_model.dart';
import '../../view_models/setting_view_models/theme_view_model.dart';
import 'scrollable_display_tvShow.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with
        SingleTickerProviderStateMixin<Home>,
        AutomaticKeepAliveClientMixin<Home> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // methods
    _navigateToSeeAllTvShows(
        {String route,
        TvShowsCategories tvShowsCategory,
        TvShowsList tvShowsList,
        int tvShowId = null}) {
      Provider.of<BottomNavigationViewModel>(context, listen: false)
          .navigateTo(route, arguments: {
        "tv_show_category": tvShowsCategory,
        "tv_shows_list": tvShowsList,
        "tv_show_id": tvShowId
      });
    }

    _navigateToSeeAllMovies(
        {String route,
        MoviesCategories moviecategory,
        MoviesList moviesList,
        int movieId = null}) {
      Provider.of<BottomNavigationViewModel>(context, listen: false)
          .navigateTo(route, arguments: {
        "movie_category": moviecategory,
        "movies_list": moviesList,
        "movie_id": movieId
      });
    }

    return Scaffold(
      appBar: ScrollAppBar(
        elevation: 0.0,
        centerTitle: true,
        controller: _scrollController,
        title: SizedBox(
          width: 45,
          height: 45,
          child: SvgPicture.asset(
            ImageAssets.appLogo,
            color: Provider.of<ThemeViewModel>(context).curTheme.primary,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => HomeViewModel(context: context),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // trending movies
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.movieState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingMovies,
                                  isMovie: true,
                                  onPressed: null),
                              ScrollableMovie(
                                homeCategory: homeCategories.trendingMovies,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingMovies,
                                  isMovie: true,
                                  onPressed: () {
                                    _navigateToSeeAllMovies(
                                        route: '/seeAllMovies',
                                        moviecategory:
                                            MoviesCategories.trending,
                                        moviesList: _homeModel.movies[0]);
                                  }),
                              ScrollableMovie(
                                homeCategory: homeCategories.trendingMovies,
                                moviesList: _homeModel.movies[0],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingMovies,
                                  isMovie: true,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableMovie(
                        homeCategory: homeCategories.trendingMovies,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // trending tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingTvShows,
                                  onPressed: null),
                              ScrollableTvShow(
                                homeCategory: homeCategories.trendingTvShows,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingTvShows,
                                  onPressed: () {
                                    _navigateToSeeAllTvShows(
                                        route: '/seeAllTvShows',
                                        tvShowsCategory:
                                            TvShowsCategories.trending,
                                        tvShowsList: _homeModel.tvShows[0]);
                                  }),
                              ScrollableTvShow(
                                homeCategory: homeCategories.trendingTvShows,
                                tvShowsList: _homeModel.tvShows[0],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingTvShows,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableTvShow(
                        homeCategory: homeCategories.trendingTvShows,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // now playing movies
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.movieState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.nowPlayingMovies,
                                  isMovie: true,
                                  onPressed: null),
                              ScrollableMovie(
                                homeCategory: homeCategories.nowPlayingMovies,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.nowPlayingMovies,
                                  isMovie: true,
                                  onPressed: () {
                                    _navigateToSeeAllMovies(
                                        route: '/seeAllMovies',
                                        moviecategory:
                                            MoviesCategories.nowPlaying,
                                        moviesList: _homeModel.movies[1]);
                                  }),
                              ScrollableMovie(
                                homeCategory: homeCategories.nowPlayingMovies,
                                moviesList: _homeModel.movies[1],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.nowPlayingMovies,
                                  isMovie: true,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableMovie(
                        homeCategory: homeCategories.nowPlayingMovies,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // upcoming movies
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.movieState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.upcomingMovies,
                                  isMovie: true,
                                  onPressed: null),
                              ScrollableMovie(
                                homeCategory: homeCategories.upcomingMovies,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.upcomingMovies,
                                  isMovie: true,
                                  onPressed: () {
                                    _navigateToSeeAllMovies(
                                        route: '/seeAllMovies',
                                        moviecategory:
                                            MoviesCategories.upcoming,
                                        moviesList: _homeModel.movies[2]);
                                  }),
                              ScrollableMovie(
                                homeCategory: homeCategories.upcomingMovies,
                                moviesList: _homeModel.movies[2],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.upcomingMovies,
                                  isMovie: true,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableMovie(
                        homeCategory: homeCategories.upcomingMovies,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // airing today tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingTvShows,
                                  onPressed: null),
                              ScrollableTvShow(
                                homeCategory: homeCategories.trendingTvShows,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory:
                                      homeCategories.airingTodayTvShows,
                                  onPressed: () {
                                    _navigateToSeeAllTvShows(
                                        route: '/seeAllTvShows',
                                        tvShowsCategory:
                                            TvShowsCategories.airingToday,
                                        tvShowsList: _homeModel.tvShows[1]);
                                  }),
                              ScrollableTvShow(
                                homeCategory: homeCategories.airingTodayTvShows,
                                tvShowsList: _homeModel.tvShows[1],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory:
                                      homeCategories.airingTodayTvShows,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableTvShow(
                        homeCategory: homeCategories.airingTodayTvShows,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // netflix tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.netflixTvSHows,
                                  onPressed: null),
                              ScrollableTvShow(
                                homeCategory: homeCategories.netflixTvSHows,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.netflixTvSHows,
                                  onPressed: () {
                                    _navigateToSeeAllTvShows(
                                        route: '/seeAllTvShows',
                                        tvShowsCategory:
                                            TvShowsCategories.netflix,
                                        tvShowsList: _homeModel.tvShows[2]);
                                  }),
                              ScrollableTvShow(
                                homeCategory: homeCategories.netflixTvSHows,
                                tvShowsList: _homeModel.tvShows[2],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.netflixTvSHows,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableTvShow(
                        homeCategory: homeCategories.netflixTvSHows,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // amazon tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.trendingTvShows,
                                  onPressed: null),
                              ScrollableTvShow(
                                homeCategory: homeCategories.trendingTvShows,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.amazonTvSHows,
                                  onPressed: () {
                                    _navigateToSeeAllTvShows(
                                        route: '/seeAllTvShows',
                                        tvShowsCategory:
                                            TvShowsCategories.amazonPrime,
                                        tvShowsList: _homeModel.tvShows[3]);
                                  }),
                              ScrollableTvShow(
                                homeCategory: homeCategories.trendingTvShows,
                                tvShowsList: _homeModel.tvShows[3],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.amazonTvSHows,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableTvShow(
                        homeCategory: homeCategories.amazonTvSHows,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // disney tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.disneyTvSHows,
                                  onPressed: null),
                              ScrollableTvShow(
                                homeCategory: homeCategories.disneyTvSHows,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.disneyTvSHows,
                                  onPressed: () {
                                    _navigateToSeeAllTvShows(
                                        route: '/seeAllTvShows',
                                        tvShowsCategory:
                                            TvShowsCategories.disney,
                                        tvShowsList: _homeModel.tvShows[4]);
                                  }),
                              ScrollableTvShow(
                                homeCategory: homeCategories.disneyTvSHows,
                                tvShowsList: _homeModel.tvShows[4],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.disneyTvSHows,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableTvShow(
                        homeCategory: homeCategories.disneyTvSHows,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // apple tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.appleTvSHows,
                                  onPressed: null),
                              ScrollableTvShow(
                                homeCategory: homeCategories.appleTvSHows,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.appleTvSHows,
                                  onPressed: () {
                                    _navigateToSeeAllTvShows(
                                        route: '/seeAllTvShows',
                                        tvShowsCategory:
                                            TvShowsCategories.appleTv,
                                        tvShowsList: _homeModel.tvShows[5]);
                                  }),
                              ScrollableTvShow(
                                homeCategory: homeCategories.appleTvSHows,
                                tvShowsList: _homeModel.tvShows[5],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.appleTvSHows,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableTvShow(
                        homeCategory: homeCategories.appleTvSHows,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),

              // hbo tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.hboTvShows,
                                  onPressed: null),
                              ScrollableTvShow(
                                homeCategory: homeCategories.hboTvShows,
                                isLoading: true,
                              ),
                            ],
                          );
                          break;
                        case ViewState.loaded:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.hboTvShows,
                                  onPressed: () {
                                    _navigateToSeeAllTvShows(
                                        route: '/seeAllTvShows',
                                        tvShowsCategory: TvShowsCategories.hbo,
                                        tvShowsList: _homeModel.tvShows[6]);
                                  }),
                              ScrollableTvShow(
                                homeCategory: homeCategories.hboTvShows,
                                tvShowsList: _homeModel.tvShows[6],
                              ),
                            ],
                          );
                          break;
                        case ViewState.error:
                          return Column(
                            children: [
                              CategoryName(
                                  homeCategory: homeCategories.hboTvShows,
                                  onPressed: null),
                              Center(
                                  child: CircularProgressIndicator(
                                strokeWidth: 1.0,
                                backgroundColor: context
                                    .watch<ThemeViewModel>()
                                    .curTheme
                                    .primary,
                              )),
                            ],
                          );
                          break;
                      }
                      return ScrollableTvShow(
                        homeCategory: homeCategories.hboTvShows,
                        isLoading: true,
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
