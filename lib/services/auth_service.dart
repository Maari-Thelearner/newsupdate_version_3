import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Future<UserCredential> signInWithCredential(AuthCredential credential) => 
  _auth.signInWithCredential(credential);
  signup(String email , String password) => _auth.createUserWithEmailAndPassword(email: email, password:password );
  signin(String email,String password) {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    catch (error) {
      print(error);
    }
  }
  Future<void> logout() => _auth.signOut();
  Stream<User> get currentUser => _auth.authStateChanges();
}