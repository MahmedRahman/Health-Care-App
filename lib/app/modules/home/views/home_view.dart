import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
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
import 'package:health_care_app/app/modules/home/views/weight/add_weight.dart';
import 'package:health_care_app/app/modules/home/views/weight/filter_weight.dart';

import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF033E8A), // لون الهيدر
        statusBarIconBrightness: Brightness.light, // لون الأيقونات أبيض
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Container(
            color: Color(0xFFF9FBFD),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileInfo(),
                  SizedBox(height: 18.h),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vital signs",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
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
                                      VitalSignsBottomSheet(
                                        onFilterPressed: () {
                                          Get.bottomSheet(
                                            const FilterBloodPressureBottomSheet(),
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                        onAddPressed: () {
                                          Get.bottomSheet(
                                            AddBloodPressure(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                        title: "Blood Pressure",
                                        value: "50",
                                        unit: "mm/dl",
                                        keyColor: Color(0xffD04244),
                                        chartData: toDailyData(chartData),
                                        line2ChartData:
                                            toDailyData(line2ChartData),
                                      ),
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
                                      VitalSignsBottomSheet(
                                        onFilterPressed: () {
                                          Get.bottomSheet(
                                            const FilterHeartRateBottomSheet(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                        onAddPressed: () {
                                          //full screen
                                          Get.bottomSheet(
                                            AddHeartRate(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                        title: "Heart Rate",
                                        value: "60",
                                        unit: "bpm",
                                        keyColor: Color(0xff18A86B),
                                        chartData: toDailyData(chartData),
                                      ),
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
                                  imagePath:
                                      "assets/images/oxygen_saturation.png",
                                  value: "95%",
                                  color: Color(0xffDEBC36),
                                  textColor: Colors.black,
                                  onTap: () {
                                    Get.bottomSheet(
                                      VitalSignsBottomSheet(
                                        onFilterPressed: () {
                                          Get.bottomSheet(
                                            const FilterOxygenSaturationBottomSheet(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                        onAddPressed: () {
                                          Get.bottomSheet(
                                            AddOxygenSaturation(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                        title: "Oxygen Saturation",
                                        value: "95%",
                                        unit: "%",
                                        keyColor: Color(0xffDEBC36),
                                        chartData: toDailyData(chartData),
                                      ),
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
                                      VitalSignsBottomSheet(
                                        onFilterPressed: () {
                                          Get.bottomSheet(
                                            const FilterWeightBottomSheet(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                        onAddPressed: () {
                                          Get.bottomSheet(
                                            AddWeight(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                        title: "Weight",
                                        value: "70",
                                        unit: "kg",
                                        keyColor: Color(0xffDEBC36),
                                        chartData: toDailyData(chartData),
                                        line2ChartData:
                                            toDailyData(line2ChartData),
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
                                      VitalSignsBottomSheet(
                                        onFilterPressed: () {
                                          Get.bottomSheet(
                                            const FilterRBSBottomSheet(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                        onAddPressed: () {
                                          Get.bottomSheet(
                                            AddRBS(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                        title: "R.B.S",
                                        value: "112",
                                        unit: "mg/dl",
                                        keyColor: Color(0xffDEBC36),
                                        chartData: toDailyData(chartData),
                                        line2ChartData:
                                            toDailyData(line2ChartData),
                                        line3ChartData:
                                            toDailyData(line3ChartData),
                                      ),
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
                                      VitalSignsBottomSheet(
                                        onFilterPressed: () {
                                          Get.bottomSheet(
                                            const FilterFluidBalanceBottomSheet(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.transparent,
                                          );
                                        },
                                        onAddPressed: () {
                                          Get.bottomSheet(
                                            AddFluidBalance(),
                                            isScrollControlled:
                                                true, // يسمح بالتحكم في الطول
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                        title: "Fluid Balance",
                                        value: "-200",
                                        unit: "ml",
                                        keyColor: Color(0xffDEBC36),
                                        chartData: toDailyData(chartData),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      QuickLinks(),
                      SizedBox(height: 124.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
