import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  const FirebaseService._();

  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> signUp(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name);
        return user;
      }
      return null;
    } catch (e) {
      print('Firebase SignUp Error: $e');
      return null;
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      print('Firebase SignIn Error: $e');
      return null;
    }
  }
}
