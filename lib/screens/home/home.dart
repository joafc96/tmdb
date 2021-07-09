// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../utils/assets_helper.dart';
import '../../utils/enums.dart';
import '../../utils/widgets/catergory_name.dart';
import 'scrollable_display_movie.dart';
import 'scrollable_display_tvShow.dart';
import '../../view_models/bottom_nav_view_model.dart';
import '../../view_models/home_view_model.dart';
import '../../view_models/login_info_model.dart';
import '../../view_models/theme_view_model.dart';


Map<MoviesCategories, String> movieCategoryName = {
  MoviesCategories.popular: 'Popular',
  MoviesCategories.nowPlaying: 'Now playing',
  MoviesCategories.trending: 'Trending',
  MoviesCategories.topRated: 'Top Rated',
  MoviesCategories.upcoming: 'Upcoming',
  MoviesCategories.detailsRecommended: 'Recommended',
  MoviesCategories.detailsSimilar: 'Similar'
};

Map<TvShowsCategories, String> tvShowsCategoryName = {
  TvShowsCategories.airingToday: 'Airing Today',
  TvShowsCategories.trending: 'Trending',
  TvShowsCategories.topRated: 'Top Rated',
  TvShowsCategories.popular: 'Popular',
  TvShowsCategories.detailsRecommended: 'Recommended',
  TvShowsCategories.netflix: 'Netflix',
  TvShowsCategories.disney: 'Disney+',
  TvShowsCategories.appleTv: 'Apple TV+',
  TvShowsCategories.amazonPrime: 'Amazon',
};

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with
        SingleTickerProviderStateMixin<Home>,
        AutomaticKeepAliveClientMixin<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: SizedBox(
          width: 45,
          height: 45,
          child: SvgPicture.asset(
            ImageAssets.appLogo,
            color: Provider.of<ThemeViewModel>(context).curTheme.primary,
          ),
        ),
        centerTitle: true,
    
      ),
      body: ChangeNotifierProvider(
        create: (_) => HomeViewModel(context: context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // trending movies
              Container(
                height: 230,
                child: Column(
                  children: [
                    CategoryName(
                      homeCategory: homeCategories.trendingMovies,
                      isMovie: true,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.movieState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableMovie(
                            homeCategory: homeCategories.trendingMovies,
                            isLoading: true,
                          );
                          break;
                        case ViewState.loaded:
                          return ScrollableMovie(
                            homeCategory: homeCategories.trendingMovies,
                            moviesList: _homeModel.movies[0],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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
                    CategoryName(
                      homeCategory: homeCategories.trendingTvShows,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.trendingTvShows,
                            isLoading: true,
                          );

                          break;
                        case ViewState.loaded:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.trendingTvShows,
                            tvShowsList: _homeModel.tvShows[0],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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

              // upcoming movies
              Container(
                height: 230,
                child: Column(
                  children: [
                    CategoryName(
                      homeCategory: homeCategories.upcomingMovies,
                      isMovie: true,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.movieState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableMovie(
                            homeCategory: homeCategories.upcomingMovies,
                            isLoading: true,
                          );
                          break;
                        case ViewState.loaded:
                          return ScrollableMovie(
                            homeCategory: homeCategories.upcomingMovies,
                            moviesList: _homeModel.movies[1],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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

              // airing today tv shows
              Container(
                height: 230,
                child: Column(
                  children: [
                    CategoryName(
                      homeCategory: homeCategories.airingTodayTvShows,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.airingTodayTvShows,
                            isLoading: true,
                          );

                          break;
                        case ViewState.loaded:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.airingTodayTvShows,
                            tvShowsList: _homeModel.tvShows[1],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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
                    CategoryName(
                      homeCategory: homeCategories.netflixTvSHows,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.netflixTvSHows,
                            isLoading: true,
                          );

                          break;
                        case ViewState.loaded:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.netflixTvSHows,
                            tvShowsList: _homeModel.tvShows[2],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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
                    CategoryName(
                      homeCategory: homeCategories.amazonTvSHows,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.amazonTvSHows,
                            isLoading: true,
                          );

                          break;
                        case ViewState.loaded:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.amazonTvSHows,
                            tvShowsList: _homeModel.tvShows[3],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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
                    CategoryName(
                      homeCategory: homeCategories.disneyTvSHows,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.disneyTvSHows,
                            isLoading: true,
                          );

                          break;
                        case ViewState.loaded:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.disneyTvSHows,
                            tvShowsList: _homeModel.tvShows[4],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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
                    CategoryName(
                      homeCategory: homeCategories.appleTvSHows,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.appleTvSHows,
                            isLoading: true,
                          );

                          break;
                        case ViewState.loaded:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.appleTvSHows,
                            tvShowsList: _homeModel.tvShows[5],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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
                    CategoryName(
                      homeCategory: homeCategories.hboTvShows,
                    ),
                    Builder(builder: (context) {
                      final _homeModel = Provider.of<HomeViewModel>(context);

                      switch (_homeModel.tvShowState) {
                        case ViewState.initial:
                          // TODO: Handle this case.
                          break;
                        case ViewState.loading:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.hboTvShows,
                            isLoading: true,
                          );

                          break;
                        case ViewState.loaded:
                          return ScrollableTvShow(
                            homeCategory: homeCategories.hboTvShows,
                            tvShowsList: _homeModel.tvShows[6],
                          );
                          break;
                        case ViewState.error:
                          return Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            backgroundColor: context
                                .watch<ThemeViewModel>()
                                .curTheme
                                .primary,
                          ));
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
