//this file manages the authentication tasks of the ssmail app
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //object of firebase auth service
  static final _auth = FirebaseAuth.instance;

  //get method to get current users. can be null if not logged in
  static User? get currentUser => _auth.currentUser;

  //sign in user with email & password
  static Future<UserCredential> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return credential;
  }

  //sign up with email and password
  static Future<UserCredential> signUp(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credential;
  }

  //sign out
  static Future<void> signOut() => _auth.signOut();
}
