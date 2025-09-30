import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/helper/validation_helper.dart';
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
  int spaceBetween = 16;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xfffF2F2F2),
        appBar: AppBar(
          title: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: controller.obx(
          (state) {
            return AppPageWrapper(
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
                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: controller.autoValidateMode,
                      child: Column(
                        children: [
                          AppTextField(
                            label: "First Name *",
                            hintText: "Enter your first name",
                            controller: controller.firstNameController,
                            keyboardType: TextInputType.emailAddress,
                            labelColor: AppColors.textLight,
                            validator: ValidationHelper
                                .validateNameOnlyEnglishAndArabic,
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppTextField(
                            label: "Last Name *",
                            hintText: "Enter your last name",
                            controller: controller.lastNameController,
                            keyboardType: TextInputType.emailAddress,
                            labelColor: AppColors.textLight,
                            validator: ValidationHelper
                                .validateNameOnlyEnglishAndArabic,
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppPhoneFieldForm(
                            label: "Phone Number *",
                            countryCodes: const [
                              "966",
                              "971",
                              "965",
                              "974",
                              "+20"
                            ],
                            initialCode: controller.selectedCode,
                            labelColor: AppColors.textLight,
                            onCodeChanged: (newCode) {
                              controller.selectedCode = newCode;
                              controller.update();
                            },
                            controller: controller.phoneController,
                            validator: ValidationHelper.validatePhone,
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppTextField(
                            label: "Email Address *",
                            hintText: "Enter your email address",
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            labelColor: AppColors.textLight,
                            validator: ValidationHelper.validateEmail,
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppTextField(
                            label: "Hospital  ID *",
                            hintText: "Please Add ID Number",
                            controller: controller.hospitalId,
                            keyboardType: TextInputType.emailAddress,
                            labelColor: AppColors.textLight,
                            validator: ValidationHelper.validateNumber,
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppTextField(
                            label: "Password *",
                            hintText: "Enter your password",
                            controller: controller.passwordController,
                            isPassword: true,
                            labelColor: AppColors.textLight,
                            validator: ValidationHelper.validatePassword,
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppTextField(
                            label: "Confirm Password *",
                            hintText: "Confirm your password",
                            controller: controller.confirmPasswordController,
                            isPassword: true,
                            labelColor: AppColors.textLight,
                            validator: (value) =>
                                ValidationHelper.validateConfirmPassword(
                              value,
                              controller.passwordController.text,
                            ),
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppAgreementCheckForm(
                            onTermsTap: () async {
                              Get.to(() => const TermsPage());
                            },
                            validator: (value) {
                              if (value != true) {
                                return 'You must agree to the terms';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: spaceBetween.h),
                          AppPrimaryButton(
                            text: "Complete",
                            borderRadius: 50,
                            onPressed: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.signUp();
                              } else {
                                controller.autoValidateMode =
                                    AutovalidateMode.onUserInteraction;
                                controller.update();
                              }
                            },
                          ),
                          SizedBox(height: spaceBetween.h),
                          Center(
                            child: AppRichTextButton(
                              normalText: "Already have an account?",
                              actionText: "Login",
                              actionTextColor: AppColors.primary,
                              onTap: () {
                                Get.toNamed(
                                  Routes.SIGN_IN,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: spaceBetween.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
