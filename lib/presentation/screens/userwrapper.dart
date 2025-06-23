import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appointment_app/logic/user/user_cubit.dart';
import 'user_profile.dart';

class UserProfileWrapper extends StatelessWidget {
  const UserProfileWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit()..fetchUserProfile(),
      child: const UserProfile(),
    );
  }
}
