import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
import 'package:health_care_app/app/widgets/app_id_card.dart';
import 'package:health_care_app/app/widgets/app_image_picker_box.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  //String selectedCountry = "UAE";
  RxBool isPersonalInfo = true.obs;
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textLight.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:
            const Text('Profile', style: TextStyle(color: AppColors.primary)),
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
                    child: AppPrimaryButton(
                      onPressed: () {
                        isPersonalInfo.value = true;
                      },
                      text: "Personal Info",
                      borderRadius: 12,
                      backgroundColor: isPersonalInfo.value
                          ? AppColors.primary
                          : Colors.white,
                      textColor:
                          isPersonalInfo.value ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppPrimaryButton(
                      onPressed: () {
                        isPersonalInfo.value = false;
                      },
                      text: "Health Info",
                      borderRadius: 12,
                      backgroundColor: !isPersonalInfo.value
                          ? AppColors.primary
                          : Colors.white,
                      textColor:
                          !isPersonalInfo.value ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 8.h),
            Expanded(
              child: Obx(() {
                return Visibility(
                  visible: isPersonalInfo.value,
                  child: ProfilePersonalInfo(),
                  replacement: ProfileHealthInfo(),
                );
              }),
            ),
            const SizedBox(height: 16),
            AppPrimaryButton(
              onPressed: () {},
              text: "Save",
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}

class ProfileHealthInfo extends StatelessWidget {
  const ProfileHealthInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          //dropdown  Primary Secondary Tertiary
          AppDropdownField(
            label: "Primary",
            value: "Primary",
            items: ["Primary", "Secondary", "Tertiary"],
            onChanged: (newValue) {
              if (newValue != null) {
                //selectedCountry = newValue;
              }
            },
            labelColor: Colors.black,
            radius: 12,
            showLabel: false,
          ),
          SizedBox(height: 8.h),
          //dropdown  Primary Secondary Tertiary
          AppDropdownField(
            label: "Secondary",
            value: "Secondary",
            items: ["Primary", "Secondary", "Tertiary"],
            onChanged: (newValue) {
              if (newValue != null) {
                //selectedCountry = newValue;
              }
            },
            labelColor: Colors.black,
            radius: 12,
            showLabel: false,
          ),
          SizedBox(height: 8.h),
          //dropdown  Primary Secondary Tertiary
          AppDropdownField(
            label: "Tertiary",
            value: "Tertiary",
            items: ["Primary", "Secondary", "Tertiary"],
            onChanged: (newValue) {
              if (newValue != null) {
                //selectedCountry = newValue;
              }
            },
            labelColor: Colors.black,
            radius: 12,
            showLabel: false,
          ),
          SizedBox(height: 8.h),
          //textfiled Next of Kin
          AppTextField(
            label: "Next of Kin",
            hintText: "Enter your next of kin",
            controller: TextEditingController(),
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 12,
          ),
          SizedBox(height: 8.h),
          //Clinic  Name
          AppTextField(
            label: "Clinic Name",
            hintText: "Enter your clinic name",
            controller: TextEditingController(),
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 12,
          ),
          SizedBox(height: 8.h),
          //Drop down Physician/Team Name
          AppDropdownField(
            label: "Physician/Team Name",
            value: "Team Name",
            items: ["Team Name", "Team Name2"],
            onChanged: (newValue) {},
            labelColor: Colors.black,
            radius: 12,
            showLabel: true,
          ),
          //Nurse Name
          SizedBox(height: 8.h),
          AppTextField(
            label: "Nurse Name",
            hintText: "Enter your nurse name",
            controller: TextEditingController(),
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 12,
            showLabel: true,
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class ProfilePersonalInfo extends StatelessWidget {
  const ProfilePersonalInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Center(
            child: AppImagePickerBox(
              size: 120,
              borderRadius: 20,
            ),
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "First Name",
            hintText: "Enter your first name",
            controller: TextEditingController(),
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 18,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "Last Name",
            hintText: "Enter your last name",
            controller: TextEditingController(),
            keyboardType: TextInputType.text,
            labelColor: Colors.black,
            radius: 18,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "Phone Number",
            hintText: "Enter your phone number",
            controller: TextEditingController(),
            keyboardType: TextInputType.phone,
            labelColor: Colors.black,
            radius: 18,
          ),
          SizedBox(height: 16.h),
          AppTextField(
            label: "Email Address",
            hintText: "Enter your email address",
            controller: TextEditingController(),
            keyboardType: TextInputType.emailAddress,
            labelColor: Colors.black,
            radius: 18,
          ),
          SizedBox(height: 16.h),
          //id
          AppTextField(
            label: "ID",
            hintText: "Enter your ID",
            controller: TextEditingController(),
            keyboardType: TextInputType.number,
            labelColor: Colors.black,
            radius: 18,
          ),
          SizedBox(height: 16.h),
          AppIdCard(
            code: "123456789",
            name: "John Doe",
            password: "123456",
            extraText: "Extra Text",
          ),
          SizedBox(height: 16.h),
          Text(
            "Address",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),

          Row(
            children: [
              Expanded(
                child: AppDropdownField(
                  label: "Country",
                  value: "UAE",
                  items: ["UAE", "KSA", "Qatar", "Kuwait"],
                  onChanged: (newValue) {
                    if (newValue != null) {
                      //selectedCountry = newValue;
                    }
                  },
                  labelColor: Colors.black,
                  radius: 12,
                  showLabel: false,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdownField(
                  label: "City",
                  value: "City 1",
                  items: ["City 1", "City 2", "City 3", "City 4"],
                  onChanged: (newValue) {
                    if (newValue != null) {
                      //selectedCountry = newValue;
                    }
                  },
                  labelColor: Colors.black,
                  radius: 12,
                  showLabel: false,
                ),
              ),
            ],
          ),
          AppTextField(
            label: "Address",
            hintText: "Enter your address",
            controller: TextEditingController(),
            keyboardType: TextInputType.emailAddress,
            showLabel: false,
            radius: 12,
          ),
          AppTextField(
            label: "Address",
            hintText: "Enter your address",
            controller: TextEditingController(),
            keyboardType: TextInputType.emailAddress,
            showLabel: false,
            radius: 12,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: AppDateField(
                  label: "Date of Birth",
                  showLabel: true,
                  labelColor: Colors.black,
                  radius: 12,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdownField(
                  label: "Gender",
                  value: "Male",
                  items: ["Male", "Female"],
                  onChanged: (newValue) {
                    if (newValue != null) {
                      //    selectedCountry = newValue;
                    }
                  },
                  labelColor: Colors.black,
                  radius: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Age
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: "Age",
                  hintText: "Age",
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                  suffixText: "Years",
                ),
              ),
              const SizedBox(width: 16),
              //Race
              Expanded(
                child: AppTextField(
                  label: "Race",
                  hintText: "Race",
                  controller: TextEditingController(),
                  keyboardType: TextInputType.emailAddress,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          //Weight and height
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: "Weight",
                  hintText: "Weight",
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                  suffixText: "Kg",
                ),
              ),
              const SizedBox(width: 16),
              //Height
              Expanded(
                child: AppTextField(
                  label: "Height",
                  hintText: "Height",
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                  suffixText: "Cm",
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
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
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
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  radius: 12,
                  showLabel: true,
                  labelColor: Colors.black,
                  suffixText: "kg/m2",
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          //Marital  State and Language drop down
          Row(
            children: [
              Expanded(
                child: AppDropdownField(
                  label: "Marital State",
                  value: "Single",
                  items: ["Single", "Married", "Divorced", "Widowed"],
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
                child: AppDropdownField(
                  label: "Language",
                  value: "English",
                  items: ["English", "Arabic", "French", "Spanish"],
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
            ],
          ),
        ],
      ),
    );
  }
}
