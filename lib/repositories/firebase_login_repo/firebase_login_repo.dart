import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import '../../models/firebase_user_model/firebase_user_model.dart';
import '../../services/network/custom_exceptions.dart';
import '../../utils/shared_prefs/memory_management.dart';

import '../../locator.dart';

abstract class AuthRepo {
  User getCurrentUser();

  Future<FirsebaseUserModel> getUserDetails(User user);

  Stream<User> authStateChanges();

  Future<UserCredential> signInWithGoogle();

  Future signUpWithEmailAndPassword({String email, String password});

  Future signInWithEmailAndPassword({String email, String password});

  Future signOut();

  Future<bool> authenticateUser(User user);

  Future<void> tryCreateUserData(User user);

  Stream<DocumentSnapshot> getUserSnapshot(userId);
}

class FireBaseAuthRepo extends AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Logger log = locator.get<Logger>();

  @override
  User getCurrentUser() {
    User currentUser;
    currentUser = _auth.currentUser;
    return currentUser;
  }

  @override
  Future<FirsebaseUserModel> getUserDetails(User user) async {
    final DocumentSnapshot _snapShot = await _fireStore
        .collection("users")
        .doc(user.uid)
        .get()
        .catchError((err) => throw err);
    return FirsebaseUserModel.fromMap(_snapShot.data());
  }

  @override
  Stream<User> authStateChanges() {
    return _auth.authStateChanges();
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential _userCred = await _auth.signInWithCredential(credential);

      return _userCred;
    } on PlatformException catch (err) {
      // Checks for type PlatformException
      if (err.code == 'sign_in_canceled') {
        // Checks for sign_in_canceled exception
        throw GoogleSignInCancelledException();
      } else {
        throw err; // Throws PlatformException again because it wasn't the one we wanted
      }
    }
  }

  @override
  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log.e('No user found for that email.');
        throw FirebaseNoUserFoundException();
      } else if (e.code == 'wrong-password') {
        log.e('Wrong password provided for that user.');
        throw FirebaseWrongPasswordException();
      } else if (e.code == 'invalid-email') {
        log.e('Your email address appears to be malformed.');
        throw FirebaseInvalidEmailException();
      } else if (e.code == 'network-request-failed') {
        log.e('Oops no network connection');
        throw FirebaseNetworkFailedException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future signUpWithEmailAndPassword({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log.e('The password provided is too weak.');
        throw FirebaseWeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        log.e('The account already exists for that email.');
        throw FirebaseEmailAlreadyInUseException();
      } else if (e.code == 'invalid-email') {
        log.e('Your email address appears to be malformed.');
        throw FirebaseInvalidEmailException();
      } else if (e.code == 'network-request-failed') {
        log.e('Oops no network connection');
        throw FirebaseNetworkFailedException();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      MemoryManagement.clearMemory();
    } catch (e) {
      log.e(e.toString());
    }
  }

  @override
  Future<bool> authenticateUser(User user) async {
    final QuerySnapshot result = await _fireStore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .get()
        .catchError((err) => throw err);

    final List<DocumentSnapshot> docs = result.docs;

    if (docs.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> tryCreateUserData(User currentUser) async {
    FirsebaseUserModel _user = FirsebaseUserModel(
      uid: currentUser.uid,
      email: currentUser.email,
      displayName: currentUser.displayName,
      photoUrl: currentUser.photoURL,
    );

    return _fireStore
        .collection("users")
        .doc(currentUser.uid)
        .set(_user.toMap(_user))
        .catchError((err) => print(err));
  }

  Stream<DocumentSnapshot> getUserSnapshot(userId) {
    return _fireStore.collection("users").doc(userId).snapshots();
  }
}
