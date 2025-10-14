import 'package:flutter/material.dart';

class LabelCard extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;

  const LabelCard({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xF5F7FAFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF39424E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(width: 6),
                Text(
                  '($subtitle)',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.blueGrey,
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2A3C4A),
            ),
          ),
        ],
      ),
    );
  }
}
