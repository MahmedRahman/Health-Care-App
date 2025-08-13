import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/widgets/app_button.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
import 'package:health_care_app/app/widgets/app_image_picker_box.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';
import 'package:health_care_app/app/widgets/layout/app_bottom_sheet_dropdown.dart';
import 'package:health_care_app/app/widgets/layout/selec_table_timing_grid.dart';
import 'package:health_care_app/app/widgets/timing_grid.dart';

import '../controllers/medicine_add_controller.dart';

class MedicineAddView extends GetView<MedicineAddController> {
  const MedicineAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsMedications.grey,
      appBar: AppBar(
        title: const Text('Add Medicine'),
        centerTitle: false,
        backgroundColor: AppColorsMedications.primary,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                children: [
                  SizedBox(height: 16.h),
                  // Medicine Name DropDown
                  AppBottomSheetDropdown(
                    label: 'Medicine Name',
                    value: controller.selectedMedicineName.value,
                    items: controller.medicineNames,
                    onChanged: (value) {
                      controller.selectedMedicineName.value = value!;
                    },
                    radius: 8.r,
                    icon: 'assets/svg/medicine_name.svg',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter medicine name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Add Other',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              SvgPicture.asset('assets/svg/MedicineـImage.svg'),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text("Medicine Image"),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  AppImagePickerBox(
                    onImageSelected: (image) {},
                    validator: (value) {
                      if (value == null) {
                        return 'Please select image';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // row 2 dropdown Dose and Form

                  Row(
                    children: [
                      Expanded(
                        child: AppBottomSheetDropdown(
                          label: 'Dose',
                          value: controller.selectedDose.value,
                          items: controller.doseNames,
                          onChanged: (value) {
                            controller.selectedDose.value = value!;
                          },
                          radius: 8.r,
                          icon: 'assets/svg/Dose.svg',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select dose';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppBottomSheetDropdown(
                          label: 'Form',
                          value: controller.selectedForm.value,
                          items: controller.formNames,
                          onChanged: (value) {
                            controller.selectedForm.value = value!;
                          },
                          radius: 8.r,
                          icon: 'assets/svg/Dose.svg',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select form';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Expanded(
                        child: AppBottomSheetDropdown(
                          label: 'Route',
                          value: controller.selectedRoute.value,
                          items: controller.routeNames,
                          onChanged: (value) {
                            controller.selectedRoute.value = value!;
                          },
                          radius: 8.r,
                          icon: 'assets/svg/Dose.svg',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select route';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppBottomSheetDropdown(
                          label: 'Frequency',
                          value: controller.selectedFrequency.value,
                          items: controller.frequencyNames,
                          onChanged: (value) {
                            controller.selectedFrequency.value = value!;
                          },
                          radius: 8.r,
                          icon: 'assets/svg/Frequency.svg',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select frequency';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  SelectableTimingGrid(
                    timings: [
                      [
                        '1:00 AM',
                        '2:00 PM',
                        '3:00 PM',
                        '4:00 PM',
                        '4:00 PM',
                      ],
                      [
                        '5:00 PM',
                        '6:00 PM',
                        '7:00 PM',
                        '8:00 PM',
                        '4:00 PM',
                      ],
                      [
                        '9:00 PM',
                        '10:00 PM',
                        '11:00 PM',
                        '12:00 PM',
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
                      Expanded(
                        child: AppBottomSheetDropdown(
                          label: 'Duration',
                          value: controller.selectedDuration.value,
                          items: controller.durationNames,
                          onChanged: (value) {
                            controller.selectedDuration.value = value!;
                          },
                          radius: 8.r,
                          icon: 'assets/svg/Dose.svg',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select duration';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),
                            AppBottomSheetDropdown(
                              label: 'Duration',
                              value: controller.selectedDuration.value,
                              showLabel: false,
                              items: controller.durationNames,
                              onChanged: (value) {
                                controller.selectedDuration.value = value!;
                              },
                              radius: 8.r,
                              icon: 'assets/svg/Dose.svg',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select duration';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: AppDateField(
                          label: 'Start Date',
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
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppDateField(
                          label: 'Renewal Date',
                          controller: controller.renewalDateController,
                          showLabel: true,
                          labelColor: AppColorsMedications.black,
                          radius: 8.r,
                          onDateSelected: (date) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select renewal date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  //Description
                  AppTextField(
                    label: 'Description',
                    hintText: 'Enter description',
                    controller: TextEditingController(),
                    keyboardType: TextInputType.text,
                    radius: 8.r,
                    icon: 'assets/images/Description.png',
                    showLabel: true,
                    labelColor: AppColorsMedications.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  //Special instruction
                  AppTextField(
                    label: 'Special instruction',
                    hintText: 'Enter special instruction',
                    controller: TextEditingController(),
                    keyboardType: TextInputType.text,
                    radius: 8.r,
                    icon: 'assets/images/Special_instruction.png',
                    showLabel: true,
                    labelColor: AppColorsMedications.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter special instruction';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  //Doctor Name Input Text
                  AppTextField(
                    label: 'Doctor Name',
                    hintText: 'Enter doctor name',
                    controller: controller.doctorNameController,
                    keyboardType: TextInputType.text,
                    radius: 8.r,
                    icon: 'assets/images/doctor_name.png',
                    showLabel: true,
                    labelColor: AppColorsMedications.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter doctor name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  AppPrimaryButton(
                    text: 'Add Medicine',
                    onPressed: () {
                      controller.formKey.currentState!.validate();
                    },
                    backgroundColor: AppColorsMedications.primary,
                    textColor: AppColorsMedications.white,
                    borderRadius: 24,
                  ),
                  SizedBox(height: 16.h),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
