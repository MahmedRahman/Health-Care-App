import 'package:flutter/material.dart';

class TimingGrid extends StatelessWidget {
  final List<List<String>> timings; // كل صف عبارة عن قائمة أوقات

  const TimingGrid({
    Key? key,
    required this.timings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان
        Row(
          children: const [
            Icon(Icons.alarm, color: Colors.black54),
            SizedBox(width: 8),
            Text(
              'Timing',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // الشبكة
        Column(
          children: timings.map((row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: row.map((time) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF4A90E2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
