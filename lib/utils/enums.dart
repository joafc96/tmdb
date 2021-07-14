enum MediaType { movie, tvShow }
const mediaTypeValue = {MediaType.movie: 'movie', MediaType.tvShow: 'tv'};

enum exceptionPrefix {
  unauthorised,
  noInternet,
  internalServerError,
  invalidInput,
  invalidRequest,
  badFormat,
  firebaseWeakPassword,
  firebaseEmailAlreadyInUse,
  firebaseNoUserFound,
  firebaseWrongPassword,
  fireBaseInvalidEmail,
  firebaseNetworkFailed,
  googleSignInCancelled
}

enum tabItem { home, search, celebs, account }

enum MoviesCategories {
  popular,
  nowPlaying,
  trending,
  topRated,
  upcoming,
  detailsRecommended,
  detailsSimilar
}

enum TvShowsCategories {
  airingToday,
  trending,
  topRated,
  popular,
  detailsRecommended,
  detailsSimilar,
  netflix,
  amazonPrime,
  disney,
  appleTv,
  hbo
}

enum homeCategories {
  trendingMovies,
  trendingTvShows,
  nowPlayingMovies,
  airingTodayTvShows,
  upcomingMovies,
  netflixTvSHows,
  amazonTvSHows,
  appleTvSHows,
  disneyTvSHows,
  hboTvShows
}

enum themeOptions { natrium, titanium, indium, neptunium, thorium, plutonium }

enum imageQualityOptions { low, medium, high }

enum gridCountOptions { two, three, four }

enum ViewState { initial, loading, loaded, error }
