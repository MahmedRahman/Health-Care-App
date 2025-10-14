import 'package:flutter/material.dart';

class AppTextArea extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final int maxLines;
  final Color labelColor;

  const AppTextArea({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.maxLines = 5, // افتراضي 5 أسطر
    this.labelColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
