import 'package:flutter/material.dart';

import '../../core/colors-manager.dart';

class DoctorCategory extends StatelessWidget {
  const DoctorCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context,index) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: ColorsManager.iconcolor,
                          child: Icon(Icons.medical_information, color: ColorsManager.primaryColor),
                        ),
                        SizedBox(height: 10,),
                        Text("General", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,),),
                      ],
                    ),
                  ),
                ],
              );
            },


          ),
        ),

      ],
    );
  }
}
