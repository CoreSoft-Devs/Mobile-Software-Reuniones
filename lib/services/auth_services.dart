import 'dart:convert';

import 'package:core_soft_meeting/config/constants/http_config.dart';
import 'package:core_soft_meeting/share_preferens/user_preferences.dart';

class AuthServices {
  Future<String> postLogin(String email, String password) async {
    try {
      final response = await DioConfig.dio.post('/api/login', data: {
        'email': email,
        'password': password,
      });
      final json = jsonDecode(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserPreferences.saveUserPreferences(response.data);
        String userId = json['User']['id'];
        return userId;
      } else {
        throw Exception('Error en la solicitud');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
