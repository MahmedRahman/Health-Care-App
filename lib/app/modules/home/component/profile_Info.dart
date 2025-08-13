import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //  color: AppColors.primary,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.topRight,
          stops: [0.0, .8, 1.0],
          colors: [
            Color(0xFF033E8A), // أبيض خفيف من فوق
            Color(0xFF033E8A).withOpacity(.8),
            Color(0xFF99CCFF), // أزرق فاتح من تحت
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
          bottomRight: Radius.circular(40.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hi, Ahmed",
                  style: TextStyle(
                    fontSize: 29.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                AppIconButtonSvg(
                  assetPath: 'assets/svg/notifications.svg',
                  iconSize: 40.w,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/images/ix_user-profile-filled.png",
                            height: 80.h,
                            width: 80.w,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Male,42 Years",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "ID: 12345678",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Heart Attack",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
          ],
        ),
      ),
    );
  }
}
