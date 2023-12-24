import 'package:flutter/material.dart';

import '../../screens/index.dart';
import '../../share_preferens/user_preferences.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
}

Map<String, WidgetBuilder> getApplicationRoutes() {
  final prefs = UserPreferences();
  return {
    Routes.login: (context) => const LoginPage(),
    '/': (context) => prefs.token == ''
        ? const LoginPage()
        : const HomePage(), // Si no hay token, redirige a login
    Routes.home: (context) => const HomePage(),
  };
}
