
import 'package:flutter/cupertino.dart';
import 'package:tmdb/models/movies/movie_data.dart';
import 'package:tmdb/models/movies/movie_list.dart';
import 'package:tmdb/services/network/network_service.dart';

class MovieUtilsRepo {
  static Future<MoviesList> getCategoryMovies({@required String url}) async {
    try {
      final Map<String, dynamic> json = await ApiService.get(uri: url);
      final movies = MoviesList.fromJson(json);
      return getCorrectMovies(movies);
    } catch (error) {
      rethrow;
    }
  }

  static MoviesList getCorrectMovies(MoviesList movies) {
    if (movies == null || movies.movies.isEmpty) {
      return MoviesList(
          pageNumber: movies.pageNumber,
          totalPages: movies.totalPages,
          movies: []);
    }

    List<MoviesData> deleteMovies;

    movies.movies.forEach((movie) {
      if (movie.posterPath == null || movie.backdropPath == null) {
        deleteMovies == null ? deleteMovies = [movie] : deleteMovies.add(movie);
      }
    });

    if (deleteMovies != null && deleteMovies.isNotEmpty) {
      deleteMovies.forEach((movie) {
        movies.movies.remove(movie);
      });
    }

    return movies;
  }
}
