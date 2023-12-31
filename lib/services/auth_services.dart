import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:core_soft_meeting/config/constants/http_config.dart';
import 'package:core_soft_meeting/share_preferens/user_preferences.dart';

class AuthServices {
  Future<String> postLogin(String email, String password) async {
    try {
      final response =
          await DioConfig.dioWithoutAuthorization.post('/api/login', data: {
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
    } on DioException catch (e) {
      throw Exception(e.response!.data['message']);
    }
  }

  Future<String> postRegister(
    String firstName,
    String lastName,
    String email,
    String password,
    String tokenMobile,
    String role,
  ) async {
    if (role == 'Administrador') {
      role = 'admin';
    } else {
      role = 'basic';
    }
    try {
      final response =
          await DioConfig.dioWithoutAuthorization.post('/api/register', data: {
        'nombre': firstName,
        'apellido': lastName,
        'email': email,
        'password': password,
        'tokenMobile': tokenMobile,
        'role': role,
      });
      final json = jsonDecode(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        // UserPreferences.saveUserPreferences(response.data);
        String userId = json['id'];
        return userId;
      } else {
        throw Exception('Error en la solicitud');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<String> updateUserToken(String tokenMobile, String password) async {
    try {
      String id = UserPreferences().id;
      final response =
          await DioConfig.dioWithAuthorization.patch('/api/user/$id', data: {
        'id': id,
        'nombre': UserPreferences().nombre,
        'apellido': UserPreferences().apellido,
        'email': UserPreferences().email,
        'password': password,
        'role': UserPreferences().role,
        'tokenMobile': tokenMobile,
      });
      final json = jsonDecode(response.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        // UserPreferences.saveUserPreferences(response.data);
        String userId = json['id'];
        return userId;
      } else {
        throw Exception('Error en la solicitud');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}
