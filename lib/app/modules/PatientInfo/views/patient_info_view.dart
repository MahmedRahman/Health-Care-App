import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
import 'package:health_care_app/app/widgets/app_icon_button.dart';
import 'package:health_care_app/app/widgets/app_id_card.dart';
import 'package:health_care_app/app/widgets/app_image_picker_box.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

import '../controllers/patient_info_controller.dart';

class PatientInfoView extends GetView<PatientInfoController> {
  PatientInfoView({Key? key}) : super(key: key);
  RxInt currentStep = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Patient Info',
          style: TextStyle(
            color: AppColors.primary,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: AppColors.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),
              CustomStepper(
                currentStep: currentStep.value,
                steps: ['Personal', 'Diagnosis', 'Finish'],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: (currentStep.value == 1)
                    ? const ProfilePersonalInfo()
                    : (currentStep.value == 2)
                        ? const ProfileHealthInfo()
                        : const finsh(),
              ),
              const SizedBox(height: 24),
              AppPrimaryButton(
                onPressed: () {
                  if (currentStep.value == 3) {
                    Get.toNamed(Routes.HOME);
                  }
                  if (currentStep.value < 3) {
                    currentStep.value++;
                  }
                },
                text: (currentStep.value == 3) ? "Home" : "Next",
              ),
              const SizedBox(height: 35),
            ],
          );
        }),
      ),
    );
  }
}

class finsh extends StatelessWidget {
  const finsh({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        SvgPicture.asset("assets/svg/Checkmark.svg"),
        Center(
          child: Text(
            ' Your Info Added \nsuccessfully  ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
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
              onImageSelected: (image) {},
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
                  onDateSelected: (date) {},
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

class CustomStepper extends StatelessWidget {
  final int currentStep; // الخطوة الحالية (تبدأ من 1)
  final List<String> steps;

  // الألوان
  final Color activeColor;
  final Color inactiveColor;
  final Color checkColor;

  const CustomStepper({
    super.key,
    required this.currentStep,
    required this.steps,
    this.activeColor = const Color(0xFFF47C50), // اللون البرتقالي
    this.inactiveColor = const Color(0xFFB0BEC5), // الرمادي الفاتح
    this.checkColor = const Color(0xFF06283D), // الأزرق الغامق
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: List.generate(steps.length, (index) {
          final stepNumber = index + 1;
          final isActive = stepNumber == currentStep;
          final isCompleted = stepNumber < currentStep;

          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الدائرة
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? checkColor
                        : isActive
                            ? Colors.transparent
                            : inactiveColor,
                    border: Border.all(
                      color: isActive ? activeColor : inactiveColor,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(Icons.check, color: Colors.white, size: 18)
                        : Text(
                            '$stepNumber',
                            style: TextStyle(
                              color: isActive ? activeColor : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                // النص
                SizedBox(width: 4),
                Text(
                  steps[index],
                  style: TextStyle(
                    color: isActive || isCompleted ? checkColor : inactiveColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // الخط الفاصل
                if (index != steps.length - 1) ...[
                  SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      height: 2,
                      color:
                          stepNumber < currentStep ? checkColor : inactiveColor,
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ],
            ),
          );
        }),
      ),
    );
  }
}
