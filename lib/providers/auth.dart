import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User? get currentUser => _auth.currentUser;

  // auth change user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // sign in email & password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> getCurrentUID() async {
    return (_auth.currentUser!).uid;
  }

  //Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    // try {
    //   return await _auth.signOut();
    // } catch (error) {
    //   print(error.toString());
    //   return null;
    // }
  }
}
