import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case HomePage.routeName:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text('Error'))));
  }
}

