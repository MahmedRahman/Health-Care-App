import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

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
