import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardItemHorizontal extends StatelessWidget {
  final String title;
  final String svgPath;
  final Color iconColor;
  final Function() onTap;
  const DashboardItemHorizontal({
    super.key,
    required this.title,
    required this.svgPath,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.black12),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              color: iconColor,
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
