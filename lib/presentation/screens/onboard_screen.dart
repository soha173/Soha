import 'package:appointment_app/core/colors-manager.dart';
import 'package:appointment_app/presentation/screens/login.dart';
import 'package:appointment_app/presentation/screens/sign_up.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // صورة الخلفية
          Positioned.fill(
            child: Image.asset(
              'assets/images/doc.png', // استبدلها بالصورة بتاعتك
              fit: BoxFit.cover,
            ),
          ),

          // المحتوى فوق الصورة
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(height: 30),

                // اللوجو فوق
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                ),

                Spacer(),

                Spacer(),

                // الكلام والزرار تحت
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      Text(
                        'Best Doctor\nAppointment App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen() ));
                            // action on button press
                          },
                          child: Text(
                            'Get Started',
                            style: TextStyle(fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
