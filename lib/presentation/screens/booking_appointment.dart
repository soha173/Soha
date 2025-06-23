import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appointment_app/presentation/widgets/step1_datetime.dart';
import 'package:appointment_app/presentation/widgets/step2_payment.dart';
import 'package:appointment_app/presentation/widgets/step3_summary.dart';
import 'package:appointment_app/presentation/widgets/step4_confirmation.dart';
import '../../logic/appointment/appointment_cubit.dart';

class BookAppointmentScreen extends StatefulWidget {
  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  int _currentStep = 0;
  late final AppointmentCubit appointmentCubit;

  @override
  void initState() {
    super.initState();
    appointmentCubit = AppointmentCubit()..fetchAppointments();
  }

  @override
  void dispose() {
    appointmentCubit.close();
    super.dispose();
  }

  void nextStep() {
    if (_currentStep < 3) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void finishFlow() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appointmentCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Book Appointment", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: _currentStep == 0
              ? null
              : IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: previousStep,
          ),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            final List<Widget> _steps = [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Step1Datetime(onNext: nextStep),
              ),
              Step2Payment(onNext: nextStep, onBack: previousStep),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Step3Summary(onNext: nextStep, onBack: previousStep),
              ),
              Step4Confirmation(onFinish: finishFlow),
            ];

            return _steps[_currentStep];
          },
        ),
      ),
    );
  }
}
