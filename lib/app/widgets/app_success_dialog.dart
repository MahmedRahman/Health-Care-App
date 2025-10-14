import 'package:flutter/material.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';

void showSuccessDialog(BuildContext context,
    {required String userId, required VoidCallback onAddInfo}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circle icon
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.check_circle,
                    color: Colors.green, size: 48),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your account successfully\ngenerated",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                "Your ID : $userId",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              AppPrimaryButton(
                text: "Done",
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  onAddInfo();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
