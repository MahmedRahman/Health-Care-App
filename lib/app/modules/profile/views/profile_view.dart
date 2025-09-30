import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/core/service/lookup_service.dart';
import 'package:health_care_app/app/modules/PatientInfo/views/patient_info_view.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
import 'package:health_care_app/app/widgets/app_id_card.dart';
import 'package:health_care_app/app/widgets/app_image_picker_box.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  RxBool isPersonalInfo = true.obs;
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.textLight.withOpacity(0.1),
        body: controller.obx(
          (snapshot) {
            return Scaffold(
              backgroundColor: AppColors.textLight.withOpacity(0.1),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: const Text(
                    'Profile',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                centerTitle: false,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: 8.h),
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                isPersonalInfo.value = true;
                              },
                              child: Container(
                                width: 150.w,
                                height: 40.h,
                                decoration: isPersonalInfo.value
                                    ? BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xff2445CE),
                                            width: 2.0, // تقدر تغيّر السمك
                                          ),
                                        ),
                                      )
                                    : BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0, // تقدر تغيّر السمك
                                          ),
                                        ),
                                      ),
                                child: Center(
                                  child: Text(
                                    "Personal Info",
                                    style: TextStyle(
                                      color: isPersonalInfo.value == true
                                          ? Color(0xff2445CE)
                                          : Color(0xff808080),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                isPersonalInfo.value = false;
                              },
                              child: Container(
                                width: 150.w,
                                height: 40.h,
                                decoration: isPersonalInfo.value
                                    ? BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0, // تقدر تغيّر السمك
                                          ),
                                        ),
                                      )
                                    : BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xff2445CE),
                                            width: 2.0, // تقدر تغيّر السمك
                                          ),
                                        ),
                                      ),
                                child: Center(
                                  child: Text(
                                    "Health Info",
                                    style: TextStyle(
                                      color: isPersonalInfo.value == false
                                          ? Color(0xff2445CE)
                                          : Color(0xff808080),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 8.h),
                    Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Expanded(
                        child: Obx(() {
                          return Visibility(
                            visible: isPersonalInfo.value,
                            child: PresonalInfo(),
                            replacement: healthInfo(),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppPrimaryButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.updateProfile();
                        }
                      },
                      text: "Save",
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
          onLoading: Center(
            child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }

  Widget healthInfo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          const Text(
            "Diagnosis",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),

          Obx(() {
            return AppBottomSheetMultiSelectField(
              label: "Primary",
              items: Get.find<LookupService>().DiagnosePrimaryListNames.value,
              value: controller.selectDiagnosePrimaryListNames,
              onChanged: (newValue) {
                if (newValue != null) {
                  controller.selectDiagnosePrimaryListNames = newValue;
                }
              },
              radius: 12,
            );
          }),
          SizedBox(height: 8.h),
          //dropdown  Primary Secondary Tertiary
          Obx(() {
            return AppBottomSheetMultiSelectField(
              label: "Secondary",
              items: Get.find<LookupService>().DiagnoseSecondaryListNames.value,
              value: controller.SelectDiagnoseSecondaryListNames,
              onChanged: (newValue) {
                if (newValue != null) {
                  controller.SelectDiagnoseSecondaryListNames = newValue;
                }
              },
              radius: 12,
            );
          }),
          SizedBox(height: 8.h),
          //dropdown  Primary Secondary Tertiary
          StreamBuilder<Object>(
              stream: null,
              builder: (context, snapshot) {
                return AppBottomSheetMultiSelectField(
                  label: "Tertiary",
                  items:
                      Get.find<LookupService>().DiagnoseTertiaryListNames.value,
                  value: controller.SelectDiagnoseTertiaryListNames,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      controller.SelectDiagnoseTertiaryListNames = newValue;
                    }
                  },
                  radius: 12,
                );
              }),
          SizedBox(height: 8.h),
          //textfiled Next of Kin
          AppTextField(
            label: "Next of Kin",
            hintText: "Enter your next of kin",
            controller: controller.nextofKin,
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 12,
          ),
          SizedBox(height: 8.h),
          //Clinic  Name
          AppTextField(
            label: "Clinic Name",
            hintText: "Enter your clinic name",
            controller: controller.clinicName,
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 12,
          ),
          SizedBox(height: 8.h),
          //Drop down Physician/Team Name
          Obx(
            () {
              return AppBottomSheetSelectField(
                label: "Physician/Team Name",
                items: Get.find<LookupService>().PresonalTeamListNames.value,
                value: controller.physicianTeam.text,
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.physicianTeam.text = newValue;
                  }
                },
                radius: 12,
              );
            },
          ),
          //Nurse Name
          SizedBox(height: 8.h),

          Obx(
            () {
              return AppBottomSheetSelectField(
                label: "Nurse Name",
                items: Get.find<LookupService>().NurseListNames.value,
                value: controller.nurseNames.text,
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.nurseNames.text = newValue;
                  }
                },
                radius: 12,
              );
            },
          ),

          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget PresonalInfo() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Center(
            child: AppImagePickerBox(
              size: 120,
              borderRadius: 20,
              controller: controller.profImg,
              onBase64Changed: (value) {
                controller.profImg.text = value;
              },
            ),
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "First Name",
            hintText: "Enter your first name",
            controller: controller.firstName,
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 18,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              //arabic letters and english and spaces only
              if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value)) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "Last Name",
            hintText: "Enter your last name",
            controller: controller.lastName,
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 18,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              //arabic letters and english and spaces only
              if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value)) {
                return 'Please enter a valid name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "Phone Number",
            hintText: "Enter your phone number",
            controller: controller.phone,
            readOnly: true,
            keyboardType: TextInputType.phone,
            labelColor: Colors.black,
            radius: 18,
            validator: (value) {
              return null;
            },
          ),

          SizedBox(height: 16.h),

          AppTextField(
            label: "Hospital ID",
            hintText: "Enter your ID",
            controller: controller.hospitalId,
            keyboardType: TextInputType.number,
            labelColor: Colors.black,
            readOnly: true,
            radius: 18,
          ),

          SizedBox(height: 16.h),

          AppTextField(
            label: "Email Address",
            hintText: "Enter your email address",
            readOnly: true,
            controller: controller.email,
            keyboardType: TextInputType.emailAddress,
            labelColor: Colors.black,
            radius: 18,
          ),
          SizedBox(height: 16.h),
          //id

          AppTextField(
            label: "ID",
            hintText: "Enter your ID",
            controller: controller.nationalId,
            keyboardType: TextInputType.number,
            labelColor: Colors.black,
            radius: 18,
          ),
          SizedBox(height: 16.h),
          AppImagePickerBox(
            controller: controller.idCard,
          ),

          SizedBox(height: 16.h),

          AppBottomSheetSelectField(
            label: "Country",
            value: "UAE",
            items: controller.countries,
            controller: controller.country,
            onChanged: (newValue) {
              if (newValue != null) {
                controller.country.text = newValue;
              }
            },
            labelColor: Colors.black,
            radius: 12,
            showLabel: true,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "City",
            hintText: "Enter your city",
            controller: controller.city,
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 18,
            showLabel: true,
          ),

          SizedBox(height: 16.h),
          AppTextField(
            label: "Address",
            hintText: "Enter your address",
            controller: controller.address1,
            keyboardType: TextInputType.text,
            showLabel: true,
            labelColor: Colors.black,
            radius: 12,
          ),

          SizedBox(height: 16.h),
          AppBottomSheetSelectField(
            controller: controller.gender,
            label: "Gender",
            value: "Male",
            items: ["Male", "Female"],
            onChanged: (newValue) {
              if (newValue != null) {
                controller.gender.text = newValue;
              }
            },
            labelColor: Colors.black,
            radius: 12,
          ),

          const SizedBox(height: 16),

          AppDateField(
            label: "Date of Birth",
            controller: controller.dob,
            radius: 12,
            showLabel: true,
            labelColor: Colors.black,
            onDateSelected: (input) {
              //calculate age
              final date = DateFormat("dd/MM/yyyy").parse(input);

              controller.age.text =
                  (DateTime.now().year - date.year).toString();
              print(controller.age.text);
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: "Age",
            hintText: "Age",
            controller: controller.age,
            keyboardType: TextInputType.number,
            radius: 12,
            showLabel: true,
            labelColor: Colors.black,
            suffixText: "Years",
            readOnly: true,
          ),
          SizedBox(height: 16.h),

          //Weight and height
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: "Weight",
                  hintText: "Weight",
                  controller: controller.weight,
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                  suffixText: "Kg",
                  validator: (p0) {
                    if (double.tryParse(p0!) == null ||
                        double.parse(p0) < 0 ||
                        double.parse(p0) > 200) {
                      return 'Please enter a valid weight between 0 and 200';
                    }

                    controller.calculateBMIAndBSA();

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              //Height
              Expanded(
                child: AppTextField(
                  label: "Height",
                  hintText: "Height",
                  controller: controller.height,
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                  suffixText: "Cm",
                  validator: (p0) {
                    if (double.tryParse(p0!) == null ||
                        double.parse(p0) < 0 ||
                        double.parse(p0) > 300) {
                      return 'Please enter a valid height between 0 and 300';
                    }

                    controller.calculateBMIAndBSA();

                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          //BSA and BMI
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: "BSA",
                  hintText: "BSA",
                  controller: controller.bsa,
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  readOnly: true,
                  labelColor: Colors.black,
                  suffixText: "m2",
                ),
              ),
              const SizedBox(width: 16),
              //BMI
              Expanded(
                child: AppTextField(
                  label: "BMI",
                  hintText: "BMI",
                  controller: controller.bmi,
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                  suffixText: "kg/m2",
                  readOnly: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          AppBottomSheetSelectField(
            label: "Race",
            hintText: "Race",
            controller: controller.race,
            radius: 12,
            showLabel: true,
            labelColor: Colors.black,
            items: [
              "White / Caucasian",
              "Black / African / African American",
              "Asian",
              "Hispanic / Latino",
              "Middle Eastern / North African (MENA)",
              "Native American / Alaska Native",
              "Native Hawaiian / Pacific Islander",
              "Mixed / Multiracial",
              "Other",
              "Prefer not to say",
            ],
          ),
          const SizedBox(height: 16),
          //Marital  State and Language drop down
          Row(
            children: [
              Expanded(
                child: AppBottomSheetSelectField(
                  label: "Marital State",
                  value: "Single",
                  items: ["Single", "Married", "Divorced", "Widowed"],
                  controller: controller.marital,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      // selectedCountry = newValue;
                    }
                  },
                  labelColor: Colors.black,
                  radius: 12,
                  showLabel: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppBottomSheetSelectField(
                  label: "Language",
                  value: "English",
                  items: ["English", "Arabic", "Chinese", "Spanish"],
                  controller: controller.language,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      controller.language.text = newValue;
                    }
                  },
                  labelColor: Colors.black,
                  radius: 12,
                  showLabel: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
