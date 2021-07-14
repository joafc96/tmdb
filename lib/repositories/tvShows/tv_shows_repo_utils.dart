// Flutter imports:
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:tmdb/models/tv_shows/tv_shows_data.dart';
import 'package:tmdb/models/tv_shows/tv_shows_list.dart';
import 'package:tmdb/services/network/network_service.dart';
import 'package:http/http.dart' as http;

class TvShowUtilsRepo {
  static Future<TvShowsList> getCategoryTvShows({@required String url}) async {
    try {
      final http.Response _httpResponse = await ApiService.get(uri: url);
      final Map<String, dynamic> responseJson =
          json.decode(_httpResponse.body.toString()) as Map<String, dynamic>;

      final tvShows = TvShowsList.fromJson(responseJson);
      return getCorrectTvShows(tvShows);
    } catch (error) {
      throw error;
    }
  }

  static Future<TvShowsList> getSeeAllCategoryTvShows(
      {@required String url}) async {
    try {
      final http.Response _httpResponse = await ApiService.get(uri: url);
      return compute(parseTvShows, _httpResponse.body.toString());
    } catch (error) {
      throw error;
    }
  }

  static TvShowsList parseTvShows(String httpResponse) {
    final Map<String, dynamic> responseJson =
        json.decode(httpResponse) as Map<String, dynamic>;

    final tvShows = TvShowsList.fromJson(responseJson);
    return getCorrectTvShows(tvShows);
  }

  static TvShowsList getCorrectTvShows(TvShowsList tvShowsList) {
    if (tvShowsList == null || tvShowsList.tvShows.isEmpty) {
      return TvShowsList(
          pageNumber: tvShowsList.pageNumber,
          totalPages: tvShowsList.totalPages,
          tvShows: []);
    }

    List<TvShowsData> deleteTvShows;

    tvShowsList.tvShows.forEach((tvShow) {
      if (tvShow.posterPath == null || tvShow.backdropPath == null) {
        deleteTvShows == null
            ? deleteTvShows = [tvShow]
            : deleteTvShows.add(tvShow);
      }
    });

    if (deleteTvShows != null && deleteTvShows.isNotEmpty) {
      deleteTvShows.forEach((movie) {
        tvShowsList.tvShows.remove(movie);
      });
    }

    return tvShowsList;
  }
}
