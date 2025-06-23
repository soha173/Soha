import 'package:appointment_app/data/doctor_model.dart';
import 'package:appointment_app/presentation/screens/booking_appointment.dart';
import 'package:flutter/material.dart';

class DoctorDetailScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          title: Text(
            doctor.name,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "About"),
              Tab(text: "Location"),
              Tab(text: "Reviews"),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      doctor.photo,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/doc.png', width: 70, height: 70),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${doctor.specialization.name}  |  ${doctor.address}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              "4.8 (4,279 reviews)",
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                children: [
                  // ---------- About Tab ----------
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           SizedBox(height: 8),
                           Text(
                            "About me",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                           SizedBox(height: 8),
                          Text(
                            doctor.description ?? 'No description available.',
                            style:  TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                           SizedBox(height: 20),
                           Text(
                            "Working Time",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                           SizedBox(height: 4),
                           Text(doctor.startTime + " - " + doctor.endTime ??'No data available.' ),
                           SizedBox(height: 12),
                           Text(
                            "Phone Number",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                           SizedBox(height: 4),
                          Text(doctor.phone ?? 'Not available'),
                           SizedBox(height: 12),
                           Text(
                            "City",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                           SizedBox(height: 4),
                          Text(doctor.city.name ?? "Not available"),
                        ],
                      ),
                    ),
                  ),

                  // ---------- Location Tab ----------
                  Center(
                    child: Text("Address: ${doctor.address}"),
                  ),

                  // ---------- Reviews Tab ----------
                   Center(
                    child: Text("Patient reviews will be shown here."),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookAppointmentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Make An Appointment",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
