// Flutter imports:
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:tmdb/models/movies/movie_data.dart';
import 'package:tmdb/models/movies/movie_list.dart';
import 'package:tmdb/services/network/network_service.dart';
import 'package:http/http.dart' as http;

class MovieUtilsRepo {
  static Future<MoviesList> getCategoryMovies({@required String url}) async {
    try {
      final http.Response _httpResponse = await ApiService.get(uri: url);
      final Map<String, dynamic> responseJson =
          json.decode(_httpResponse.body.toString()) as Map<String, dynamic>;

      final movies = MoviesList.fromJson(responseJson);
      return getCorrectMovies(movies);
    } catch (error) {
      rethrow;
    }
  }

  static Future<MoviesList> getSeeAllCategoryMovies(
      {@required String url}) async {
    try {
      final http.Response _httpResponse = await ApiService.get(uri: url);
      return compute(parseMovies, _httpResponse.body.toString());
    } catch (error) {
      rethrow;
    }
  }

  static MoviesList parseMovies(String httpResponse) {
    final Map<String, dynamic> responseJson =
        json.decode(httpResponse) as Map<String, dynamic>;

    final movies = MoviesList.fromJson(responseJson);
    return getCorrectMovies(movies);
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
