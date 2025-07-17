import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color? textColor; // اللون الخاص بالنص

  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.red,
    this.textColor, // قابل للاختيار
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color, // لون الزر أو التأثيرات
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color:
              textColor ?? color, // استخدم textColor إذا تم تحديده، وإلا color
        ),
      ),
    );
  }
}
