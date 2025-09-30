import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/modules/home/component/dashboard_item.dart';
import 'package:health_care_app/app/modules/home/component/dashboard_item_horizontal.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class QuickLinks extends StatelessWidget {
  const QuickLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Links",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardItem(
                  svgPath: "assets/svg/Vitals.svg",
                  label: "Vitals",
                  iconColor: Color(0xffDD4369),
                  onTap: () {
                    Get.toNamed(Routes.MEDICATIONS);
                  },
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Medications.svg",
                  label: "Medications",
                  iconColor: Color(0xff2445CE),
                  onTap: () {
                    Get.toNamed(Routes.MEDICATIONS);
                  },
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Images.svg",
                  label: "Images",
                  iconColor: Color(0xffFE6F2B),
                  onTap: () {
                    Get.toNamed(Routes.MEDICAL_IMAGES);
                  },
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Appointments.svg",
                  label: "Appointments",
                  iconColor: Color(0xffC6A7D1),
                  onTap: () {},
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Labs.svg",
                  label: "Labs",
                  iconColor: Color(0xffDC61E0),
                  onTap: () {
                    Get.toNamed(Routes.LABS);
                  },
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Reports.svg",
                  label: "Reports",
                  iconColor: Color(0xff25C87F),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
