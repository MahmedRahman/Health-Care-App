import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/modules/home/component/vital_signs_bottom_sheet.dart';
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

class VitalSignsBottomSheetKeyController extends GetxController {}

class VitalSignsBottomSheetKey
    extends GetView<VitalSignsBottomSheetKeyController> {
  RxInt index;

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
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomExpansionTileWithActions(
              initiallyExpanded: index.value == 0,
              title: 'Blood Pressure',
              onFilterPressed: () {
                Get.bottomSheet(
                  const FilterFluidBalanceBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              onAddPressed: () {
                Get.bottomSheet(
                  AddFluidBalance(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                );
              },
              bodyWidget: VitalSignsBottomSheet(
                title: 'Blood Pressure',
                value: '120/80',
                unit: 'mmHg',
                keyColor: const Color(0xffD04244),
                chartData: toDailyData(chartData),
                onFilterPressed: () {},
                onAddPressed: () {},
              ),
            ),
            CustomExpansionTileWithActions(
              initiallyExpanded: index.value == 1,
              title: 'Heart Rate',
              onFilterPressed: () {
                Get.bottomSheet(
                  const FilterHeartRateBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              onAddPressed: () {
                Get.bottomSheet(
                  AddHeartRate(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                );
              },
              bodyWidget: VitalSignsBottomSheet(
                title: 'Heart Rate',
                value: '60',
                unit: 'bpm',
                keyColor: const Color(0xff18A86B),
                chartData: toDailyData(chartData),
                onFilterPressed: () {},
                onAddPressed: () {},
              ),
            ),
            CustomExpansionTileWithActions(
              initiallyExpanded: index.value == 2,
              title: 'Oxygen Saturation',
              onFilterPressed: () {
                Get.bottomSheet(
                  const FilterOxygenSaturationBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              onAddPressed: () {
                Get.bottomSheet(
                  AddOxygenSaturation(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                );
              },
              bodyWidget: VitalSignsBottomSheet(
                title: 'Oxygen Saturation',
                value: '95',
                unit: '%',
                keyColor: const Color(0xffDEBC36),
                chartData: toDailyData(chartData),
                onFilterPressed: () {},
                onAddPressed: () {},
              ),
            ),
            CustomExpansionTileWithActions(
              initiallyExpanded: index.value == 3,
              title: 'Weight',
              onFilterPressed: () {
                Get.bottomSheet(
                  const FilterWeightBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              onAddPressed: () {
                Get.bottomSheet(
                  AddWeight(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                );
              },
              bodyWidget: VitalSignsBottomSheet(
                title: 'Weight',
                value: '70',
                unit: 'kg',
                keyColor: const Color(0xff18A86B),
                chartData: toDailyData(chartData),
                onFilterPressed: () {},
                onAddPressed: () {},
              ),
            ),
            CustomExpansionTileWithActions(
              initiallyExpanded: index.value == 4,
              title: 'R.B.S',
              onFilterPressed: () {},
              onAddPressed: () {},
              bodyWidget: VitalSignsBottomSheet(
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
            CustomExpansionTileWithActions(
              initiallyExpanded: index.value == 5,
              title: 'Fluid Balance',
              onFilterPressed: () {
                Get.bottomSheet(
                  const FilterFluidBalanceBottomSheet(),
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                );
              },
              onAddPressed: () {
                Get.bottomSheet(
                  AddFluidBalance(),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                );
              },
              bodyWidget: VitalSignsBottomSheet(
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
    );
  }
}

class CustomExpansionTileWithActions extends StatelessWidget {
  final String title;
  final VoidCallback onFilterPressed;
  final VoidCallback onAddPressed;
  final Widget bodyWidget;
  final Color? titleColor;
  bool initiallyExpanded = false;
  // void Function()? onTap;
  CustomExpansionTileWithActions({
    super.key,
    required this.title,
    required this.onFilterPressed,
    required this.onAddPressed,
    required this.bodyWidget,
    required this.initiallyExpanded,
    this.titleColor,
    //  this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded, // opens automatically

      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: titleColor ?? Colors.black,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIconButtonSvg(
            assetPath: 'assets/svg/filter.svg',
            iconSize: 32.w,
            onPressed: onFilterPressed,
          ),
          SizedBox(width: 4.w),
          AppIconButtonSvg(
            assetPath: 'assets/svg/plus.svg',
            iconSize: 32.w,
            onPressed: onAddPressed,
          ),
        ],
      ),
      children: [
        bodyWidget,
      ],
    );
  }
}
