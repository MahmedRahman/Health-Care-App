import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/core/service/lookup_service.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_image_picker_box.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';
import 'package:health_care_app/app/widgets/layout/app_bottom_sheet_dropdown.dart';

import '../controllers/medicine_add_controller.dart';

class MedicineAddView extends GetView<MedicineAddController> {
  const MedicineAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsMedications.grey,
      appBar: AppBar(
        title: const Text(
          'Add Medicine',
          style: TextStyle(color: AppColorsMedications.white),
        ),
        centerTitle: false,
        backgroundColor: AppColorsMedications.primary,
        titleTextStyle: TextStyle(
          color: AppColorsMedications.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColorsMedications.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: controller.obx(
        (data) {
          return Form(
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
                        items: Get.find<LookupService>().MedicineListNames,
                        onChanged: (value) {
                          controller.selectedMedicineName.value = value;
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
                        onTap: () {
                          controller.addOtherMedicine();
                        },
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
                              child: SvgPicture.asset(
                                  'assets/svg/MedicineـImage.svg'),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text("Medicine Image"),
                        ],
                      ),
                      SizedBox(height: 8.h),

                      Center(
                        child: AppImagePickerBox(
                          size: 120,
                          borderRadius: 20,
                          controller: controller.medicineImage,
                          onBase64Changed: (value) {
                            controller.medicineImage.text = value;
                          },
                        ),
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
                                controller.selectedDose.value = value;
                                controller.doseTimeList.clear();

                                List<String> newDoseTime = <String>[];
                                for (int i = 0;
                                    i <
                                        int.parse(
                                            controller.selectedDose.value);
                                    i++) {
                                  newDoseTime.add(
                                      '${TimeOfDay.now().format(context)}');
                                }

                                controller.doseTimeList.addAll(newDoseTime);

                                // Ensure we have a valid dose value before parsing
                                // final doseValue = controller.selectedDose.value;
                                // if (doseValue.isNotEmpty) {
                                //   controller.doseTimeList.length =
                                //       int.parse(doseValue);

                                //   for (int i = 0;
                                //       i < controller.doseTimeList.length;
                                //       i++) {
                                //     controller.doseTimeList[i] =
                                //         '${TimeOfDay.now().format(context)}';
                                //   }
                                // }
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
                                controller.selectedForm.value = value;
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
                                controller.selectedRoute.value = value;
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
                                controller.selectedFrequency.value = value;
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

                      Obx(() {
                        // Ensure we have a valid dose value before parsing
                        final doseValue = controller.selectedDose.value;
                        final doseCount =
                            doseValue.isNotEmpty ? int.parse(doseValue) : 1;

                        return DoseTimeFields(
                          doseCount: doseCount, // مثلا 3 جرعات
                          onTimeSelected: (index, time) {
                            controller.doseTimeList[index] =
                                time.format(context).toString();
                          },
                          onDateSelected: (date) {
                            controller.doseDateList = date.toString();
                          },
                          onDaysSelected: (days) {
                            controller.doseDaysList.value = days;
                          },
                          frequency: controller.selectedFrequency.value,
                        );
                      }),

                      SizedBox(height: 12.h),

                      Row(
                        children: [
                          Expanded(
                            child: AppBottomSheetDropdown(
                              label: 'Duration',
                              value: controller.selectedDuration.value,
                              items: controller.durationNames,
                              onChanged: (value) {
                                controller.selectedDuration.value = value;
                                controller.calculateRenewalDate();
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
                                  value: controller
                                      .selectedDurationFrequency.value,
                                  showLabel: false,
                                  items: controller.DurationFrequencyNames,
                                  onChanged: (value) {
                                    controller.selectedDurationFrequency.value =
                                        value;
                                    controller.calculateRenewalDate();
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
                              readOnly: false,
                              initialValue: controller.startDateController.text,
                              controller: controller.startDateController,
                              onDateSelected: (date) {
                                controller.startDateController.text = date;
                                controller.calculateRenewalDate();
                              },
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
                              initialValue:
                                  controller.renewalDateController.text,
                              showLabel: true,
                              labelColor: AppColorsMedications.black,
                              readOnly: true,
                              radius: 8.r,
                              onDateSelected: (date) {},
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      //Description
                      AppTextField(
                        label: 'Description',
                        hintText: 'Enter description',
                        controller: controller.descriptionController,
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
                        controller: controller.specialInstructionController,
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
                          controller.addMedicine();
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
          );
        },
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}


   // SelectableTimingGrid(
                      //   timings: [
                      //     [
                      //       '1:00 AM',
                      //       '2:00 PM',
                      //       '3:00 PM',
                      //       '4:00 PM',
                      //       '4:00 PM',
                      //     ],
                      //     [
                      //       '5:00 PM',
                      //       '6:00 PM',
                      //       '7:00 PM',
                      //       '8:00 PM',
                      //       '4:00 PM',
                      //     ],
                      //     [
                      //       '9:00 PM',
                      //       '10:00 PM',
                      //       '11:00 PM',
                      //       '12:00 PM',
                      //       '4:00 PM',
                      //     ],
                      //   ],
                      //   initialSelectedTimes: {},
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please select at least one time';
                      //     }
                      //     return null;
                      //   },
                      //   onSelectionChanged: (times) {
                      //     print("Selected: $times");
                      //   },
                      // ),
                   