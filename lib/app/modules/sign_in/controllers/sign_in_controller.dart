import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/helper/snack_bar_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class SignInController extends GetxController with StateMixin {
  //TODO: Implement SignInController
  final TextEditingController emailController = TextEditingController(
    text: "ahmed.ali@gmail.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "123456",
  );
//formKey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool rememberMe = false;

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void signIn() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      SnackbarHelper.showError('Please fill all fields');
    } else {
      if (emailController.text == "ahmed.ali@gmail.com" &&
          passwordController.text == "123456") {
        SnackbarHelper.showSuccess('Signed in successfully');
        Get.toNamed(Routes.HOME);
      } else {
        SnackbarHelper.showError('Invalid email or password');
      }
    }
  }

  void rememberMeOnClick(bool value) {
    rememberMe = value;
    update();
  }
}
