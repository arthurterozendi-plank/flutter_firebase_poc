import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_poc/services/auth_services.dart';
import 'package:flutter/material.dart';

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
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign Up Failed'),
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }
    if (name.length < 3 || email.length < 3 || password.length < 3) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign Up Failed'),
          content: Text('Fields must be at least 3 characters'),
        ),
      );
      return;
    }
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign Up Failed'),
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }
    User? user = await AuthService.signUp(email, password, name);
    if (user != null) {
      AppRouter.navigateToAndReplace(context, Routes.login);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Sign Up Failed'),
          content: Text('User creation failed'),
        ),
      );
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
            Text('Sign Up', style: Theme.of(context).textTheme.headlineMedium),
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
            ElevatedButton(
              onPressed: () => createUser(),
              child: Text('Sign Up',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
