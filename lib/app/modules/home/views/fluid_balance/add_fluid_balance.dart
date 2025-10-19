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

class AddFluidBalanceController extends GetxController {
  TextEditingController startDateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController fluidIntakeController = TextEditingController();
  TextEditingController fluidOutputController = TextEditingController();
  TextEditingController netBalanceController = TextEditingController();
  TextEditingController symptomsController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    startDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    timeController.text = TimeOfDay.now().format(Get.context!);
  }

  void calculateNetBalance() {
    if (fluidIntakeController.text.isNotEmpty &&
        fluidOutputController.text.isNotEmpty) {
      try {
        double intake = double.parse(fluidIntakeController.text);
        double output = double.parse(fluidOutputController.text);
        double netBalance = intake - output;
        netBalanceController.text = netBalance.toStringAsFixed(1);
        update();
      } catch (e) {
        // Handle parsing errors silently
      }
    }
  }

  void addFluidBalance() {
    if (formKey.currentState!.validate()) {
      Get.find<VersionService>().addFluidBalanceData(
        fluidIn: double.parse(fluidIntakeController.text),
        fluidOut: double.parse(fluidOutputController.text),
        netBalance: double.parse(netBalanceController.text),
        symptoms: symptomsController.text,
        date: startDateController.text,
        time: timeController.text,
      );
      Get.find<HomeController>().getFluidBalance();
      // TODO: Add fluid balance to service
      Get.back();
    }
  }
}

class AddFluidBalance extends GetView<AddFluidBalanceController> {
  final AddFluidBalanceController controller =
      Get.put(AddFluidBalanceController());

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
                      "Fluid Balance",
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
                        label: 'Fluid Intake',
                        showLabel: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.fluidIntakeController,
                        onChanged: (value) {
                          controller.calculateNetBalance();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter fluid intake';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        hintText: 'Enter Fluid Intake',
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
                        items: ['ml'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'ml',
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
                        label: 'Fluid Output',
                        showLabel: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.fluidOutputController,
                        onChanged: (value) {
                          controller.calculateNetBalance();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter fluid output';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        hintText: 'Enter Fluid Output',
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
                        items: ['ml'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'ml',
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
                        label: 'Net Balance',
                        showLabel: true,
                        readOnly: true,
                        labelColor: AppColorsMedications.black,
                        radius: 8.r,
                        controller: controller.netBalanceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter net balance';
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
                        items: ['ml'],
                        onChanged: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter unit';
                          }
                          return null;
                        },
                        value: 'ml',
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
                    "Swelling (edema)",
                    "Dehydration",
                    "Fluid retention",
                    "Dry mouth",
                    "Increased thirst",
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
                  value: 'Swelling (edema)',
                ),
                SizedBox(height: 16.h),

                //save
                AppPrimaryButton(
                  text: 'Save',
                  onPressed: () {
                    controller.addFluidBalance();
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
