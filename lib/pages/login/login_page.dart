import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../app_router.dart';
import '../../components/input_field.dart';
import '../../services/auth_service.dart';

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
  void initState() {
    super.initState();
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    bool isAuthenticated = await AuthService.isAuthenticated();
    if (isAuthenticated) {
      AppRouter.navigateToAndReplace(context, Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginBody(),
    );
  }

  void authenticate() async {
    bool isAuthenticated = await AuthService.signIn(email, password);
    if (isAuthenticated) {
      AppRouter.navigateToAndReplace(context, Routes.home);
    }
  }

  Widget loginBody() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.headlineMedium,
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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => authenticate(),
              child: Text(
                'Sign In',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Spacer(),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Don\'t have an account? '),
                  TextSpan(
                    text: 'Sign Up',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => AppRouter.navigateToAndReplace(
                          context, Routes.signUp),
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
