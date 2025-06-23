import 'package:appointment_app/logic/user/user_cubit.dart';
import 'package:appointment_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserCubit()..fetchUserProfile(),
      child: const MaterialApp(
        title: 'Doc Doc',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
