// Package imports:
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import './repositories/firebase_login_repo/firebase_login_repo.dart';
import './repositories/login_repo.dart';
import './repositories/movies/movies_repo.dart';
import './repositories/tvShows/tv_shows_repo.dart';
import './view_models/bottom_nav_view_model.dart';
import './view_models/home_view_model.dart';
import './view_models/login_view_model.dart';


// Project imports:
import './view_models/splash_view_model.dart';

final locator = GetIt.instance;


void setUpServiceLocator() {

  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => SplashViewModel());
  locator.registerFactory(() => HomeViewModel());

  locator.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
  locator.registerLazySingleton(() => LoginRepo());
  locator.registerLazySingleton(() => FireBaseAuthRepo());
  locator.registerLazySingleton(() => MoviesRepo());
  locator.registerLazySingleton(() => TvShowsRepo());
  locator.registerLazySingleton(() => BottomNavigationViewModel());



}
