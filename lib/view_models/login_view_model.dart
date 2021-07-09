import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../models/firebase_user_model/firebase_user_model.dart';
import '../repositories/firebase_login_repo/firebase_login_repo.dart';
import '../services/network/custom_exceptions.dart';
import '../utils/enums.dart';
import '../utils/reusable_widgets.dart';
import '../view_models/login_info_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../locator.dart';
import '../utils/shared_prefs/memory_management.dart';
import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final String _singUpUrl = 'https://www.themoviedb.org/account/signup';

  final Logger log = locator.get<Logger>();
  final FireBaseAuthRepo _fireBaseAuthRepo = locator.get<FireBaseAuthRepo>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  void continueWithoutSignIn(BuildContext context) {
    MemoryManagement.setIsAppStartedForFirstTime(isAppStartedFirstTime: false);
    Navigator.pushReplacementNamed(context, '/mainTab');
  }

  Future launchURL() async {
    if (await canLaunch(_singUpUrl) != null) {
      await launch(_singUpUrl);
    } else {
      throw 'Could not launch $_singUpUrl';
    }
  }

  Future signUpWithEmailAndPassword(BuildContext context) async {
    if (_loginFormKey.currentState.validate()) {
      log.d(_emailController.text.trim());
      log.d(_passwordController.text.trim());
      setState(ViewState.loading);
      try {
        final UserCredential _userCredential =
            await _fireBaseAuthRepo.signUpWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        User _user = _userCredential.user;

        _fireBaseAuthRepo.tryCreateUserData(_user).then(
          (value) async {
            FirsebaseUserModel _firebaseUser =
                await _fireBaseAuthRepo.getUserDetails(_user);

            MemoryManagement.saveUserDetails(_firebaseUser);

            Provider.of<LoginInfoViewModel>(context, listen: false)
                .signIn(_firebaseUser);
          },
        );
        setState(ViewState.loaded);

        showSnackBar("Registered successfully 🤩", context);

        log.d("user registered");
      } on CustomException catch (e) {
        splitAndShowError(context, e.toString());
        setState(ViewState.error);
      } catch (e) {
        log.e(e.toString());
      }
    } else {
      return;
    }
  }

  Future signInWithEmailAndPassword(BuildContext context) async {
    if (_loginFormKey.currentState.validate()) {
      log.d(_emailController.text.trim());
      log.d(_passwordController.text.trim());
      setState(ViewState.loading);
      try {
        final UserCredential _userCredential =
            await _fireBaseAuthRepo.signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        FirsebaseUserModel _firebaseUser =
            await _fireBaseAuthRepo.getUserDetails(_userCredential.user);
        MemoryManagement.saveUserDetails(_firebaseUser);

        setState(ViewState.loaded);

        Navigator.pushReplacementNamed(context, '/mainTab');

        showSnackBar("Logged in successfully 🤩", context);

        log.d("user logged in");
      } on CustomException catch (e) {
        splitAndShowError(context, e.toString());
        setState(ViewState.error);
      } catch (e) {
        log.e(e.toString());
      }
    } else {
      return;
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    setState(ViewState.loading);

    try {
      final UserCredential _userCredential =
          await _fireBaseAuthRepo.signInWithGoogle();

      final bool _authenticateUser =
          await _fireBaseAuthRepo.authenticateUser(_userCredential.user);

      User _user = _userCredential.user;

      if (_authenticateUser == true) {
        FirsebaseUserModel _firebaseUser =
            await _fireBaseAuthRepo.getUserDetails(_user);
        MemoryManagement.saveUserDetails(_firebaseUser);

        setState(ViewState.loaded);

        Navigator.pushReplacementNamed(context, '/mainTab');

        showSnackBar("Logged in successfully 🤩", context);

        log.d("user logged in");
      } else {
        _fireBaseAuthRepo.tryCreateUserData(_user).then(
          (value) async {
            FirsebaseUserModel _firebaseUser =
                await _fireBaseAuthRepo.getUserDetails(_user);

            MemoryManagement.saveUserDetails(_firebaseUser);

            Provider.of<LoginInfoViewModel>(context, listen: false)
                .signIn(_firebaseUser);
          },
        );
        setState(ViewState.loaded);

        Navigator.pushReplacementNamed(context, '/mainTab');

        showSnackBar("Registered successfully 🤩", context);

        log.d("user registered");
      }
    } on CustomException catch (e) {
      splitAndShowError(context, e.toString());
      setState(ViewState.error);
    } catch (e) {
      setState(ViewState.error);
      log.e(e.toString());
    }
  }
}
