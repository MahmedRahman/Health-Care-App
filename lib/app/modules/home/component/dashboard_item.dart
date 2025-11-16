import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final Color iconColor;
  final VoidCallback? onTap;

  const DashboardItem({
    super.key,
    required this.svgPath,
    required this.label,
    this.iconColor = Colors.pink,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 106.w,
        height: 92.h,
        decoration: BoxDecoration(
          //  color: Colors.white,
          color: iconColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              svgPath,
              //  color: iconColor,
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: Color(0xff0D1B34),
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
