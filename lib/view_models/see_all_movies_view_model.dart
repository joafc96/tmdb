import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logger/logger.dart';
import '../models/movies/movie_list.dart';
import '../repositories/movies/see_all_movies_repo.dart';
import '../services/network/custom_exceptions.dart';
import '../utils/enums.dart';
import '../utils/reusable_widgets.dart';
import '../utils/urls.dart';
import '../view_models/base_model.dart';

import '../locator.dart';

class SeeAllMoviesViewModel extends BaseModel {
  final Logger log = locator.get<Logger>();
  final SeeAllMoviesrepo _seeAllMoviesrepo = locator.get<SeeAllMoviesrepo>();
  final MoviesList initialMovies;

  SeeAllMoviesViewModel(this.initialMovies) {
    _initializeData();
  }

  void _initializeData() {
    setMoviesList = initialMovies;
  }

  MoviesList _moviesList;

  MoviesList get moviesList => _moviesList;

  set setMoviesList(MoviesList moviesList) {
    _moviesList = moviesList;
    notifyListeners();
  }

  void getMovies(
      {BuildContext context, MoviesCategories moviesCategory, int movieId}) {
    String url = '';
    final moviesList = _moviesList;
    if (moviesList.pageNumber < moviesList.totalPages) {
      final pageNumber = moviesList.pageNumber + 1;
      switch (moviesCategory) {
        case MoviesCategories.trending:
          url = URLS.trendingMovies(pageNumber);
          break;
        case MoviesCategories.nowPlaying:
          url = URLS.nowPlayingMovies(pageNumber);
          break;
        case MoviesCategories.upcoming:
          url = URLS.upComingMovies(pageNumber);
          break;

        case MoviesCategories.popular:
          url = URLS.popularMovies(pageNumber);
          break;
        case MoviesCategories.topRated:
          url = URLS.topRatedMovies(pageNumber);
          break;
        case MoviesCategories.detailsRecommended:
          url = URLS.recommendedMovies(movieId, pageNumber);
          break;
        case MoviesCategories.detailsSimilar:
          url = URLS.similarMovies(movieId, pageNumber);
          break;
      }
      loadMoreMovies(
          context: context, url: url, moviesCategory: moviesCategory);
    }
  }

  Future loadMoreMovies(
      {BuildContext context,
      String url,
      MoviesCategories moviesCategory}) async {
    setState(ViewState.loading);
    try {
      log.d('fetching more movies');
      setMoviesList = await _seeAllMoviesrepo.loadMoreMovies(
          _moviesList, url, moviesCategory);
      log.d('fetched more movies');
      setState(ViewState.loaded);
    } on CustomException catch (e) {
      log.e("Error from service ${e.toString()}", e);
      splitAndShowError(context, e.toString());
      setState(ViewState.error);
    } catch (e) {
      log.e("Error from service ${e.toString()}", e);
      setState(ViewState.error);
    }
  }
}
