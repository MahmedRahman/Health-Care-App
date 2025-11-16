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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DashboardItem(
                      svgPath: "assets/images/Vitals.png",
                      label: "Vitals",
                      iconColor: Color(0xffECDEDE),
                      onTap: () {
                        Get.toNamed(Routes.MEDICATIONS);
                      },
                    ),
                    SizedBox(width: 8.w),
                    DashboardItem(
                      svgPath: "assets/images/Medications.png",
                      label: "Medications",
                      iconColor: Color(0xffE7EDF3),
                      onTap: () {
                        Get.toNamed(Routes.MEDICATIONS);
                      },
                    ),
                    SizedBox(width: 8.w),
                    DashboardItem(
                      svgPath: "assets/images/Images.png",
                      label: "Images",
                      iconColor: Color(0xffF2E7DC),
                      onTap: () {
                        Get.toNamed(Routes.MEDICAL_IMAGES);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    DashboardItem(
                      svgPath: "assets/images/Labs.png",
                      label: "Labs",
                      iconColor: Color(0xffF1ECF1),
                      onTap: () {
                        Get.toNamed(Routes.LABS);
                      },
                    ),
                    SizedBox(width: 8.w),
                    DashboardItem(
                      svgPath: "assets/images/Reports.png",
                      label: "Reports",
                      iconColor: Color(0xffE8EFEB),
                      onTap: () {
                        Get.toNamed(Routes.REPORTS);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


  // SizedBox(width: 8.w),
                // DashboardItem(
                //   svgPath: "assets/svg/Appointments.svg",
                //   label: "Appointments",
                //   iconColor: Color(0xffC6A7D1),
                //   onTap: () {},
                // ),