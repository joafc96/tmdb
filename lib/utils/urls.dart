import 'package:flutter/material.dart';

import '../models/user_info_model.dart';
import 'enums.dart';
import 'tmdb_configs.dart';

class URLS {
  static const _api = 'https://api.themoviedb.org/3/';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/';

  static String _appendUrlWithApiKeyAndPage(String url, int page) =>
      '$url${'?api_key=$apiKey&language=en-US&page=$page'}';

  static String _appendUrlWithWatchProviderAnWatchRegion(
          int provider, String region) =>
      '&with_watch_providers=$provider&watch_region=$region';

  //Movies URLS

  static const _movie = '${_api}movie/';

  static String trendingMovies(int page) =>
      _api + _appendUrlWithApiKeyAndPage('trending/movie/day', page);

  static String popularMovies(int page) =>
      _appendUrlWithApiKeyAndPage('${_movie}popular', page);

  static String nowPlayingMovies(int page) =>
      _appendUrlWithApiKeyAndPage('${_movie}now_playing', page);

  static String topRatedMovies(int page) =>
      _appendUrlWithApiKeyAndPage('${_movie}top_rated', page);

  static String upComingMovies(int page) =>
      _appendUrlWithApiKeyAndPage('${_movie}upcoming', page);

  static String recommendedMovies(int movieId, int page) =>
      _appendUrlWithApiKeyAndPage('$_movie${'$movieId/recommendations'}', page);

  static String similarMovies(int movieId, int page) =>
      _appendUrlWithApiKeyAndPage('$_movie${'$movieId/similar'}', page);

  static String favouriteMovies(UserInfoModel user, int page) =>
      '${_api}account/${user.userId}/favorite/movies?api_key=$apiKey&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String ratedMovies(UserInfoModel user, int page) =>
      '${_api}account/${user.userId}/rated/movies?api_key=$apiKey&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String watchListMovies(UserInfoModel user, int page) =>
      '${_api}account/${user.userId}/watchlist/movies?api_key=$apiKey&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  //Tv URLS

  static const _tv = '${_api}tv/';

  static const _discoverTv = '${_api}discover/tv/';

  static String trendingTvShows(int page) =>
      _appendUrlWithApiKeyAndPage('${_api}trending/tv/day', page);

  static String airingTodayTvShows(int page) =>
      _appendUrlWithApiKeyAndPage('${_tv}airing_today', page);

  static String topRatedTvShows(int page) =>
      _appendUrlWithApiKeyAndPage('${_tv}top_rated', page);

  static String popularTvShows(int page) =>
      _appendUrlWithApiKeyAndPage('${_tv}popular', page);

  static String recommendedTvShows(int tvShowId, int page) =>
      _appendUrlWithApiKeyAndPage('$_tv${'$tvShowId/recommendations'}', page);

  static String similarTvShows(int tvShowId, int page) =>
      _appendUrlWithApiKeyAndPage('$_tv${'$tvShowId/similar'}', page);

  static String providerTvShowsTvShows(
          {int page, int provider, String region}) =>
      _appendUrlWithApiKeyAndPage('$_discoverTv', page) +
      _appendUrlWithWatchProviderAnWatchRegion(provider, 'US');

  static String favouriteTvShows(UserInfoModel user, int page) =>
      '${_api}account/${user.userId}/favorite/tv?api_key=$apiKey&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String ratedTvShows(UserInfoModel user, int page) =>
      '${_api}account/${user.userId}/rated/tv?api_key=$apiKey&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String watchListTvShows(UserInfoModel user, int page) =>
      '${_api}account/${user.userId}/watchlist/tv?api_key=$apiKey&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  //Celebrities URLS
  static const _CELEB = '${_api}person/';

  static String trendingCelebrities(int page) =>
      _appendUrlWithApiKeyAndPage('${_api}trending/person/day', page);

  static String popularCelebrities(int page) =>
      _appendUrlWithApiKeyAndPage('${_CELEB}popular', page);

  //Search URLS
  static String trendingSearches(int page) =>
      _appendUrlWithApiKeyAndPage('${_api}trending/all/day', page);

  static String _appendWithSearchURL(String url, String query, int page) =>
      '${_appendUrlWithApiKeyAndPage('${_api}search/$url', page)}${'&query=$query'}';

  static String search(String query, int page) =>
      _appendWithSearchURL('multi', query, page);

  static String searchMovies(String query, int page) =>
      _appendWithSearchURL('movie', query, page);

  static String searchTvShows(String query, int page) =>
      _appendWithSearchURL('tv', query, page);

  static String searchCelebrities(String query, int page) =>
      _appendWithSearchURL('person', query, page);

  //Movie Details URL
  static String movieDetails(int movieId) =>
      '${_appendUrlWithApiKeyAndPage('$_api${'movie/$movieId'}', 1)}&append_to_response=credits%2Cimages%2Cvideos%2Crecommendations%2Csimilar';

  static String movieStates(int movieId, String sessionId) =>
      '$_movie$movieId/account_states?api_key=$apiKey&session_id=$sessionId';

  //Collection Details URL
  static String collectionDetails(int movieId, int page) =>
      _appendUrlWithApiKeyAndPage('$_api${'collection/$movieId'}', page);

  //Tv Show Details URL
  static String tvShowDetails(int tvId) =>
      '${_appendUrlWithApiKeyAndPage('$_api${'tv/$tvId'}', 1)}&append_to_response=credits%2Cimages%2Cvideos%2Crecommendations%2Csimilar';

  static String tvShowStates(int tvId, String sessionId) =>
      '$_tv$tvId/account_states?api_key=$apiKey&language=en-US&session_id=$sessionId';

  //Season Details URL
  static String seasonDetails(int tvId, int seasonNumber, int page) =>
      _appendUrlWithApiKeyAndPage(
          '$_api${'tv/$tvId/season/$seasonNumber'}', page);

  //Celebrities Details URL
  static String celebritiesDetails(int celebId) =>
      '${_appendUrlWithApiKeyAndPage('$_api${'person/$celebId'}', 1)}&append_to_response=movie_credits%2Ctv_credits';

  //Media TMDb URLS
  static String mediaFavourite(UserInfoModel user) =>
      '${_api}account/${user.userId}/favorite?api_key=$apiKey&session_id=${user.sessionId}';

  static String mediaRate(
          {@required UserInfoModel user,
          @required MediaType mediaType,
          @required int mediaId}) =>
      '$_api${mediaTypeValue[mediaType]}/$mediaId/rating?api_key=$apiKey&session_id=${user.sessionId}';

  static String mediaWatchList(UserInfoModel user) =>
      '${_api}account/${user.userId}/watchlist?api_key=$apiKey&session_id=${user.sessionId}';

  //Login URLS
  static final createRequestToken =
      '${_api}authentication/token/new?api_key=$apiKey';
  static final verifyRequestToken =
      '${_api}authentication/token/validate_with_login?api_key=$apiKey';
  static final createSessionId =
      '${_api}authentication/session/new?api_key=$apiKey';
  static String accountDetails(String sessionId) =>
      '${_api}account?api_key=$apiKey&session_id=$sessionId';
}
