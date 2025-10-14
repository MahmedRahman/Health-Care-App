import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class NewPasswordController extends GetxController with StateMixin {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

// formKey
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void changePassword() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      Response response = await ApiRequest().resetPassword(
        email: Get.arguments['email'],
        newPassword: passwordController.text,
      );

      Get.snackbar(
        "Success",
        "Password has been changed successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(
        Routes.SIGN_IN,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to change password. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    change(null, status: RxStatus.success());
  }
}
