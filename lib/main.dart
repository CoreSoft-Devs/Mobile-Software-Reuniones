import 'package:core_soft_meeting/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'config/navigation/application_routes.dart';
import 'share_preferens/user_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Servicio Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final token = await FirebaseMessaging.instance.getToken();
  print(token);

  // Shared Preferences
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reuniones - CoreSoft',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: /* {
        '/': (context) => const HomePage(),
        '/profile': (context) => ProfilePage(
          firstName: 'Sebastian',
          lastName: 'Padilla',
          email: 'padillasebastian140@gmail.com',
          role: 'Usuario',
        ),
      } */
          getApplicationRoutes(),
    );
  }
}
