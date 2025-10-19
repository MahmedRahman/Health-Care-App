import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/modules/home/component/vital_signs_bottom_sheet.dart';
import 'package:health_care_app/app/modules/home/controllers/home_controller.dart';
import 'package:health_care_app/app/modules/home/views/blood_pressure/add_blood_pressure.dart';
import 'package:health_care_app/app/modules/home/views/blood_pressure/filter_blood_pressure.dart';
import 'package:health_care_app/app/modules/home/views/fluid_balance/add_fluid_balance.dart';
import 'package:health_care_app/app/modules/home/views/heart_rate/add_heart_rate.dart';
import 'package:health_care_app/app/modules/home/views/heart_rate/filter_heart_rate.dart';
import 'package:health_care_app/app/modules/home/views/oxygen_saturation/add_oxygen_saturation.dart';
import 'package:health_care_app/app/modules/home/views/rbs/add_rbs.dart';
import 'package:health_care_app/app/modules/home/views/weight/add_weight.dart';

class VitalSignsBottomSheetKey extends GetView<HomeController> {
  final HomeController controller = Get.put(HomeController());
  final RxInt index;

  VitalSignsBottomSheetKey({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Obx(() {
          return ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              // Close all other panels when one is opened
              if (isExpanded) {
                index.value = panelIndex;
              } else {
                index.value = -1; // Close all panels
              }
            },
            children: <ExpansionPanel>[
              ExpansionPanel(
                // backgroundColor: Colors.red,
                isExpanded: index.value == 0,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w,
                    ),
                    child: Text(
                      'Blood Pressure',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                body: Obx(
                  () {
                    return VitalSignsBottomSheet(
                      title: 'Blood Pressure',
                      value: '${controller.avgSBP}/${controller.avgDBP}',
                      unit: 'mmHg',
                      keyColor: controller.bloodPressureColor.value,
                      chartData: toDailyData(controller.sbpChartSpots),
                      line2ChartData: toDailyData(controller.dbpChartSpots),
                      line3ChartData:
                          toDailyData(controller.meanBloodPressureChartSpots),
                      onFilterPressed: () {
                        // Get.bottomSheet(
                        //   FilterBloodPressureBottomSheet(),
                        //   isScrollControlled: true,
                        //   backgroundColor: Colors.white,
                        // );
                      },
                      onAddPressed: () {
                        Get.bottomSheet(
                          AddBloodPressure(),
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                        );
                      },
                    );
                  },
                ),
              ),
              ExpansionPanel(
                isExpanded: index.value == 1,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w,
                    ),
                    child: Text(
                      'Heart Rate',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                body: Obx(() {
                  return VitalSignsBottomSheet(
                    title: 'Heart Rate',
                    value: controller.avgHeartRate.value,
                    unit: 'bpm',
                    keyColor: const Color(0xff18A86B),
                    chartData: toDailyData(controller.heartRateChartSpots),
                    onFilterPressed: () {
                      // Get.bottomSheet(
                      //   FilterHeartRateBottomSheet(),
                      //   isScrollControlled: true,
                      //   backgroundColor: Colors.white,
                      // );
                    },
                    onAddPressed: () {
                      Get.bottomSheet(
                        AddHeartRate(),
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                      );
                    },
                  );
                }),
              ),
              ExpansionPanel(
                isExpanded: index.value == 2,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w,
                    ),
                    child: Text(
                      'Oxygen Saturation',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                body: Obx(() {
                  return VitalSignsBottomSheet(
                    title: 'Oxygen Saturation',
                    value: controller.avgOxygenSaturation.value,
                    unit: '%',
                    keyColor: const Color(0xff18A86B),
                    chartData:
                        toDailyData(controller.oxygenSaturationChartSpots),
                    onFilterPressed: () {},
                    onAddPressed: () {
                      Get.bottomSheet(
                        AddOxygenSaturation(),
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                      );
                    },
                  );
                }),
              ),
              ExpansionPanel(
                isExpanded: index.value == 3,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w,
                    ),
                    child: Text(
                      'Weight',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                body: Obx(() {
                  return VitalSignsBottomSheet(
                    title: 'Weight',
                    value: controller.avgWeight.value,
                    unit: 'kg',
                    keyColor: const Color(0xff18A86B),
                    chartData: toDailyData(controller.weightChartSpots),
                    onFilterPressed: () {},
                    onAddPressed: () {
                      Get.bottomSheet(
                        AddWeight(),
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                      );
                    },
                  );
                }),
              ),
              ExpansionPanel(
                isExpanded: index.value == 4,
                headerBuilder: (context, isExpanded) {
                  return GestureDetector(
                    onTap: () {
                      if (isExpanded) {
                        index.value = -1; // Close all panels
                      } else {
                        index.value = 4; // Open this panel
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      child: Text(
                        'R.B.S',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                body: Obx(() {
                  return VitalSignsBottomSheet(
                    title: 'R.B.S',
                    value: controller.avgBloodSugar.value,
                    unit: 'mg/dl',
                    keyColor: const Color(0xff18A86B),
                    chartData: toDailyData(controller.bloodSugarChartSpots),
                    onFilterPressed: () {},
                    onAddPressed: () {
                      Get.bottomSheet(
                        AddRBS(),
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                      );
                    },
                  );
                }),
              ),
              ExpansionPanel(
                isExpanded: index.value == 5,
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 8.w,
                    ),
                    child: Text(
                      'Fluid Balance',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                body: Obx(() {
                  return VitalSignsBottomSheet(
                    title: 'Fluid Balance',
                    value: controller.avgFluidBalance.value,
                    unit: 'ml',
                    keyColor: const Color(0xff18A86B),
                    chartData: toDailyData(controller.fluidBalanceChartSpots),
                    onFilterPressed: () {},
                    onAddPressed: () {
                      Get.bottomSheet(
                        AddFluidBalance(),
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                      );
                    },
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}

List<Map<String, dynamic>> toDailyData(List<Map<String, dynamic>> chartSpots) {
  return chartSpots
      .map((spot) => {
            'x': spot['x'],
            'y': spot['y'],
            'date': spot['date'],
          })
      .toList();
}
