// Package imports:
import 'package:logger/logger.dart';

// Project imports:
import '../../locator.dart';
import '../../models/movies/movie_data.dart';
import '../../models/movies/movie_list.dart';
import '../../services/network/custom_exceptions.dart';
import '../../utils/urls.dart';
import 'movie_repo_utils.dart';

class MoviesRepo {
  final Logger log = locator.get<Logger>();

  Future<List<MoviesList>> get loadMoviesLists async {
    try {
      log.d('${DateTime.now()} movie fetch time start');

      final List<MoviesList> _movieData = await Future.wait([
        MovieUtilsRepo.getCategoryMovies(url: URLS.trendingMovies(1)),
        MovieUtilsRepo.getCategoryMovies(url: URLS.nowPlayingMovies(1)),
        MovieUtilsRepo.getCategoryMovies(url: URLS.upComingMovies(1)),
      ]);

      if (_movieData[2] != null) {
        _movieData[2] = correctUpcomingMovies(_movieData[2]);
      }

      if (_movieData[2] != null) {
        _movieData[2] = correctUpcomingMovies(_movieData[2]);

        int counter = 2;
        while (_movieData[2].movies.length < 20) {
          final s = await MovieUtilsRepo.getCategoryMovies(
              url: URLS.upComingMovies(counter));
          _movieData[2] = MoviesList(
              pageNumber: s.pageNumber,
              totalPages: s.totalPages,
              movies: _movieData[2].movies);
          _movieData[2].movies.addAll(s.movies);
          counter++;
          // check again for released movies
          _movieData[2] = correctUpcomingMovies(_movieData[2]);
        }
      }

      log.d('${DateTime.now()} movie fetch time end');

      return _movieData;
    } on CustomException {
      rethrow;
    }
  }

  // checks whether the movie is released or not if yes remove it
  MoviesList correctUpcomingMovies(MoviesList upcomingMovies) {
    final List<MoviesData> deleteMovies = [];

    upcomingMovies.movies.forEach((movie) {
      if (movie.releaseDate != null) {
        int year, month, day;
        year = int.parse(movie.releaseDate.substring(0, 4));
        month = int.parse(movie.releaseDate.substring(5, 7));
        day = int.parse(movie.releaseDate.substring(8, 10));

        if (DateTime.now().year == year) {
          if (DateTime.now().month == month) {
            if (DateTime.now().day > day) deleteMovies.add(movie);
          } else if (DateTime.now().month > month) {
            deleteMovies.add(movie);
          }
        } else if (DateTime.now().year > year) {
          deleteMovies.add(movie);
        }
      }
    });

    if (deleteMovies.isNotEmpty) {
      deleteMovies.forEach((movie) {
        upcomingMovies.movies.remove(movie);
      });
    }
    return upcomingMovies;
  }
}



      // final trending =
      //     await MovieUtilsRepo.getCategoryMovies(url: URLS.trendingMovies(1));
      // final nowPlaying =
      //     await MovieUtilsRepo.getCategoryMovies(url: URLS.nowPlayingMovies(1));
      // final upcoming =
      //     await MovieUtilsRepo.getCategoryMovies(url: URLS.upComingMovies(1));
      // final topRated = await MovieUtilsRepo.getCategoryMovies(url: URLS.topRatedMovies(1));
      // final popular = await MovieUtilsRepo.getCategoryMovies( url: URLS.popularMovies(1));