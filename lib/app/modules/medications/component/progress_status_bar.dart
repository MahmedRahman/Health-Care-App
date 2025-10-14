import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressStatusBar extends StatelessWidget {
  final double percentage; // قيمة بين 0 و 1
  final int daysLeft;

  const ProgressStatusBar({
    Key? key,
    required this.percentage,
    required this.daysLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h, // عدلت الحجم ليتماشى مع الصورة
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.shade200,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // شريط التقدم
          FractionallySizedBox(
            widthFactor: percentage.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF63A6F7),
                    Color(0xFF63A6F7)
                  ], // تدرج برتقالي
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
          // النص
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${(percentage * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$daysLeft Days left',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
