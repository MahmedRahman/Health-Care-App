import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/helper/validation_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_button.dart';
import 'package:health_care_app/app/widgets/app_checkbox.dart';
import 'package:health_care_app/app/widgets/app_icon_button.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:health_care_app/app/widgets/app_rich_text_button.dart';
import 'package:health_care_app/app/widgets/app_text_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';
import 'package:health_care_app/app/widgets/layout/app_page_wrapper.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: controller.obx((state) {
        return AppPageWrapper(
          child: Form(
            key: controller.formKey,
            autovalidateMode: controller.autoValidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  "Login your account",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  label: "Email Address",
                  hintText: "Enter your email address",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationHelper.validateEmail,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  label: "Password",
                  hintText: "Enter your password",
                  controller: controller.passwordController,
                  validator: ValidationHelper.validatePassword,
                  isPassword: true,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppCheckBox(
                      value: controller.rememberMe,
                      onChanged: (newValue) {
                        controller.rememberMeOnClick(
                          newValue!,
                        );
                      },
                      label: "Remember Me",
                    ),
                    AppTextButton(
                      text: "Forgot Password",
                      onPressed: () {
                        Get.toNamed(Routes.FORGET_PASSWORD);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: "Sign in",
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.signIn();
                          } else {
                            controller.autoValidateMode =
                                AutovalidateMode.onUserInteraction;
                            controller.update();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 16.w),
                    AppIconButtonSvg(
                      assetPath: 'assets/svg/face.svg',
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      "Or continue with",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Spacer(),
                    AppIconButtonSvg(
                      assetPath: 'assets/svg/fb.svg',
                      onPressed: () {},
                    ),
                    SizedBox(width: 16.w),
                    AppIconButtonSvg(
                      onPressed: () {},
                      assetPath: 'assets/svg/apple.svg',
                    ),
                    SizedBox(width: 16.w),
                    AppIconButtonSvg(
                      assetPath: 'assets/svg/google.svg',
                      onPressed: () {},
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: AppRichTextButton(
                    normalText: "Don’t have an account?",
                    actionText: "Sign Up",
                    onTap: () {
                      Get.toNamed(Routes.SIGN_UP);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }
}
