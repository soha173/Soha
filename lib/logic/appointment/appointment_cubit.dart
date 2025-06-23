import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final Dio _dio = Dio();

  AppointmentCubit() : super(AppointmentInitial());

  Future<void> fetchAppointments() async {
    emit(AppointmentLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        emit(AppointmentError("Token is missing"));
        return;
      }

      final response = await _dio.get(
        "https://vcare.integration25.com/api/appointment/index",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print('Raw API response: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic>? data = response.data['data'];

        if (data == null || data.isEmpty) {
          print('API data is empty, using fallback test data');
          // استخدام بيانات تجريبية بدل البيانات الفارغة
          final fallbackAppointments = [
            DateTime.now(),
            DateTime.now().add(Duration(days: 1, hours: 3)),
            DateTime.now().add(Duration(days: 2, hours: 5)),
          ];
          emit(AppointmentLoaded(fallbackAppointments));
          return;
        }

        final appointments = <DateTime>[];

        for (var item in data) {
          try {
            final dateStr = item['date'] as String?;
            final timeStr = item['time'] as String?;

            if (dateStr == null || timeStr == null) {
              print('Skipping item with null date or time: $item');
              continue;
            }

            final dateTime = DateTime.parse('$dateStr $timeStr');
            appointments.add(dateTime);
          } catch (e) {
            print('Failed to parse date/time for item $item: $e');
          }
        }

        print('Parsed appointments count: ${appointments.length}');

        if (appointments.isEmpty) {
          print('Parsed appointments list is empty, using fallback test data');
          final fallbackAppointments = [
            DateTime.now(),
            DateTime.now().add(Duration(days: 1, hours: 3)),
            DateTime.now().add(Duration(days: 2, hours: 5)),
          ];
          emit(AppointmentLoaded(fallbackAppointments));
          return;
        }

        emit(AppointmentLoaded(appointments));
      } else {
        emit(AppointmentError("خطأ في الاتصال بالسيرفر: ${response.statusCode}"));
      }
    } catch (e) {
      emit(AppointmentError("فشل الاتصال: $e"));
    }
  }
}
