import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
   VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final Color borderColor;

   AppPrimaryButton({
    super.key,
    required this.text,
     this.onPressed,
    this.backgroundColor = const Color(0xfff2445CE), // example purple
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    this.borderRadius = 32, // default radius
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
