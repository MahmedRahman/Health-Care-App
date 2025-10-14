import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/helper/snack_bar_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_button.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  OtpController controllers = Get.put(OtpController());

  OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffF2F2F2),
      appBar: AppBar(
        title: const Text('OTP'),
        backgroundColor: Color(0xfffF2F2F2),
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
              Image.asset(
                "assets/images/otp_view.png",
                height: 200.h,
                width: 200.w,
              ),
              Text(
                "Check The Message We Sent ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
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
              SizedBox(height: 8.h),
              CodeInputDisplay(
                  // digits: ["", "", "", ""],
                  // timerText: "60",
                  ),
              SizedBox(height: 16.h),
              Obx(() {
                return AppPrimaryButton(
                  text: "Verified",
                  onPressed: controller.isVerifiedButtonEnabled.value
                      ? () {
                          controllers.verifyCode(
                            controllers.controllerInputDisplay.digits.join(),
                          );
                        }
                      : null,
                  backgroundColor: controller.isVerifiedButtonEnabled.value
                      ? AppColors.primary
                      : Colors.grey,
                );
              }),
              SizedBox(height: 24.h),
              Obx(() {
                return AppTextButton(
                  text: "Resend Code",
                  onPressed: controllers.isButtonEnabled.value
                      ? () {
                          controllers.ReSendVerificationCode();
                        }
                      : null,
                  color: controllers.isButtonEnabled.value
                      ? AppColors.primary
                      : Colors.grey,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CodeInputDisplayTimer extends GetxController {
  var timerText = 60.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (timerText.value > 0) {
        timerText.value--;
        return true; // Continue the loop
      } else {
        Get.find<OtpController>().isButtonEnabled.value = true;
        Get.find<OtpController>().isVerifiedButtonEnabled.value = false;
        return false; // Stop the loop
      }
    });
  }

  var digits = <String>["", "", "", ""].obs;

  // تحديث خانة معينة
  void updateDigit(int index, String value) {
    if (index >= 0 && index < digits.length) {
      digits[index] = value;
    }
  }
}

// class CodeInputDisplay extends GetView<CodeInputDisplayTimer> {
//   final List<String> digits;
//   final String timerText;

//   const CodeInputDisplay({
//     super.key,
//     required this.digits,
//     required this.timerText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // أرقام الـ code
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: digits.map((digit) {
//             return Container(
//               width: 72,
//               height: 72,
//               margin: const EdgeInsets.symmetric(horizontal: 6),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.blue.shade100, width: 2),
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 digit,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blueGrey,
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 12),
//         // النص اللي تحت
//         Obx(() {
//           return RichText(
//             text: TextSpan(
//               text: "code expires in: ",
//               style: const TextStyle(color: Colors.grey),
//               children: [
//                 TextSpan(
//                   text: controller.timerText.value.toString(),
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'code_input_display_timer.dart';

class CodeInputDisplay extends GetView<CodeInputDisplayTimer> {
  const CodeInputDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ خانات الإدخال
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                keyboardType: TextInputType.number, // لوحة أرقام فقط
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // يمنع غير الأرقام
                  LengthLimitingTextInputFormatter(1), // رقم واحد فقط
                ],
                onChanged: (value) {
                  controller.updateDigit(index, value);
                  // لو تبغى تركّز تلقائياً على الحقل اللي بعده:
                  if (value.isNotEmpty && index < 3) {
                    FocusScope.of(context).nextFocus();
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide:
                        BorderSide(color: Colors.blue.shade100, width: 2),
                  ),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 12),

        // ✅ النص تحت مع التايمر
        Obx(() {
          return RichText(
            text: TextSpan(
              text: "code expires in: ",
              style: const TextStyle(color: Colors.grey),
              children: [
                TextSpan(
                  text: controller.timerText.value.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
