import 'dart:convert';
import 'package:appointment_app/data/doctor_model.dart';
import 'package:appointment_app/logic/search&filter/search_filter_state.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

class SearchFilterCubit extends Cubit<SearchFilterState> {
  SearchFilterCubit() : super(const SearchFilterInitial());

  final String _token = 'Bearer YOUR_TOKEN_HERE'; // ✅ استبدل YOUR_TOKEN_HERE بالتوكن الحقيقي

  Future<void> searchDoctors(String name) async {
    emit(const SearchFilterLoading());
    try {
      final url = Uri.parse('https://vcare.integration25.com/api/doctor/doctor-search?name=$name');
      final response = await http.get(
        url,
        headers: {
          'Authorization': _token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List doctorsJson = data['doctors'] ?? data;
        final doctors = doctorsJson.map<Doctor>((json) => Doctor.fromJson(json)).toList();
        emit(SearchFilterLoaded(doctors));
      } else {
        emit(SearchFilterError('Failed to search doctors, status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SearchFilterError(e.toString()));
    }
  }

  Future<void> filterDoctors(int cityId) async {
    emit(const SearchFilterLoading());
    try {
      final url = Uri.parse('https://vcare.integration25.com/api/doctor/doctor-filter?city=$cityId');
      final response = await http.get(
        url,
        headers: {
          'Authorization': _token,
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List doctorsJson = data['doctors'] ?? data;
        final doctors = doctorsJson.map<Doctor>((json) => Doctor.fromJson(json)).toList();
        emit(SearchFilterLoaded(doctors));
      } else {
        emit(SearchFilterError('Failed to filter doctors, status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SearchFilterError('Error fetching doctors: $e'));
    }
  }
}
