import 'package:appointment_app/presentation/widgets/Doctor_Category.dart';
import 'package:appointment_app/presentation/widgets/grid_category.dart';
import 'package:appointment_app/presentation/widgets/rec_doctor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: DoctorCategory()));
}

class DoctorsCatogry extends StatelessWidget {
  const DoctorsCatogry({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Doctor Speciality",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            SizedBox(height: 16),
            GridCategory(),
          ],
        ),
      ),
    );
  }
}
