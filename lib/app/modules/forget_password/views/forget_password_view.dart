import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/helper/validation_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_button.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar: AppBar(
        title: const Text('Reset password'),
        backgroundColor: AppColors.accent,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        titleTextStyle: const TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: controller.obx((state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "Forgot Password ?",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Enter your email",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 16.h),
              SvgPicture.asset(
                "assets/svg/forget_password.svg",
                height: 200.h,
                width: 200.w,
              ),
              Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidateMode,
                child: AppTextField(
                  label: "Email Address",
                  hintText: "Enter your email address",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelColor: AppColors.textLight,
                  validator: ValidationHelper.validateEmail,
                ),
              ),
              SizedBox(height: 16.h),
              AppPrimaryButton(
                text: "Send verification code",
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    Get.toNamed(Routes.OTP);
                  } else {
                    controller.autoValidateMode =
                        AutovalidateMode.onUserInteraction;
                    controller.update();
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
