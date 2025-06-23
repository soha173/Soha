// lib/cubits/doctor_cubit/doctor_cubit.dart
// lib/logic/get_doc/cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/doctor_model.dart';
import 'list_state.dart';


// lib/logic/get_doc/cubit.dart
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/doctor_model.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final Dio _dio = Dio();

  DoctorCubit() : super(DoctorInitial());

  Future<void> getDoctors() async {
    emit(DoctorLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final response = await _dio.get(
        'https://vcare.integration25.com/api/doctor/index',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token'
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        final doctors = data.map((json) => Doctor.fromJson(json)).toList();
        emit(DoctorLoaded(doctors));
      }
    } catch (e) {
      emit(DoctorError('Error fetching doctors: $e'));
    }
  }
}