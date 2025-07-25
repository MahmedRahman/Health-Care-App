import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void changePassword() {
    if (passwordController.text == confirmPasswordController.text) {
      change(null, status: RxStatus.success());
    }
  }
}
