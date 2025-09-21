import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/helper/snack_bar_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class SignInController extends GetxController with StateMixin {
  //TODO: Implement SignInController
  final TextEditingController emailController = TextEditingController(
    text: "atpfreelancer@gmail.com",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "123456789",
  );
//formKey

  bool rememberMe = false;

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      SnackbarHelper.showError('Please fill all fields');
    } else {
      try {
        Response response = await ApiRequest().login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        if (response.statusCode == 200) {
          var token = response.body['token'];
          await AuthService.to.saveAuth(token);
          SnackbarHelper.showSuccess('Signed in successfully');
          Get.offAllNamed(Routes.HOME);
        } else {
          var errorMessage = response.body['message'] ?? 'Login failed';
          SnackbarHelper.showError(errorMessage);
        }
      } catch (e) {
        SnackbarHelper.showError('An error occurred. Please try again.');
        print(e);
      }
    }
  }

  void rememberMeOnClick(bool value) {
    rememberMe = value;
    update();
  }
}
