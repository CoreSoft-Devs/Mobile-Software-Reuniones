import 'package:core_soft_meeting/share_preferens/user_preferences.dart';
import 'package:dio/dio.dart';

class DioConfig {
  static const String baseUrl = 'http://coresoft.tech:3000';

  static Map<String, dynamic> getHeaders() {
    final prefs = UserPreferences();
    final token = prefs.token;
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  static const String contentType = 'application/json; charset=UTF-8';

  static final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: getHeaders(),
      contentType: contentType));
}