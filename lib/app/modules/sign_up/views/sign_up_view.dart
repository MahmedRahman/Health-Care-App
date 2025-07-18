import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/PdfViewer/views/pdf_viewer_view.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_agreement_check.dart';
import 'package:health_care_app/app/widgets/app_phone_field.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_rich_text_button.dart';
import 'package:health_care_app/app/widgets/app_success_dialog.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';
import 'package:health_care_app/app/widgets/layout/app_page_wrapper.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  SignUpView({Key? key}) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String countryCode = "966";
  String selectedCode = "966";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: AppPageWrapper(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 80.h,
                  color: AppColors.primary,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -40.h,
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/Logo-2.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.sp),
              child: Column(
                children: [
                  Obx(() {
                    return Visibility(
                      visible: controller.showStepOne.value,
                      child: buildStepOne(
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        phoneController: phoneController,
                        countryCode: countryCode,
                        emailController: emailController,
                        onPressed: () {
                          controller.showStepOne.value =
                              !controller.showStepOne.value;
                        },
                      ),
                      replacement: buildStepTwo(),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildStepOne({
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController phoneController,
  required String countryCode,
  required TextEditingController emailController,
  required void Function() onPressed,
}) {
  return Column(
    children: [
      AppTextField(
        label: "First Name",
        hintText: "Enter your first name",
        controller: firstNameController,
        keyboardType: TextInputType.emailAddress,
        labelColor: AppColors.textLight,
      ),
      SizedBox(height: 16.h),
      AppTextField(
        label: "Last Name",
        hintText: "Enter your last name",
        controller: lastNameController,
        keyboardType: TextInputType.emailAddress,
        labelColor: AppColors.textLight,
      ),
      SizedBox(height: 16.h),
      AppPhoneField(
        label: "Phone Number",
        selectedCode: "+20",
        countryCodes: ["966", "971", "965", "974", "+20"],
        labelColor: AppColors.textLight,
        onCodeChanged: (newCode) {
          //selectedCode = newCode;
        },
        controller: TextEditingController(),
      ),
      SizedBox(height: 16.h),
      AppTextField(
        label: "Email Address",
        hintText: "Enter your email address",
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        labelColor: AppColors.textLight,
      ),
      SizedBox(height: 16.h),
      AppAgreementCheck(
        value: true,
        onChanged: (val) {},
        onTermsTap: () async {
          Get.to(() => const TermsPage());
        },
      ),
      SizedBox(height: 16.h),
      AppPrimaryButton(
        text: "Next",
        onPressed: onPressed,
        borderRadius: 50,
      ),
      SizedBox(height: 24.h),
      Center(
        child: AppRichTextButton(
          normalText: "Already have an account?",
          actionText: "Login",
          actionTextColor: AppColors.primary,
          onTap: () {
            Get.toNamed(Routes.SIGN_IN);
          },
        ),
      ),
      SizedBox(height: 16.h),
    ],
  );
}

class buildStepTwo extends StatelessWidget {
  const buildStepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        AppTextField(
          label: "Hospital  ID",
          hintText: "Please Add ID Number",
          controller: TextEditingController(),
          keyboardType: TextInputType.emailAddress,
          labelColor: AppColors.textLight,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          label: "Password",
          hintText: "Enter your password",
          controller: TextEditingController(),
          isPassword: true,
          labelColor: AppColors.textLight,
        ),
        SizedBox(height: 16.h),
        AppTextField(
          label: "Confirm Password",
          hintText: "Confirm your password",
          controller: TextEditingController(),
          isPassword: true,
          labelColor: AppColors.textLight,
        ),
        SizedBox(height: 32.h),
        AppPrimaryButton(
          text: "Complete",
          borderRadius: 50,
          onPressed: () {
            showSuccessDialog(
              context,
              userId: "123654",
              onAddInfo: () {
                Get.offAllNamed(Routes.HOME);
              },
            );
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
