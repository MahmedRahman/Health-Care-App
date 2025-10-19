import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/core/service/version_service.dart';
import 'package:health_care_app/app/modules/home/controllers/home_controller.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';
import 'package:health_care_app/app/widgets/layout/app_bottom_sheet_dropdown.dart';
import 'package:intl/intl.dart';

class AddBloodPressureController extends GetxController {
  TextEditingController startDateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    timeController.text = TimeOfDay.now().format(Get.context!);
  }

  void addBloodPressure() {
    if (formKey.currentState!.validate()) {
      Get.find<VersionService>().addBloodPressure(
        startDate: startDateController.text,
        time: timeController.text,
        systolic: double.parse(systolicController.text),
        diastolic: double.parse(diastolicController.text),
        map: double.parse(mapController.text),
        heartRate: double.parse(heartRateController.text),
        symptoms: symptomsController.text,
      );
      Get.find<HomeController>().getBloodPressure();
      Get.back();
    }
  }

  void calculateMap() {
    if (systolicController.text.isNotEmpty &&
        diastolicController.text.isNotEmpty) {
      try {
        double systolic = double.parse(systolicController.text);
        double diastolic = double.parse(diastolicController.text);
        double map = (systolic + diastolic) / 2;
        mapController.text = map.toStringAsFixed(1);
        update();
      } catch (e) {
        // Handle parsing errors silently
      }
    }
  }
}

class AddBloodPressure extends GetView<AddBloodPressureController> {
  final AddBloodPressureController controller =
      Get.put(AddBloodPressureController());

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
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Text(
                      "Blood Pressure",
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
                  readOnly: false,
                  controller: controller.startDateController,
                  onDateSelected: (date) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select start date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                //Time input
                AppTimeField(
                  label: 'Time',
                  showLabel: true,
                  labelColor: AppColorsMedications.black,
                  radius: 8.r,
                  //  controller: TextEditingController(),
                  onTimeSelected: (time) {
                    controller.timeController.text = time.format(context);
                  },
                ),

                SizedBox(height: 16.h),
                Row(
                  children: [
                    // Heart Rate
                    Expanded(
                      child: AppTextField(
                        label: 'Systolic Blood',
                        showLabel: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.systolicController,
                        onChanged: (value) {
                          controller.calculateMap();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Systolic Blood Pressure';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        hintText: 'Enter Systolic Blood Pressure',
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
                        items: ['mmHg'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          controller.calculateMap();
                          return null;
                        },
                        value: 'mmHg',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    // Heart Rate
                    Expanded(
                      child: AppTextField(
                        label: 'Diastolic Blood',
                        showLabel: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.diastolicController,
                        onChanged: (value) {
                          controller.calculateMap();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Diastolic Blood Pressure';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        hintText: 'Enter Diastolic Blood Pressure',
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
                        items: ['mmHg'],
                        onChanged: (value) {
//calculate map
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'mmHg',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                Row(
                  children: [
                    // Heart Rate
                    Expanded(
                      child: AppTextField(
                        label: 'MAP',
                        showLabel: true,
                        readOnly: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.mapController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter MAP';
                          }
                          return null;
                        },
                        hintText: 'Auto-calculated',
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
                        items: ['mmHg'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'mmHg',
                      ),
                    ),
                  ],
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
                        controller: controller.heartRateController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter heart rate';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
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
                        items: ['bpm'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'bpm',
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
                  items: [
                    "Fatigue",
                    "Dizziness",
                    "Shortness of breath",
                    "Swelling (edema)",
                    "Chest pain",
                    "Nausea / Vomiting",
                    "Headache",
                    "Other"
                  ],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter symptoms';
                    }
                    return null;
                  },
                  value: 'Fatigue',
                ),
                SizedBox(height: 16.h),

                //save
                AppPrimaryButton(
                  text: 'Save',
                  onPressed: () {
                    controller.addBloodPressure();
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
      ),
    );
  }
}
