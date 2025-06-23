import 'package:appointment_app/data/doctor_model.dart';
import 'package:appointment_app/logic/get_doc/list_cubit.dart';
import 'package:appointment_app/logic/get_doc/list_state.dart';
import 'package:appointment_app/logic/search&filter/search_filter_state.dart';
import 'package:appointment_app/presentation/widgets/doc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/colors-manager.dart';
import '../../logic/search&filter/search_filter_cubit.dart';

class RecommendationDoctor extends StatefulWidget {
  const RecommendationDoctor({super.key});

  @override
  State<RecommendationDoctor> createState() => _RecommendationDoctorState();
}

class _RecommendationDoctorState extends State<RecommendationDoctor> {
  late final DoctorCubit doctorCubit;
  late final SearchFilterCubit searchFilterCubit;

  @override
  void initState() {
    super.initState();
    doctorCubit = DoctorCubit()..getDoctors();
    searchFilterCubit = SearchFilterCubit();
  }

  @override
  void dispose() {
    doctorCubit.close();
    searchFilterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorCubit>.value(value: doctorCubit),
        BlocProvider<SearchFilterCubit>.value(value: searchFilterCubit),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:  Text(
            "Recommendation Doctor",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        decoration:  InputDecoration(
                          hintText: "Search by name",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            searchFilterCubit.searchDoctors(value);
                          } else {
                            // لو مربع البحث فاضي، نعرض كل الدكاترة من DoctorCubit
                            doctorCubit.getDoctors();
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon:  Icon(Icons.filter_list),
                      onPressed: () {
                        searchFilterCubit.filterDoctors(7);
                      },
                    ),
                  ],
                ),
              ),
               SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchFilterCubit, SearchFilterState>(
                  builder: (context, searchState) {
                    if (searchState is SearchFilterLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (searchState is SearchFilterLoaded) {
                      final doctors = searchState.doctors;
                      if (doctors.isEmpty) {
                        return const Center(child: Text('No doctors found'));
                      }
                      return ListView.builder(
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          final doctor = doctors[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(doctor.photo),
                            ),
                            title: Text(doctor.name),
                            subtitle: Text(doctor.specialization.name),
                          );
                        },
                      );
                    } else if (searchState is SearchFilterError) {
                      return Center(child: Text('Error: ${searchState.message}'));
                    } else {
                      // لو مفيش بحث أو فلترة نشوف بيانات DoctorCubit الافتراضية
                      return BlocBuilder<DoctorCubit, DoctorState>(
                        builder: (context, doctorState) {
                          if (doctorState is DoctorLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (doctorState is DoctorLoaded) {
                            final doctors = doctorState.doctors;
                            if (doctors.isEmpty) {
                              return const Center(child: Text('No doctors found'));
                            }
                            return SizedBox(
                              height: 500,
                              child: ListView.builder(
                                itemCount: doctors.length,
                                itemBuilder: (context, index) {
                                  final y = doctors[index];
                                  return DocWidget(doctor: y);
                                },
                              ),
                            );
                          } else if (doctorState is DoctorError) {
                            return Center(child: Text('Error: ${doctorState.message}'));
                          } else {
                            return  Center(child: Text('Start searching or filtering'));
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
