import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppRichTextButton extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;

  const AppRichTextButton({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: normalText,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        children: [
          TextSpan(
            text: ' $actionText',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
