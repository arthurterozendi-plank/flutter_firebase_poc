import 'package:flutter/material.dart';

import '../../components/input_field.dart';
import '../login/login_page.dart';

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

  void createUser() {
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
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sign Up Successful'),
        content: Text('User created successfully'),
      ),
    );
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
