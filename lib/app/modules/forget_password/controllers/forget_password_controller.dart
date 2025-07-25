import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController with StateMixin {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void sendVerificationCode() {
    if (formKey.currentState!.validate()) {
      change(null, status: RxStatus.success());
    }
  }
}
