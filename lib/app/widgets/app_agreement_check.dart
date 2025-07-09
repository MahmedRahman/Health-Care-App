import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppAgreementCheck extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTermsTap;

  const AppAgreementCheck({
    super.key,
    required this.value,
    required this.onChanged,
    required this.onTermsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: "Clicking Next means you agree to the ",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              children: [
                TextSpan(
                  text: "Terms of Use",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.grey,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
