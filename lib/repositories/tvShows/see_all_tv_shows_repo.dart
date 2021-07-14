import 'package:tmdb/models/tv_shows/tv_shows_data.dart';

import '../../models/tv_shows/tv_shows_list.dart';
import '../../repositories/tvShows/tv_shows_repo_utils.dart';

class SeeAllTvShowsRepo {
  Future<TvShowsList> loadMoreTvShows(TvShowsList previousTvShows, url) async {
    try {
      final newTvShows =
          await TvShowUtilsRepo.getSeeAllCategoryTvShows(url: url);
      final totalTvShowList =
          [...previousTvShows.tvShows, ...newTvShows.tvShows];


            var idSet = <String>{};
  var distinctTvShowList = <TvShowsData>[];
  for (var d in totalTvShowList) {
    if (idSet.add(d.id.toString())) {
      distinctTvShowList.add(d);
    }
  }
      return TvShowsList(
          pageNumber: newTvShows.pageNumber,
          totalPages: newTvShows.totalPages,
          tvShows: distinctTvShowList);
    } catch (error) {
      rethrow;
    }
  }
}
