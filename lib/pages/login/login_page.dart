import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../signUp/sign_up_page.dart';
import '../../components/input_field.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginBody(),
    );
  }

  void authenticate() {
    if (email == 'admin' && password == 'admin') {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password'),
        ),
      );
    }
  }

  Widget loginBody() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login', style: Theme.of(context).textTheme.headlineMedium),
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
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => authenticate(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(SignUpPage.routeName),
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
