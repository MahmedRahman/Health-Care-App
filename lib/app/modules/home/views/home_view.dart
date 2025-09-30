import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/modules/home/component/dashboard_item_horizontal.dart';
import 'package:health_care_app/app/modules/home/component/profile_Info.dart';
import 'package:health_care_app/app/modules/home/component/quick_links.dart';
import 'package:health_care_app/app/modules/home/component/vital_signs_bottom_sheet.dart';
import 'package:health_care_app/app/modules/home/component/vital_signs_card.dart';
import 'package:health_care_app/app/modules/home/views/blood_pressure/add_blood_pressure.dart';
import 'package:health_care_app/app/modules/home/views/blood_pressure/filter_blood_pressure.dart';
import 'package:health_care_app/app/modules/home/views/fluid_balance/add_fluid_balance.dart';
import 'package:health_care_app/app/modules/home/views/fluid_balance/filter_fluid_balance.dart';
import 'package:health_care_app/app/modules/home/views/heart_rate/add_heart_rate.dart';
import 'package:health_care_app/app/modules/home/views/heart_rate/filter_heart_rate.dart';
import 'package:health_care_app/app/modules/home/views/oxygen_saturation/add_oxygen_saturation.dart';
import 'package:health_care_app/app/modules/home/views/oxygen_saturation/filter_oxygen_saturation.dart';
import 'package:health_care_app/app/modules/home/views/rbs/add_rbs.dart';
import 'package:health_care_app/app/modules/home/views/rbs/filter_rbs.dart';
import 'package:health_care_app/app/modules/home/views/update_background_screen.dart';
import 'package:health_care_app/app/modules/home/views/weight/add_weight.dart';
import 'package:health_care_app/app/modules/home/views/weight/filter_weight.dart';
import 'package:health_care_app/app/modules/home/views/weight/vital_signs_bottom_sheet_key.dart';

import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final double top =
        MediaQuery.of(context).padding.top; // ارتفاع الاستاتس بار

    final diagnoses =
        Get.find<AuthService>().currentUser.value?['diagnosesPrimary'];

// نتأكد إن القيمة موجودة وقائمة مش فاضية
    final healthStatus =
        (diagnoses != null && diagnoses is List && diagnoses.isNotEmpty)
            ? diagnoses.first['name'].toString()
            : "Health";

    return Container(
      color: Color(0xffF2F2F2),
      height: Get.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: top,
              color: AppColors.primary, // استخدم لونك الأزرق
            ),

            Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                ProfileInfo(
                  userName: Get.find<AuthService>()
                          .currentUser
                          .value?['firstName']
                          .toString() ??
                      "User",
                  userAge: Get.find<AuthService>().currentUser.value?['age'] ??
                      "Age",
                  userGender:
                      Get.find<AuthService>().currentUser.value?['gender'] ??
                          "Gender",
                  userId: Get.find<AuthService>()
                          .currentUser
                          .value?['hospitalId']
                          .toString() ??
                      "ID",
                  base64String: Get.find<AuthService>()
                          .currentUser
                          .value?['profImg']
                          .toString() ??
                      "ID",
                  userHealthStatus: healthStatus,
                  onTap: () {
                    Get.bottomSheet(
                      UpdateBackgroundScreen(),
                      isScrollControlled: false,
                      backgroundColor: Colors.transparent,
                    );
                  },
                ),
                VitalSigns(),
              ],
            ),
            //SizedBox(height: 12.h),

            SizedBox(height: 12.h),
            QuickLinks(),
            SizedBox(height: 12.h),

            DashboardItemHorizontal(
              title: "Medications",
              svgPath: "assets/svg/Medications.svg",
              iconColor: Colors.blue,
              onTap: () {
                Get.toNamed(Routes.MEDICATIONS);
              },
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

class VitalSigns extends StatelessWidget {
  const VitalSigns({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 155),
      child: Container(
        // height: 290,
        width: Get.width - 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Row(
                children: [
                  VitalSignsCard(
                    title: "Blood Pressure",
                    imagePath: "assets/images/blood_pressure.png",
                    value: "120/80",
                    color: Color(0xffD04244),
                    textColor: Colors.white,
                    onTap: () {
                      Get.bottomSheet(
                        VitalSignsBottomSheetKey(
                          index: 0.obs,
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                  SizedBox(width: 8.w),
                  VitalSignsCard(
                    title: "Heart Rate",
                    imagePath: "assets/images/heart_rate.png",
                    value: "60 bpm",
                    onTap: () {
                      Get.bottomSheet(
                        VitalSignsBottomSheetKey(
                          index: 1.obs,
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  VitalSignsCard(
                    title: "Oxygen Saturation",
                    imagePath: "assets/images/oxygen_saturation.png",
                    value: "95%",
                    color: Color(0xffDFD925),
                    textColor: Colors.black,
                    onTap: () {
                      Get.bottomSheet(
                        VitalSignsBottomSheetKey(
                          index: 2.obs,
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                  SizedBox(width: 8.w),
                  VitalSignsCard(
                    title: "Weight",
                    imagePath: "assets/images/weight.png",
                    value: "70 kg",
                    onTap: () {
                      Get.bottomSheet(
                        VitalSignsBottomSheetKey(
                          index: 3.obs,
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  VitalSignsCard(
                    title: "R.B.S",
                    imagePath: "assets/images/rbs.png",
                    value: "112 mg/dl",
                    onTap: () {
                      Get.bottomSheet(
                        VitalSignsBottomSheetKey(
                          index: 4.obs,
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                  SizedBox(width: 8.w),
                  VitalSignsCard(
                    title: "Fluid Balance",
                    imagePath: "assets/images/fluid_balance.png",
                    value: "-200 ml",
                    onTap: () {
                      Get.bottomSheet(
                        VitalSignsBottomSheetKey(
                          index: 5.obs,
                        ),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
