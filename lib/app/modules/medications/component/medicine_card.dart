import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_app/app/modules/medications/component/progress_status_bar.dart';

class MedicineCard extends StatelessWidget {
  final String medicineName;
  final String dose;
  final String route;
  final String description;
  final List<String> timings;
  final int tablets;
  final double progress; // value between 0.0 and 1.0
  final int daysLeft;
  final String imagePath;
  final void Function()? onTap;

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
            IntrinsicHeight(
              child: Row(
                children: [
                  // Image
                  Container(
                    width: 100.w,
                    //  height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                                  text: timings[i],
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
                        Text('Dose: $tablets tablet'),
                        Text('Route: $route'),
                        Text('Description: $description'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Done Button Style
            Container(
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
                    Icon(Icons.check_circle_outline_outlined,
                        color: Colors.black87),
                    SizedBox(width: 8),
                    Text(
                      'Check Done',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Progress Bar
            // Row(
            //   children: [
            //     Expanded(
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(16),
            //         child: LinearProgressIndicator(
            //           value: progress,
            //           minHeight: 14,
            //           backgroundColor: Colors.grey.shade200,
            //           color: Colors.blue,
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Text('$daysLeft Days left'),
            //   ],
            // ),

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
