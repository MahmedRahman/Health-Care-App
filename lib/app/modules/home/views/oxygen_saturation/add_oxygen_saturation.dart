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

class AddOxygenSaturationController extends GetxController {
  TextEditingController startDateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController oxygenSaturationController = TextEditingController();
  TextEditingController deliveryMethodController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    timeController.text = TimeOfDay.now().format(Get.context!);
  }

  void addOxygenSaturation() {
    if (formKey.currentState!.validate()) {
      Get.find<VersionService>().addOxygenSaturationData(
        date: startDateController.text,
        time: timeController.text,
        oxygenSaturation: oxygenSaturationController.text,
        oxygenDeliveryMethod: deliveryMethodController.text,
        symptoms: symptomsController.text,
      );
      Get.find<HomeController>().getOxygenSaturation();
      oxygenSaturationController.text = '';
      deliveryMethodController.text = '';
      symptomsController.text = '';
      // TODO: Add oxygen saturation to service
      Get.back();
    }
  }
}

class AddOxygenSaturation extends GetView<AddOxygenSaturationController> {
  final AddOxygenSaturationController controller =
      Get.put(AddOxygenSaturationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Get.height,
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
                      "Oxygen Saturation",
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
                AppTimeField(
                  label: 'Time',
                  showLabel: true,
                  labelColor: AppColorsMedications.black,
                  radius: 8.r,
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
                        label: 'Oxygen Saturation',
                        showLabel: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.oxygenSaturationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter oxygen saturation';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        hintText: 'Enter Oxygen Saturation',
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
                        items: ['L/min'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'L/min',
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
                        label: 'Oxygen Delivery Method',
                        showLabel: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.deliveryMethodController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter oxygen delivery method';
                          }
                          return null;
                        },
                        hintText: 'Enter Oxygen Delivery Method',
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
                        items: ['L/min'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'L/min',
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
                    "Shortness of breath",
                    "Chest pain",
                    "Fatigue",
                    "Dizziness",
                    "Confusion",
                    "Other"
                  ],
                  onChanged: (value) {
                    controller.symptomsController.text = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter symptoms';
                    }
                    return null;
                  },
                  value: 'Shortness of breath',
                ),
                SizedBox(height: 16.h),

                //save
                AppPrimaryButton(
                  text: 'Save',
                  onPressed: () {
                    controller.addOxygenSaturation();
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
