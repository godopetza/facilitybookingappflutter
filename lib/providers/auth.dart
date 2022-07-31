// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:facilities_booking_unionsuites/models/user.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  FirebaseUser? _userFromFirebaseUser(User user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  // auth change user stream
  // Stream<User> get user {
  //   return _auth.onAuthStateChanged
  //     //.map((FirebaseUser user) => _userFromFirebaseUser(user));
  //     .map(_userFromFirebaseUser);
  // }

  //sign in anon
  Future signInAnon() async {
    
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email & password
  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: emailController.text.trim(),
  //     password: passwordController.text.trim(),
  //   );
  // }

  //Sign Out
}
