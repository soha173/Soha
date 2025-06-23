import 'package:appointment_app/core/colors-manager.dart';
import 'package:appointment_app/logic/get_doc/list_cubit.dart';
import 'package:appointment_app/logic/get_doc/list_state.dart';
import 'package:appointment_app/presentation/screens/booking_appointment.dart';
import 'package:appointment_app/presentation/screens/doctors_catogry.dart';
import 'package:appointment_app/presentation/screens/recommendation_doctor.dart';
import 'package:appointment_app/presentation/screens/user_profile.dart';
import 'package:appointment_app/presentation/screens/userwrapper.dart';
import 'package:appointment_app/presentation/widgets/Doctor_Category.dart';
import 'package:appointment_app/presentation/widgets/doc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appointment_app/logic/user/user_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
     HomeContent(),
     RecommendationDoctor(),
     BookAppointmentScreen(),
    UserProfileWrapper(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: ColorsManager.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DoctorCubit()..getDoctors()),
        BlocProvider(create: (_) => UserCubit()..fetchUserProfile()),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        String userName = "User";
                        if (state is UserLoaded) {
                          userName = state.user.name ?? "User";
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, $userName",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "How Are you Today?",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        );
                      },
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.notifications, color: Colors.black),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Book and schedule with nearest doctor",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                                foregroundColor:
                                MaterialStateProperty.all(Colors.blue),
                              ),
                              child: const Text("Find Nearby"),
                            ),
                          ],
                        ),
                      ),
                      Image.asset("assets/images/doctorgirl.png", width: 100),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Doctor Speciality
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Doctor Speciality",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DoctorsCatogry()),
                        );
                      },
                      child: const Text("See All", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const DoctorCategory(),

                const SizedBox(height: 20),

                // Recommendation Doctor
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommendation Doctor",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RecommendationDoctor()),
                        );
                      },
                      child: const Text("See All", style: TextStyle(color: Colors.blue)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                BlocBuilder<DoctorCubit, DoctorState>(
                  builder: (context, state) {
                    if (state is DoctorLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DoctorLoaded) {
                      final doctors = state.doctors;
                      return SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            return DocWidget(doctor: doctors[index]);
                          },
                        ),
                      );
                    } else if (state is DoctorError) {
                      return Center(child: Text("Error: ${state.message}"));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
