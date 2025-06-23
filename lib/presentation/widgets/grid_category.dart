import 'package:flutter/material.dart';
import '../../core/colors-manager.dart';

class GridCategory extends StatelessWidget {
  const GridCategory({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات ثابتة للتخصصات
    final List<Map<String, dynamic>> categories = [
      {"title": "General", "icon": Icons.medical_information},
      {"title": "ENT", "icon": Icons.hearing},
      {"title": "Pediatric", "icon": Icons.child_care},
      {"title": "Dentistry", "icon": Icons.health_and_safety},
      {"title": "Cardiology", "icon": Icons.favorite},
      {"title": "Neurology", "icon": Icons.psychology},
      {"title": "Pulmonary", "icon": Icons.air},
      {"title": "Optometry", "icon": Icons.visibility},
      {"title": "Hepatology", "icon": Icons.cabin}, // Flutter icons don’t include liver — just an example
      {"title": "Urology", "icon": Icons.wc},
      {"title": "Intestine", "icon": Icons.hearing}, // Also not in Flutter, use placeholder
      {"title": "Histologist", "icon": Icons.biotech},
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 أعمدة
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8, // لضبط حجم العنصر
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: ColorsManager.iconcolor,
                child: Icon(
                  category['icon'],
                  color: ColorsManager.primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                category['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
