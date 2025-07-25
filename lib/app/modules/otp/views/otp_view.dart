import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/helper/snack_bar_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_button.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar: AppBar(
        title: const Text('OTP'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                "Check The Message We Sent ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "We, have sent the verification code ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8.h),
              SvgPicture.asset(
                "assets/svg/confirmed-otp.svg",
                height: 200.h,
                width: 200.w,
              ),
              SizedBox(height: 8.h),
              CodeInputDisplay(
                digits: ["8", "8", "7", "6"],
                timerText: "01:12",
              ),
              SizedBox(height: 16.h),
              AppPrimaryButton(
                text: "Verified",
                onPressed: () {
                  Get.toNamed(Routes.NEW_PASSWORD);
                },
              ),
              SizedBox(height: 24.h),
              AppTextButton(
                text: "Resend Code",
                onPressed: () {
                  SnackbarHelper.showSuccess("Code has been resent");
                },
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CodeInputDisplay extends StatelessWidget {
  final List<String> digits;
  final String timerText;

  const CodeInputDisplay({
    super.key,
    required this.digits,
    required this.timerText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // أرقام الـ code
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: digits.map((digit) {
            return Container(
              width: 72,
              height: 72,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade100, width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                digit,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        // النص اللي تحت
        RichText(
          text: TextSpan(
            text: "code expires in: ",
            style: const TextStyle(color: Colors.grey),
            children: [
              TextSpan(
                text: timerText,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
