import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/modules/home/component/vital_signs_bottom_sheet.dart';
import 'package:health_care_app/app/modules/home/controllers/home_controller.dart';
import 'package:health_care_app/app/modules/home/views/blood_pressure/add_blood_pressure.dart';
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
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';

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
                isExpanded: index.value == 0,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      'Blood Pressure',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/filter.svg',
                          iconSize: 32.w,
                          onPressed: () {},
                        ),
                        SizedBox(width: 4.w),
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/plus.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              AddBloodPressure(),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ],
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
                      onFilterPressed: () {},
                      onAddPressed: () {},
                    );
                  },
                ),
              ),
              ExpansionPanel(
                isExpanded: index.value == 1,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      'Heart Rate',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/filter.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              const FilterHeartRateBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(width: 4.w),
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/plus.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              AddHeartRate(),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ],
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
                    onFilterPressed: () {},
                    onAddPressed: () {},
                  );
                }),
              ),
              ExpansionPanel(
                isExpanded: index.value == 2,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      'Oxygen Saturation',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/filter.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              const FilterOxygenSaturationBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(width: 4.w),
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/plus.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              AddOxygenSaturation(),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                body: VitalSignsBottomSheet(
                  title: 'Oxygen Saturation',
                  value: '95',
                  unit: '%',
                  keyColor: const Color(0xffDEBC36),
                  chartData: toDailyData(chartData),
                  onFilterPressed: () {},
                  onAddPressed: () {},
                ),
              ),
              ExpansionPanel(
                isExpanded: index.value == 3,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      'Weight',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/filter.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              const FilterWeightBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(width: 4.w),
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/plus.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              AddWeight(),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                body: VitalSignsBottomSheet(
                  title: 'Weight',
                  value: '70',
                  unit: 'kg',
                  keyColor: const Color(0xff18A86B),
                  chartData: toDailyData(chartData),
                  onFilterPressed: () {},
                  onAddPressed: () {},
                ),
              ),
              ExpansionPanel(
                isExpanded: index.value == 4,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      'R.B.S',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/filter.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              const FilterRBSBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(width: 4.w),
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/plus.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              AddRBS(),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                body: VitalSignsBottomSheet(
                  title: 'R.B.S',
                  value: '112',
                  unit: 'mg/dl',
                  keyColor: const Color(0xff18A86B),
                  chartData: toDailyData(chartData),
                  onFilterPressed: () {
                    Get.bottomSheet(
                      const FilterRBSBottomSheet(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  onAddPressed: () {
                    Get.bottomSheet(
                      AddRBS(),
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                    );
                  },
                ),
              ),
              ExpansionPanel(
                isExpanded: index.value == 5,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      'Fluid Balance',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/filter.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              const FilterFluidBalanceBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                        ),
                        SizedBox(width: 4.w),
                        AppIconButtonSvg(
                          assetPath: 'assets/svg/plus.svg',
                          iconSize: 32.w,
                          onPressed: () {
                            Get.bottomSheet(
                              AddFluidBalance(),
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                body: VitalSignsBottomSheet(
                  title: 'Fluid Balance',
                  value: '1200',
                  unit: 'ml',
                  keyColor: const Color(0xffD04244),
                  chartData: toDailyData(chartData),
                  onFilterPressed: () {},
                  onAddPressed: () {},
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
