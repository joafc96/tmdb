import '../../models/tv_shows/tv_shows_list.dart';
import '../../repositories/tvShows/tv_shows_repo_utils.dart';

class SeeAllTvShowsRepo {
  Future<TvShowsList> loadMoreTvShows(previousTvShows, url) async {
    try {
      final newTvShows = await TvShowUtilsRepo.getCategoryTvShows(url: url);
      return TvShowsList(
          pageNumber: newTvShows.pageNumber,
          totalPages: newTvShows.totalPages,
          tvShows: previousTvShows.tvShows + newTvShows.tvShows);
    } catch (error) {
      rethrow;
    }
  }
}
