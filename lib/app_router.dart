import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'pages/signUp/sign_up_page.dart';

enum Routes {
  login('/login'),
  home('/'),
  signUp('/signUp');

  final String routeName;
  const Routes(this.routeName);
}

class AppRouter {
  static navigateTo(BuildContext context, Routes route) {
    Navigator.of(context).pushNamed(route.routeName);
  }

  static navigateToAndReplace(BuildContext context, Routes route) {
    Navigator.of(context).pushReplacementNamed(route.routeName);
  }

  static Map<String, WidgetBuilder> get routes => {
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
      };
}
