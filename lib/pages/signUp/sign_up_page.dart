import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_poc/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../app_router.dart';
import '../../components/input_field.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signUp';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  Future<void> createUser() async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return;
    }
    if (name.length < 3) {
      Fluttertoast.showToast(
        msg: 'Name must be at least 3 characters',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return;
    }
    if (password != confirmPassword) {
      Fluttertoast.showToast(
        msg: 'Passwords do not match',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    User? user = await AuthService.signUp(email, password, name);
    if (user != null) {
      AppRouter.navigateToAndReplace(context, Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Create account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            CustomInputField(
              label: 'Name',
              icon: Icons.person,
              onChanged: (value) => name = value,
            ),
            CustomInputField(
              label: 'Email',
              icon: Icons.email,
              onChanged: (value) => email = value,
            ),
            CustomInputField(
              label: 'Password',
              icon: Icons.lock,
              onChanged: (value) => password = value,
              obscureText: true,
            ),
            CustomInputField(
              label: 'Confirm Password',
              icon: Icons.lock,
              onChanged: (value) => confirmPassword = value,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => createUser(),
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Already have an account? '),
                  TextSpan(
                    text: 'Sign In',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          AppRouter.navigateToAndReplace(context, Routes.login),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
