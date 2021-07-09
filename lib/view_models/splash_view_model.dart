// Flutter imports:
import 'package:flutter/material.dart';
import '../models/firebase_user_model/firebase_user_model.dart';

// Project imports:
import '../utils/shared_prefs/memory_management.dart';

class SplashViewModel with ChangeNotifier {
  final bool isFirebaseUserInfoEmpty = MemoryManagement.getIsUserDetailsEmpty();
  final bool appStartedFirstTime = MemoryManagement.getIsAppStartedFirstTime();
  FirsebaseUserModel _firebaseUserInfo;

  Future setUpApp(BuildContext context) async {
    bool isAppStartedForFirstTime = true;
    if (appStartedFirstTime != null && !appStartedFirstTime) {
      isAppStartedForFirstTime = false;
      if (!isFirebaseUserInfoEmpty) {
        _firebaseUserInfo = MemoryManagement.loadUserDetails();
      }
    }

    _firebaseUserInfo != null || !isAppStartedForFirstTime
        ? Navigator.pushReplacementNamed(context, '/mainTab')
        : Navigator.pushReplacementNamed(context, '/login');
  }
}
