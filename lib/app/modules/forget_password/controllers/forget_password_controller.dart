import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class ForgetPasswordController extends GetxController with StateMixin {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void sendVerificationCode() async {
    if (formKey.currentState!.validate() == false) {
      Get.snackbar(
        "Error",
        "Failed to send verification code. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      Response response =
          await ApiRequest().sendOTP(email: emailController.text);

      Get.snackbar(
        "Success",
        "Verification code sent to your email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.toNamed(Routes.OTP, arguments: {
        "email": emailController.text,
      });
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to send verification code. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      change(null, status: RxStatus.success());
    }
  }
}
