import 'package:flutter/material.dart';

import '../home/home_page.dart';

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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: Theme.of(context).textTheme.headlineMedium),
            inputField('Email', Icons.email, (value) => email = value, false),
            inputField(
                'Password', Icons.lock, (value) => password = value, true),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () => authenticate(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Text('Login',
                    style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }

  Widget inputField(String label, IconData icon, Function(String) onChanged,
      bool obscureText) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText ? !showPassword : obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: obscureText
            ? IconButton(
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => showPassword = !showPassword),
              )
            : null,
      ),
    );
  }
}
