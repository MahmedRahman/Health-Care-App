import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRichTextButton extends StatelessWidget {
  final String normalText;
  final String actionText;
  final Color actionTextColor;
  final VoidCallback onTap;

  const AppRichTextButton({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
    this.actionTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: normalText,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16.sp,
        ),
        children: [
          TextSpan(
            text: ' $actionText',
            style: TextStyle(
              color: actionTextColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
