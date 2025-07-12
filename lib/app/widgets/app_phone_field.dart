import 'package:flutter/material.dart';

class AppPhoneField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String selectedCode;
  final List<String> countryCodes;
  final ValueChanged<String> onCodeChanged;
  final Color labelColor;

  const AppPhoneField({
    super.key,
    required this.label,
    this.controller,
    this.selectedCode = "966",
    required this.countryCodes,
    required this.onCodeChanged,
    this.labelColor = Colors.grey,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: selectedCode,
                underline: const SizedBox(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                items: countryCodes.map((code) {
                  return DropdownMenuItem<String>(
                    value: code,
                    child: Text(
                      code,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newCode) {
                  if (newCode != null) {
                    onCodeChanged(newCode);
                  }
                },
              ),
              const SizedBox(width: 8),
              Container(
                width: 1,
                height: 30,
                color: Colors.blue.shade900,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Please Add your Mobile Number",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}
