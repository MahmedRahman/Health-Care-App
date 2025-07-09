import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_button.dart';
import 'package:health_care_app/app/widgets/app_checkbox.dart';
import 'package:health_care_app/app/widgets/app_icon_button.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:health_care_app/app/widgets/app_rich_text_button.dart';
import 'package:health_care_app/app/widgets/app_text_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  SignInView({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text('Sign In'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 61.h),
            Text(
              "Login your account",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 31.h),
            AppTextField(
              label: "Email Address",
              hintText: "Enter your email address",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),
            AppTextField(
              label: "Password",
              hintText: "Enter your password",
              controller: passwordController,
              isPassword: true,
            ),
            Row(
              children: [
                AppCheckBox(
                  value: false,
                  onChanged: (newValue) {},
                  label: "Remember Me",
                ),
                const Spacer(),
                AppTextButton(
                  text: "Forgot Password",
                  onPressed: () {
                    Get.toNamed(Routes.FORGET_PASSWORD);
                  },
                ),
              ],
            ),
            SizedBox(height: 60.h),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Sign in",
                    onPressed: () {
                      Get.offAllNamed(Routes.HOME);
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
            SizedBox(height: 30.h),
            Row(
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
            SizedBox(height: 60.h),
            Row(
              children: [
                Spacer(),
                AppIconButtonSvg(
                  assetPath: 'assets/svg/fb.svg',
                  onPressed: () {
                    print("Facebook button pressed!");
                  },
                ),
                SizedBox(width: 16.w),
                AppIconButtonSvg(
                  onPressed: () {
                    print("Facebook button pressed!");
                  },
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
            SizedBox(height: 30.h),
            Center(
              child: AppRichTextButton(
                normalText: "Don’t have an account?",
                actionText: "Sign Up",
                onTap: () {
                  Get.toNamed(Routes.SIGN_UP);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
