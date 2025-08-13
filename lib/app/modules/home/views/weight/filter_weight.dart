import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/home/component/multi_checkbox_custom.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/layout/app_bottom_sheet_dropdown.dart';

class FilterWeightBottomSheet extends GetView {
  const FilterWeightBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Row(
                children: [
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  AppIconButtonSvg(
                    assetPath: 'assets/svg/close.svg',
                    iconSize: 21.w,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  //  SizedBox(width: 4.w),
                ],
              ),
              SizedBox(height: 8.h),
              Divider(),

              //Dropdown
              AppBottomSheetDropdown(
                label: 'Time',
                value: "Daily",
                items: ["Daily", "Date", "Both"],
                onChanged: (value) {},
                radius: 8.r,
                //   icon: 'assets/svg/medicine_name.svg',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              AppBottomSheetDropdown(
                label: 'Body Measurement',
                showLabel: true,
                labelColor: AppColorsMedications.black,
                radius: 8.r,
                items: [
                  'Body Measurement 1',
                  'Body Measurement 2',
                  'Body Measurement 3'
                ],
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter unit';
                  }
                  return null;
                },
                value: 'Unit 1',
              ),
              SizedBox(height: 16.h),
              AppBottomSheetDropdown(
                label: 'Unit',
                showLabel: true,
                labelColor: AppColorsMedications.black,
                radius: 8.r,
                items: ['Unit 1', 'Unit 2', 'Unit 3'],
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter unit';
                  }
                  return null;
                },
                value: 'Unit 1',
              ),
              SizedBox(height: 16.h),
              MultiCheckboxCustom(
                value: const [
                  {"key": "high", "label": "Less than 50kg", "value": true},
                  {"key": "normal", "label": "50kg - 60kg", "value": true},
                  {"key": "low", "label": "> 60kg", "value": false},
                  {"key": "low", "label": "More than 100kg", "value": false},
                ],
                title: "Weight Range",
                onChanged: (value) {},
              ),

              SizedBox(height: 16.h),

              AppPrimaryButton(
                onPressed: () {
                  Get.back();
                },
                text: 'Filter',
                backgroundColor: AppColorsMedications.primary,
                textColor: AppColorsMedications.white,
                borderColor: Colors.black,
                borderRadius: 24,
              ),
              SizedBox(height: 8.h),
              AppPrimaryButton(
                onPressed: () {
                  Get.back();
                },
                text: 'Reset',
                backgroundColor: Colors.transparent,
                textColor: Colors.black,
                borderColor: Colors.black,
                borderRadius: 24,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
