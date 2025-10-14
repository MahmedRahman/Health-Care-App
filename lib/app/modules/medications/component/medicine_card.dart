import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_app/app/modules/medications/component/progress_status_bar.dart';
import 'package:health_care_app/app/widgets/base_image_card.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final String dose;
  final String route;
  final String description;
  final List<dynamic> timings;
  final String tablets;
  final double progress; // value between 0.0 and 1.0
  final int daysLeft;
  final String imagePath;
  final String totalDoses;
  final String countOfDose;
  final void Function()? onTap;
  final void Function()? onCheckDoneTap;

  const MedicineCard({
    super.key,
    required this.medicineName,
    required this.dose,
    required this.route,
    required this.description,
    required this.timings,
    required this.tablets,
    required this.progress,
    required this.daysLeft,
    required this.imagePath,
    required this.onTap,
    required this.onCheckDoneTap,
    required this.totalDoses,
    required this.countOfDose,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Row (image + info)

            Base64ImageCard(
              base64String: imagePath,
            ),
            const SizedBox(height: 12),
            IntrinsicHeight(
              child: Row(
                children: [
                  // Image
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicineName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(text: 'Timing: '),
                              for (int i = 0; i < timings.length; i++) ...[
                                TextSpan(
                                  text: timings[i]['doseTime'],
                                  style: TextStyle(
                                    color: i == 0 ? Colors.blue : Colors.black,
                                  ),
                                ),
                                if (i != timings.length - 1)
                                  const TextSpan(text: ' | ')
                              ],
                            ],
                          ),
                        ),
                        Text('Dose: $dose $tablets '),
                        Text('Route: $route'),
                        Text('Description: $description'),
                        Text('totalDoses: $totalDoses'),
                        Text('countOfDose: $countOfDose'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Done Button Style
            InkWell(
              onTap: onCheckDoneTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F5FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Check Done',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            ProgressStatusBar(
              percentage: progress,
              daysLeft: daysLeft,
            ),
          ],
        ),
      ),
    );
  }
}
