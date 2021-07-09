// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/models/firebase_user_model/firebase_user_model.dart';

// Project imports:
import 'package:tmdb/utils/theme_utils.dart';
import '../../utils/shared_prefs/shared_prefs_keys.dart';

import '../../utils/enums.dart';

class MemoryManagement {
  static SharedPreferences prefs;

  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static void setUserId({@required String userId}) {
    prefs.setString(SharedPrefsKeys.userId, userId);
  }

  static String getUserId() {
    return prefs.getString(SharedPrefsKeys.userId);
  }

  static void setDisplayName({@required String displayName}) {
    prefs.setString(SharedPrefsKeys.displayName, displayName ?? "");
  }

  static String getDisplayName() {
    return prefs.getString(SharedPrefsKeys.displayName);
  }

  static void setEmail({@required String email}) {
    prefs.setString(SharedPrefsKeys.email, email);
  }

  static String getEmail() {
    return prefs.getString(SharedPrefsKeys.email);
  }

  static void setPhotoUrl({@required String photoUrl}) {
    prefs.setString(SharedPrefsKeys.photo_url, photoUrl ?? "");
  }

  static String getPhotoUrl() {
    return prefs.getString(SharedPrefsKeys.photo_url);
  }

  static void setCurrentThemeSetting({@required ThemeSetting themeSetting}) {
    prefs.setInt(SharedPrefsKeys.currentTheme, themeSetting.getIndex());
  }

  static int getCurrentThemeSetting() {
    return prefs.getInt(SharedPrefsKeys.currentTheme);
  }

  static void setIsAppStartedForFirstTime(
      {@required bool isAppStartedFirstTime}) {
    prefs.setBool(SharedPrefsKeys.isAppStartedFirstTime, isAppStartedFirstTime);
  }

  static bool getIsAppStartedFirstTime() {
    return prefs.getBool(SharedPrefsKeys.isAppStartedFirstTime);
  }

  static FirsebaseUserModel loadUserDetails() {
    final userId = getUserId();
    final displayName = getDisplayName();
    final email = getEmail();
    final photoUrl = getPhotoUrl();
    return FirsebaseUserModel(
        uid: userId,
        displayName: displayName,
        email: email,
        photoUrl: photoUrl);
  }

  static void saveUserDetails(FirsebaseUserModel firebaseUserInfo) {
    setIsAppStartedForFirstTime(isAppStartedFirstTime: false);
    setUserId(userId: firebaseUserInfo.uid);
    setEmail(email: firebaseUserInfo.email);
    setDisplayName(displayName: firebaseUserInfo?.displayName);
    setPhotoUrl(photoUrl: firebaseUserInfo.photoUrl);
  }

  static bool getIsUserDetailsEmpty() {
    final userId = getUserId();
    final email = getEmail();
    final userName = getDisplayName();
    return email == null || userId == null || userId == 0 || userName == null;
  }

  static void deleteLoginDetails() {
    setDisplayName(displayName: '');
    setUserId(userId: '');
    setEmail(email: '');
    setPhotoUrl(photoUrl: '');
    setIsAppStartedForFirstTime(isAppStartedFirstTime: true);
  }

  static ThemeSetting getCurrentTheme() {
    return ThemeSetting(themeOptions.values[getCurrentThemeSetting() ?? 5]);
  }

  //clear all values from shared preferences
  static void clearMemory() {
    prefs.clear();
  }
}
