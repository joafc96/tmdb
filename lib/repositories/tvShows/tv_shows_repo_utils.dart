// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:tmdb/models/tv_shows/tv_shows_data.dart';
import 'package:tmdb/models/tv_shows/tv_shows_list.dart';
import 'package:tmdb/services/network/network_service.dart';

class TvShowUtilsRepo {
  static Future<TvShowsList> getCategoryTvShows(
      {@required String url}) async {
    try {
      final json = await ApiService.get(uri: url);
      final tvShows = TvShowsList.fromJson(json);
      return getCorrectTvShows(tvShows);
    } catch (error) {
      throw error;
    }
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
