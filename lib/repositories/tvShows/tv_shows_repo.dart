// Package imports:
import 'package:logger/logger.dart';

// Project imports:
import '../../locator.dart';
import '../../models/tv_shows/tv_shows_list.dart';
import '../../repositories/tvShows/tv_shows_repo_utils.dart';
import '../../services/network/custom_exceptions.dart';
import '../../utils/urls.dart';

class TvShowsRepo {
  final Logger log = locator.get<Logger>();

  Future<List<TvShowsList>> get loadTvShowsLists async {
    try {
      log.d('${DateTime.now()} tvShow fetch time start');

      // to provide concurrency and not await every single future
      final List<TvShowsList> _tvShowsData = await Future.wait([
        TvShowUtilsRepo.getCategoryTvShows(url: URLS.trendingTvShows(1)),
        TvShowUtilsRepo.getCategoryTvShows(url: URLS.airingTodayTvShows(1)),
        TvShowUtilsRepo.getCategoryTvShows(
            url: URLS.providerTvShowsTvShows(
                page: 1, provider: 8, region: "US")),
        TvShowUtilsRepo.getCategoryTvShows(
            url: URLS.providerTvShowsTvShows(
                page: 1, provider: 9, region: "US")),
        TvShowUtilsRepo.getCategoryTvShows(
            url: URLS.providerTvShowsTvShows(
                page: 1, provider: 337, region: "US")),
        TvShowUtilsRepo.getCategoryTvShows(
            url: URLS.providerTvShowsTvShows(
                page: 1, provider: 350, region: "US")),
        TvShowUtilsRepo.getCategoryTvShows(
            url: URLS.providerTvShowsTvShows(
                page: 1, provider: 27, region: "US")),
      ]);

      // final topRatedTvShows = await TvShowUtilsRepo.getCategoryTvShows(url: URLS.topRatedTvShows(1));
      // final popularTvShows = await TvShowUtilsRepo.getCategoryTvShows(url: URLS.popularTvShows(1));

      log.d('${DateTime.now()} tvShow fetch time end');

      return _tvShowsData;
    } on CustomException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
