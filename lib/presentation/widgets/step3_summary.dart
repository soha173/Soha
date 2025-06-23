import 'package:flutter/material.dart';

class Step3Summary extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step3Summary({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            GestureDetector(
              onTap: onBack,
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            const SizedBox(width: 8),
            const Text(
              "Appointment Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 24),

        /// Doctor Info (static for now)
        Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage("assets/images/Image.png"),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Dr. Randy Wigham", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text("General | RSUD Gatot Subroto", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),

        const SizedBox(height: 24),

        /// Info Table
        summaryItem("Date", "Tue 07, June"),
        summaryItem("Time", "09.30 AM"),
        summaryItem("Type", "In Person"),
        summaryItem("Payment", "Master Card"),

        const Spacer(),

        /// Confirm Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget summaryItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
