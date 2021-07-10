// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:tmdb/locator.dart';
import '../models/firebase_user_model/firebase_user_model.dart';
import '../repositories/firebase_login_repo/firebase_login_repo.dart';
import '../utils/shared_prefs/memory_management.dart';
import '../view_models/bottom_nav_view_model.dart';

// Project imports:

class LoginInfoViewModel extends ChangeNotifier {
  FirsebaseUserModel _firebaseUser;
  FirsebaseUserModel get firebaseUser => _firebaseUser;

  String get accountId => isSignedIn ? _firebaseUser.uid : '';
  String get displayName => isSignedIn ? _firebaseUser.displayName : '';
  String get photoUrl => isSignedIn ? _firebaseUser.photoUrl : '';
  String get email => isSignedIn ? _firebaseUser.email : '';

  final FireBaseAuthRepo _fireBaseAuthRepo = locator.get<FireBaseAuthRepo>();

  LoginInfoViewModel({FirsebaseUserModel firebaseUser})
      : _firebaseUser = firebaseUser;

  void signIn(FirsebaseUserModel firebaseUser) {
    _firebaseUser = firebaseUser;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    await _fireBaseAuthRepo.signOut();
    Provider.of<BottomNavigationViewModel>(context, listen: false).reset();
    MemoryManagement.deleteLoginDetails();
    _firebaseUser = null;
    notifyListeners();
  }

  bool get isSignedIn => _firebaseUser != null;
}
