import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tmdb/models/tv_shows/tv_shows_list.dart';
import 'package:tmdb/services/network/custom_exceptions.dart';
import 'package:tmdb/utils/enums.dart';
import 'package:tmdb/utils/reusable_widgets.dart';
import 'package:tmdb/utils/urls.dart';
import '../repositories/tvShows/see_all_tv_shows_repo.dart';
import 'package:tmdb/view_models/base_model.dart';

import '../locator.dart';

class SeeAllTvShowsViewModel extends BaseModel {
  final Logger log = locator.get<Logger>();
  final SeeAllTvShowsRepo _seeAllTvShowsRepo = locator.get<SeeAllTvShowsRepo>();
  final TvShowsList initialTvShowsList;

  SeeAllTvShowsViewModel(this.initialTvShowsList) {
    _initializeData();
  }

  void _initializeData() {
    setTvShowsList = initialTvShowsList;
  }

  TvShowsList _tvShowsList;

  TvShowsList get tvShowsList => _tvShowsList;

  set setTvShowsList(TvShowsList tvShowsList) {
    _tvShowsList = tvShowsList;
    notifyListeners();
  }

  void getTvShows(
      {BuildContext context, TvShowsCategories tvShowsCategory, int tvShowId}) {
    String url = '';
    final tvShowsList = _tvShowsList;
    if (tvShowsList.pageNumber < tvShowsList.totalPages) {
      final pageNumber = tvShowsList.pageNumber + 1;
      switch (tvShowsCategory) {
        case TvShowsCategories.airingToday:
          url = URLS.airingTodayTvShows(pageNumber);
          break;
        case TvShowsCategories.trending:
          url = URLS.trendingTvShows(pageNumber);
          break;
        case TvShowsCategories.topRated:
          url = URLS.topRatedTvShows(pageNumber);
          break;
        case TvShowsCategories.popular:
          url = URLS.popularTvShows(pageNumber);
          break;
        case TvShowsCategories.detailsRecommended:
          url = URLS.recommendedTvShows(tvShowId, pageNumber);
          break;
        case TvShowsCategories.detailsSimilar:
          url = URLS.similarTvShows(tvShowId, pageNumber);
          break;
        case TvShowsCategories.netflix:
          url = URLS.providerTvShowsTvShows(
              page: pageNumber, provider: 8, region: "US");
          break;
        case TvShowsCategories.amazonPrime:
          url = URLS.providerTvShowsTvShows(
              page: pageNumber, provider: 9, region: "US");
          break;
        case TvShowsCategories.disney:
          url = URLS.providerTvShowsTvShows(
              page: pageNumber, provider: 337, region: "US");
          break;
        case TvShowsCategories.appleTv:
          url = URLS.providerTvShowsTvShows(
              page: pageNumber, provider: 350, region: "US");
          break;
        case TvShowsCategories.hbo:
          url = URLS.providerTvShowsTvShows(
              page: pageNumber, provider: 27, region: "US");
          break;
      }
      loadMoreTvShows(context: context, url: url);
    }
  }

  Future loadMoreTvShows({BuildContext context, String url}) async {
    setState(ViewState.loading);
    try {
      log.d('fetching tv shows');
      setTvShowsList =
          await _seeAllTvShowsRepo.loadMoreTvShows(_tvShowsList, url);
      log.d('fetched tv shows');
      setState(ViewState.loaded);
    } on CustomException catch (e) {
      log.e("Error from service ${e.toString()}", e);
      splitAndShowError(context, e.toString());
      setState(ViewState.error);
    }
  }
}
