import 'package:flutter/material.dart';

class MedicineInfoCard extends StatelessWidget {
  final String imagePath;
  final String medicineName;
  final String dose;
  final String compliance;
  final String doctorName;

  const MedicineInfoCard({
    super.key,
    required this.imagePath,
    required this.medicineName,
    required this.dose,
    required this.compliance,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Capsule Image

            Container(
              width: 161,
              // هذا الحاوي الآن سيتمدد بكامل ارتفاع الـ Row
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Image.asset(
            //   imagePath,
            //   width: 140,
            //   //  height: 140,
            // ),
            const SizedBox(width: 20),

            // Medicine Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Name", style: TextStyle(color: Colors.grey)),
                Text(
                  medicineName,
                  style: const TextStyle(
                    color: Color(0xFF0A2942),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Dose", style: TextStyle(color: Colors.grey)),
                Text(
                  dose,
                  style: const TextStyle(
                    color: Color(0xFF0A2942),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                const Text("Compliance", style: TextStyle(color: Colors.grey)),
                Text(
                  compliance,
                  style: const TextStyle(
                    color: Color(0xFF0A2942),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "By : $doctorName",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
