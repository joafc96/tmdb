import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import '../models/movies/movie_list.dart';
import '../models/tv_shows/tv_shows_list.dart';
import '../repositories/movies/movies_repo.dart';
import '../repositories/tvShows/tv_shows_repo.dart';
import '../services/network/custom_exceptions.dart';
import '../utils/enums.dart';
import '../utils/reusable_widgets.dart';

import '../locator.dart';

class HomeViewModel with ChangeNotifier {
  final Logger log = locator.get<Logger>();
  final MoviesRepo _moviesRepo = locator.get<MoviesRepo>();
  final TvShowsRepo _tvShowRepo = locator.get<TvShowsRepo>();

  HomeViewModel({BuildContext context}) {
    initializeData(context);
  }

  ViewState _movieState = ViewState.initial;

  ViewState get movieState => _movieState;

  void setMovieState(ViewState viewState) {
    _movieState = viewState;
    notifyListeners();
  }

  ViewState _tvShowState = ViewState.initial;

  ViewState get tvShowState => _tvShowState;

  void setTvState(ViewState viewState) {
    _tvShowState = viewState;
    notifyListeners();
  }

  List<MoviesList> _movies;
  List<MoviesList> get movies => _movies;

  set setMovies(List<MoviesList> movies) {
    _movies = movies;
  }

  List<TvShowsList> _tvSHows;
  List<TvShowsList> get tvShows => _tvSHows;

  set setTvShows(List<TvShowsList> tvShows) {
    _tvSHows = tvShows;
  }

  void initializeData(BuildContext context) {
    fetchMovies(context: context);
    fetchTvShows(context: context);
  }

  Future fetchMovies({BuildContext context}) async {
    setMovieState(ViewState.loading);
    try {
      log.d('fetching movies');
      setMovies = await _moviesRepo.loadMoviesLists;
      log.d('fetched movies');
      setMovieState(ViewState.loaded);
    } on CustomException catch (e) {
      log.e("Error from service ${e.toString()}", e);
      splitAndShowError(context, e.toString());
      setMovieState(ViewState.error);
    }
  }

  Future fetchTvShows({BuildContext context}) async {
    setTvState(ViewState.loading);
    try {
      log.d('fetching tv shows');
      setTvShows = await _tvShowRepo.loadTvShowsLists;
      log.d('fetched tv shows');
      setTvState(ViewState.loaded);
    } on CustomException catch (e) {
      log.e("Error from service ${e.toString()}", e);
      splitAndShowError(context, e.toString());
      setTvState(ViewState.error);
    }
  }
}
