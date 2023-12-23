import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  late SharedPreferences _prefs;

  factory UserPreferences() => _instance;

  UserPreferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get prefsUser => _prefs;

  String get token => _prefs.getString('token') ?? '';
  String get id => _prefs.getString('id') ?? '';
  String get email => _prefs.getString('email') ?? '';
  String get nombre => _prefs.getString('nombre') ?? '';
  String get apellido => _prefs.getString('apellido') ?? '';
  String get role => _prefs.getString('role') ?? '';

  set token(String token) => _prefs.setString('token', token);
  set id(String id) => _prefs.setString('id', id);
  set email(String email) => _prefs.setString('email', email);
  set nombre(String nombre) => _prefs.setString('nombre', nombre);
  set apellido(String apellido) => _prefs.setString('apellido', apellido);
  set role(String role) => _prefs.setString('role', role);

  static void saveUserPreferences(Map<String, dynamic> dataMap) {
    final prefs = UserPreferences();

    prefs.token = dataMap['accessToken'];
    prefs.id = dataMap['User']['id'];
    prefs.email = dataMap['User']['email'];
    prefs.nombre = dataMap['User']['nombre'];
    prefs.apellido = dataMap['User']['apellido'];
    prefs.role = dataMap['User']['role'];
  }

  void clearUser() {
    _prefs.setString('token', '');
    _prefs.setString('id', '');
    _prefs.setString('email', '');
    _prefs.setString('nombre', '');
    _prefs.setString('apellido', '');
    _prefs.setString('role', '');
  }
}
