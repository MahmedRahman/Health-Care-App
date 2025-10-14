import 'package:flutter/material.dart';
import 'package:health_care_app/app/constants/colors.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Terms and Conditions Agreement\nand Liability Disclaimer",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "Dear user,\nIn this agreement, the Heart Care App is referred to as the application, and you are referred to as the user.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "Liability Disclaimer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "By using this mobile app, you acknowledge and agree that use of the app is at your own risk. The app and its contents are provided on an \"as-is\" basis without warranties of any kind, either express or implied. We make no representations or guarantees regarding the accuracy, reliability, or completeness of the information provided. We are not liable for any direct, indirect, incidental, or consequential damages arising out of or related to your use or inability to use the app, including any harm to your device or loss of data. In no event will we be responsible for damages exceeding the amount paid by you, if any, for accessing this app. By continuing to use the app, you agree to release us from all liability related to your use of the app, subject to applicable law.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "The conditions:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            buildCondition(1,
                "The Heart Care App has the right to change these terms/conditions at any time by publishing the new terms on our website or informing you of the new terms through your registered email with us. You acknowledge your agreement to this once you use this application."),
            buildCondition(2,
                "The application provides heart care medical services, allowing the patient to check disease status and communicate with the doctor via chat or video call. The patient manually enters test results, and the doctor gives advice. Medication reminders are also provided. Payment is made electronically."),
            buildCondition(3,
                "The user must inform the doctor of all required information to receive appropriate advice and treatment."),
            buildCondition(4,
                "The user must follow the doctor's instructions within the specified time to minimize risks."),
            buildCondition(5,
                "The user agrees to deduct the specified amount from their bank card or any electronic payment method before paying."),
            buildCondition(6,
                "The user acknowledges the doctor’s limited responsibility and that no guaranteed result is promised. The doctor is not liable for misunderstandings, misuse, or technical errors."),
            buildCondition(7,
                "The user may not probe or attack the system, spam, distribute viruses, or misuse the services in any illegal or unauthorized way."),
            buildCondition(8,
                "The user acknowledges that all personal information provided is accurate and accepts responsibility for any damages resulting from incorrect data."),
            buildCondition(9,
                "The user is responsible for maintaining account confidentiality and must notify us immediately in case of hacking or misuse."),
            buildCondition(10,
                "The user does not have the right to quote or use any ownership rights from the app or website."),
            buildCondition(11,
                "The user bears full responsibility for all account activities."),
            buildCondition(12,
                "If the password is entered incorrectly three times in a row, the account will be suspended. The user must contact us to reactivate after verification."),
            buildCondition(13,
                "The user agrees to receive notices via their registered email or phone number."),
          ],
        ),
      ),
    );
  }

  Widget buildCondition(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$number. ",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
