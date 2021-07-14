import 'package:tmdb/models/movies/movie_data.dart';

import '../../repositories/movies/movies_repo.dart';
import '../../utils/enums.dart';
import '../../utils/urls.dart';

import '../../locator.dart';
import 'movie_repo_utils.dart';

import '../../models/movies/movie_list.dart';

class SeeAllMoviesrepo {
  final MoviesRepo _moviesRepo = locator.get<MoviesRepo>();

  Future<MoviesList> loadMoreMovies(
      MoviesList previousMovies, url, MoviesCategories movieCategory) async {
    try {
      MoviesList newMovies =
          await MovieUtilsRepo.getSeeAllCategoryMovies(url: url);

      if (movieCategory == MoviesCategories.upcoming) {
        if (newMovies != null) {
          newMovies = _moviesRepo.correctUpcomingMovies(newMovies);
        }

        if (newMovies != null) {
          newMovies = _moviesRepo.correctUpcomingMovies(newMovies);

          int counter = newMovies.pageNumber + 1;
          while (newMovies.movies.length < 20) {
            final s = await MovieUtilsRepo.getCategoryMovies(
                url: URLS.upComingMovies(counter));
            newMovies = MoviesList(
                pageNumber: s.pageNumber,
                totalPages: s.totalPages,
                movies: newMovies.movies);
            newMovies.movies.addAll(s.movies);
            counter++;
            // check again for released movies
            newMovies = _moviesRepo.correctUpcomingMovies(newMovies);
          }
        }
      }

      final totalMovieShowList = [
        ...previousMovies.movies,
        ...newMovies.movies
      ];

      var idSet = <String>{};
      var distinctMoviesList = <MoviesData>[];
      for (var d in totalMovieShowList) {
        if (idSet.add(d.id.toString())) {
          distinctMoviesList.add(d);
        }
      }

      return MoviesList(
          pageNumber: newMovies.pageNumber,
          totalPages: newMovies.totalPages,
          movies: distinctMoviesList);
    } catch (error) {
      rethrow;
    }
  }
}
