import 'package:core_soft_meeting/share_preferens/user_preferences.dart';
import 'package:flutter/material.dart';

import '../config/navigation/application_routes.dart';
import '../screens/index.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos Usuario Shared Preferences
    final prefs = UserPreferences();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 10, 40, 66),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width < 600 ? 30 : 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage('assets/images/user.png'),
                ),
                const SizedBox(height: 10),
                Text(
                  prefs.nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width < 600 ? 14 : 18,
                  ),
                ),
                Text(
                  prefs.email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width < 600 ? 12 : 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.black),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.pop(context);
              /*  Navigator.pushNamed(context, '/profile', arguments: {
                'firstName': prefs.nombre,
                'lastName': prefs.apellido,
                'email': prefs.email,
                'role': prefs.role,
              }); */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    firstName: prefs.nombre,
                    lastName: prefs.apellido,
                    email: prefs.email,
                    role: prefs.role == 'admin' ? 'Administrador' : 'Usuario',
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.black),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              prefs.clearUser();
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          ),
        ],
      ),
    );
  }
}
