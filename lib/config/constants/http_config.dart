import 'package:dio/dio.dart';

class DioConfig {
  static const String baseUrl = 'http://coresoft.tech:3000';

  static const Map<String, dynamic> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static const String contentType = 'application/json; charset=UTF-8';

  static final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: headers,
      contentType: contentType));
}