/// Importing firebase_auth as auth (therefore all classes are auth.Class) to avoid
/// naming conflict. This was Google's recommendation
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/user.dart';

class FirebaseAuthService extends ChangeNotifier {
  final auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthService(
      {auth.FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  User _userFromFirebase(auth.User user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Stream<User> get onAuthStateChanged {
    notifyListeners();
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    notifyListeners();
    return _userFromFirebase(authResult.user);
  }

  Future<User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    final user = _userFromFirebase(authResult.user);
    print('User from firebase is $user');
    notifyListeners();
    return _userFromFirebase(authResult.user);
  }

  Future<void> signOut() async {
    final signedOut = await _firebaseAuth.signOut();
    notifyListeners();
    return signedOut;
  }

  Future<User> get currentUser async {
    final user = await _firebaseAuth.currentUser;
    if (user == null) {
      return null;
    }
    return _userFromFirebase(user);
  }
}
