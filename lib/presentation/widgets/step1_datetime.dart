import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/appointment/appointment_cubit.dart';

class Step1Datetime extends StatefulWidget {
  final VoidCallback onNext;
  const Step1Datetime({required this.onNext, super.key});

  @override
  State<Step1Datetime> createState() => _Step1DateTimeState();
}

class _Step1DateTimeState extends State<Step1Datetime> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AppointmentError) {
          return Center(child: Text(state.message));
        } else if (state is AppointmentLoaded) {
          final appointments = state.appointments;

          // Group by day (just to display simply for now)
          final grouped = <String, List<DateTime>>{};
          for (var dateTime in appointments) {
            final dayKey = "${dateTime.weekday} ${dateTime.day.toString().padLeft(2, '0')}";
            grouped.putIfAbsent(dayKey, () => []).add(dateTime);
          }

          final dayKeys = grouped.keys.toList();

          // تحقق من وجود مواعيد
          if (dayKeys.isEmpty) {
            return const Center(child: Text("No available appointments"));
          }

          // تأكد أن selectedIndex داخل النطاق
          if (selectedIndex >= dayKeys.length) {
            selectedIndex = 0;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text("Select Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),

              /// Days
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dayKeys.length,
                  itemBuilder: (_, index) {
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedIndex = index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            dayKeys[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              const Text("Available time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),

              /// Times
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: grouped[dayKeys[selectedIndex]]!.map((dt) {
                  final timeText = TimeOfDay.fromDateTime(dt).format(context);
                  final isSelected = false; // you can add selection logic
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      timeText,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const Spacer(),
              SizedBox(width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onNext,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
                  padding:  EdgeInsets.symmetric(vertical: 16),
                  ),
                  child:  Text("Continue",
                  style:  TextStyle(fontSize: 16, color: Colors.white),),
                ),
              ),
              const SizedBox(height: 24),
            ],
          );
        } else {
          return const Center(child: Text("No appointments found."));
        }
      },
    );
  }
}
