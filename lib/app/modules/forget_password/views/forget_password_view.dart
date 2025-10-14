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
      backgroundColor: Color(0xfffF2F2F2),
      appBar: AppBar(
        title: const Text('Reset password'),
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
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
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
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
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
              Image.asset(
                "assets/images/foget_image.png",
              ),
              SizedBox(height: 16.h),
              Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidateMode,
                child: AppTextField(
                  label: "Email",
                  hintText: "Enter your email address",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelColor: AppColors.textLight,
                  validator: ValidationHelper.validateEmail,
                ),
              ),
              SizedBox(height: 16.h),
              AppPrimaryButton(
                text: "Send Verification Code",
                onPressed:  () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.sendVerificationCode();
                   
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
