import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/user.dart';
import 'user_firestore_services.dart';

class AuthService {
  const AuthService._();

  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<bool> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null) {
        return false;
      }

      await userCredential.user!.updateDisplayName(name);
      await UserFirestoreService.addUser(UserModel(
        email: email,
        name: name,
        uid: userCredential.user!.uid,
        createdAt: DateTime.now().toIso8601String(),
      ));
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email already in use';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Weak password';
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    } catch (e) {
      print('Firebase SignUp Error: $e');
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'User not found';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email';
      } else {
        errorMessage = 'Something went wrong';
      }
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return false;
    } catch (e) {
      print('Firebase SignIn Error: $e');
      return false;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> isAuthenticated() async {
    return auth.currentUser != null;
  }
}
