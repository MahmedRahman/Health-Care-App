import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/helper/snack_bar_helper.dart';
import 'package:health_care_app/app/helper/validation_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffF2F2F2),
      appBar: AppBar(
        title: const Text(
          'Enter New Password',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xfffF2F2F2),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
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
          child: Container(
            width: double.infinity,
            child: Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidateMode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16.h),
                  AppTextField(
                    label: "Password",
                    hintText: "Enter your password",
                    controller: controller.passwordController,
                    isPassword: true,
                    labelColor: AppColors.textLight,
                    validator: ValidationHelper.validatePassword,
                  ),
                  SizedBox(height: 12.h),
                  AppTextField(
                    label: "Confirm Password",
                    hintText: "Confirm password",
                    controller: controller.confirmPasswordController,
                    isPassword: true,
                    labelColor: AppColors.textLight,
                    validator: (value) =>
                        ValidationHelper.validateConfirmPassword(
                      value,
                      controller.passwordController.text,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  AppPrimaryButton(
                    text: "Done",
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        Get.offAllNamed(Routes.HOME);
                        SnackbarHelper.showSuccess(
                          "Password updated successfully",
                        );
                      } else {
                        controller.autoValidateMode =
                            AutovalidateMode.onUserInteraction;
                        controller.update();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
