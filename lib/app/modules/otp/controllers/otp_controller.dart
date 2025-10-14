import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/modules/otp/views/otp_view.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class OtpController extends GetxController {
  CodeInputDisplayTimer controllerInputDisplay =
      Get.put(CodeInputDisplayTimer());

  RxBool isButtonEnabled = false.obs;

  RxBool isVerifiedButtonEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    controllerInputDisplay.startTimer();
  }

  void ReSendVerificationCode() async {
    Response response =
        await ApiRequest().sendOTP(email: Get.arguments['email']);

    if (response.statusCode == 200) {
      isButtonEnabled.value = false;
      isVerifiedButtonEnabled.value = true;
      controllerInputDisplay.timerText.value = 60;
      controllerInputDisplay.startTimer();

      Get.snackbar(
        "Success",
        "Code has been resent.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Failed to send verification code. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void verifyCode(String code) async {
    if (code.length != 4) {
      Get.snackbar(
        "Error",
        "Please enter a valid 4-digit code.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      Response response = await ApiRequest().verifyOTP(
        email: Get.arguments['email'],
        otp: code,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Code verified successfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAndToNamed(
          Routes.NEW_PASSWORD,
          arguments: {'email': Get.arguments['email']},
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to verify code. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
