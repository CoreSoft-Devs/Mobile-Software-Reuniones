import 'package:core_soft_meeting/config/constants/http_config.dart';
import 'package:intl/intl.dart';

class MeetingServices {

  Future<List<Map<String, dynamic>>> getAllMeetings(DateTime date) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await DioConfig.dio.get(
        '/api/reunion/all',
        queryParameters: {
          'value': formattedDate,
          'attr': 'fecha',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Error al obtener las reuniones');
      }
    } catch (e) {
      throw Exception('Error al obtener las reuniones');
    }
  }
}
