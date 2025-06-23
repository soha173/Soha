import 'package:flutter/material.dart';

class Step2Payment extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step2Payment({
    required this.onNext,
    required this.onBack,
    super.key,
  });

  @override
  State<Step2Payment> createState() => _Step2PaymentState();
}

class _Step2PaymentState extends State<Step2Payment> {
  String? selectedOption;

  final List<String> creditCards = [
    "Master Card",
    "American Express",
    "Capital One",
    "Barclays"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Back Button + Title
          Row(
            children: [
              IconButton(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 8),
              const Text(
                "Payment Option",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Credit Card Options
          Column(
            children: creditCards.map((card) {
              return RadioListTile(
                value: card,
                groupValue: selectedOption,
                onChanged: (value) => setState(() => selectedOption = value),
                title: Text(card),
                secondary: const Icon(Icons.credit_card),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          /// Bank Transfer
          RadioListTile(
            value: "Bank Transfer",
            groupValue: selectedOption,
            onChanged: (value) => setState(() => selectedOption = value),
            title: const Text("Bank Transfer"),
            secondary: const Icon(Icons.account_balance),
          ),

          /// Paypal
          RadioListTile(
            value: "Paypal",
            groupValue: selectedOption,
            onChanged: (value) => setState(() => selectedOption = value),
            title: const Text("Paypal"),
            secondary: const Icon(Icons.paypal),
          ),

          const Spacer(),

          /// Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedOption != null ? widget.onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Continue", style: TextStyle(color: Colors.white)),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
