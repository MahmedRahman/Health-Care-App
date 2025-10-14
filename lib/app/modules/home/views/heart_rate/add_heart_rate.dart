import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/widgets/app_button.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';
import 'package:health_care_app/app/widgets/layout/app_bottom_sheet_dropdown.dart';
import 'package:health_care_app/app/widgets/layout/selec_table_timing_grid.dart';

class AddHeartRateController extends GetxController {
  TextEditingController startDateController = TextEditingController();
}

class AddHeartRate extends GetView<AddHeartRateController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: BoxDecoration(
        color: Color(0xffF2F2F2),
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
                    "Heart Rate",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  AppIconButtonSvg(
                    assetPath: "assets/svg/close.svg",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              //Date input

              AppDateField(
                label: 'Date',
                showLabel: true,
                labelColor: AppColorsMedications.black,
                radius: 8.r,
                controller: TextEditingController(),
                onDateSelected: (date) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select start date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              SelectableTimingGrid(
                showIcon: false,
                timings: [
                  [
                    '1:00 AM',
                    '2:00 PM',
                    '3:00 PM',
                    '4:00 PM',
                    '4:00 PM',
                  ],
                ],
                initialSelectedTimes: {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select at least one time';
                  }
                  return null;
                },
                onSelectionChanged: (times) {
                  print("Selected: $times");
                },
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  // Heart Rate
                  Expanded(
                    child: AppTextField(
                      label: 'Heart Rate',
                      showLabel: true,
                      labelColor: AppColorsMedications.black,
                      radius: 8.r,
                      controller: TextEditingController(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter heart rate';
                        }
                        return null;
                      },
                      hintText: 'Enter Heart Rate',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Unit
                  Expanded(
                    child: AppBottomSheetDropdown(
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
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              //Symptoms Dropdown
              AppBottomSheetDropdown(
                label: 'Symptoms',
                showLabel: true,
                labelColor: AppColorsMedications.black,
                radius: 8.r,
                items: ['Symptom 1', 'Symptom 2', 'Symptom 3'],
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter symptoms';
                  }
                  return null;
                },
                value: 'Symptom 1',
              ),
              SizedBox(height: 16.h),

              //save
              AppPrimaryButton(
                text: 'Save',
                onPressed: () {
                  Get.back();
                },
                backgroundColor: AppColorsMedications.primary,
                textColor: AppColorsMedications.white,
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
