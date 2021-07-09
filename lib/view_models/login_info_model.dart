// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tmdb/locator.dart';
import '../models/firebase_user_model/firebase_user_model.dart';
import '../repositories/firebase_login_repo/firebase_login_repo.dart';

// Project imports:
import '../utils/shared_prefs/memory_management.dart';

class LoginInfoViewModel extends ChangeNotifier {
  FirsebaseUserModel _firebaseUser;
  FirsebaseUserModel get firebaseUser => _firebaseUser;

  String get accountId => isSignedIn ? _firebaseUser.uid : "";
  String get displayName => isSignedIn ? _firebaseUser.displayName : '';

  final FireBaseAuthRepo _fireBaseAuthRepo = locator.get<FireBaseAuthRepo>();

  LoginInfoViewModel({FirsebaseUserModel firebaseUser})
      : _firebaseUser = firebaseUser;

  void signIn(FirsebaseUserModel firebaseUser) {
    _firebaseUser = firebaseUser;
    notifyListeners();
  }

  Future<void> signOut() async {
   await  _fireBaseAuthRepo.signOut();

    MemoryManagement.deleteLoginDetails();
    _firebaseUser = null;
    notifyListeners();
  }

  bool get isSignedIn => _firebaseUser != null;
}
