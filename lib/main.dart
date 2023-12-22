import 'package:core_soft_meeting/screens/home_page.dart';
import 'package:core_soft_meeting/screens/profile_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reuniones - CoreSoft',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/profile': (context) => ProfilePage(
          firstName: 'Sebastian',
          lastName: 'Padilla',
          email: 'padillasebastian140@gmail.com',
          role: 'Usuario',
        ),
      },
    );
  }
}
