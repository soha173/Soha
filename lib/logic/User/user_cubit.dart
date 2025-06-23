import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:appointment_app/data/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> fetchUserProfile() async {
    emit(UserLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        emit(UserError("Missing auth token"));
        return;
      }

      final response = await http.get(
        Uri.parse('https://vcare.integration25.com/api/user/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'];

        final userData = data is List ? data[0] : data;

        final user = UserModel.fromJson(userData);
        emit(UserLoaded(user));
      } else {
        emit(UserError('Failed to load profile: ${response.statusCode}'));
      }
    } catch (e) {
      emit(UserError('Error loading profile: $e'));
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    String? phone,
  }) async {
    emit(UserUpdating());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        emit(UserError("Missing auth token"));
        return;
      }

      final response = await http.post(
        Uri.parse('https://vcare.integration25.com/api/user/update'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          if (phone != null) 'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final data = jsonData['data'];

        final userData = data is List ? data[0] : data;

        final user = UserModel.fromJson(userData);
        emit(UserUpdated(user));
      } else {
        emit(UserError('Update failed: ${response.statusCode}'));
      }
    } catch (e) {
      emit(UserError('Error updating profile: $e'));
    }
  }
}
