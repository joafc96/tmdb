// Flutter imports:

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/utils/settings_utils/image_quality_utils.dart';
import 'package:tmdb/view_models/image_quality_view_model.dart';

// Project imports:
import './models/firebase_user_model/firebase_user_model.dart';
import './styles.dart';
import 'utils/settings_utils/theme_utils.dart';
import './view_models/bottom_nav_view_model.dart';
import './view_models/login_info_model.dart';
import './view_models/theme_view_model.dart';
import 'locator.dart';
import 'router.dart';
import 'utils/shared_prefs/memory_management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Service Locator
  setUpServiceLocator();

  //load env file for api key etc..
  await dotenv.load(fileName: ".env");

  // Setup logger, only show warning and higher in release mode.
  if (kReleaseMode) {
    Logger.level = Level.warning;
  } else {
    Logger.level = Level.debug;
  }

  // initialise shared prefs
  await MemoryManagement.init();

  // initialise fireabase app
  await Firebase.initializeApp();

  // check whether user info is empty (to pass onto the login info provider)
  final bool isUserInfoEmpty = MemoryManagement.getIsUserDetailsEmpty();
  FirsebaseUserModel _userInfo;
  if (!isUserInfoEmpty) {
    _userInfo = MemoryManagement.loadUserDetails();
  }

  // gets current theme setting
  final ThemeSetting _themeSetting = MemoryManagement.getCurrentTheme();

// gets current image quality
  final ImageQualitySetting _imageQualitySetting =
      MemoryManagement.getCurrentImageQuality();

  runApp(
    ChangeNotifierProvider<ThemeViewModel>(
      create: (context) => ThemeViewModel(themeSetting: _themeSetting),
      child: App(
        userInfo: _userInfo,
        imageQualitySetting: _imageQualitySetting,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final FirsebaseUserModel userInfo;
  final ImageQualitySetting imageQualitySetting;

  const App({Key key, this.userInfo, this.imageQualitySetting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        Provider.of<ThemeViewModel>(context).curTheme.statusBar);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginInfoViewModel>(
          create: (_) => LoginInfoViewModel(firebaseUser: userInfo),
        ),
        ChangeNotifierProvider<ImageQualityViewModel>(
          create: (_) => ImageQualityViewModel(imageQualitySetting: imageQualitySetting),
        ),
        ChangeNotifierProvider<BottomNavigationViewModel>(
            create: (_) => locator<BottomNavigationViewModel>())
      ],
      child: OKToast(
        textStyle: AppStyles.textStyleSnackbar(context),
        backgroundColor: context.read<ThemeViewModel>().curTheme.background,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "TMDb",
          theme: ThemeData(
            primaryColor: context.watch<ThemeViewModel>().curTheme.primary,
            accentColor: context.watch<ThemeViewModel>().curTheme.background,
            backgroundColor:
                context.watch<ThemeViewModel>().curTheme.background,
            scaffoldBackgroundColor:
                context.watch<ThemeViewModel>().curTheme.background,
            brightness: context.watch<ThemeViewModel>().curTheme.brightness,
            appBarTheme: AppBarTheme(
              color: context.watch<ThemeViewModel>().curTheme.background,
            ),
            textTheme: GoogleFonts.nunitoSansTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          initialRoute: '/',
          onGenerateRoute: generateRoute,
          navigatorKey: locator<BottomNavigationViewModel>().navigatorKey,
        ),
      ),
    );
  }
}
