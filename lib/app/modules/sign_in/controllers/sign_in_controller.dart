import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';
import 'package:health_care_app/app/helper/snack_bar_helper.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class SignInController extends GetxController with StateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //TODO: Implement SignInController
  final TextEditingController emailController = TextEditingController(
    text: kDebugMode ? "atpfreelancer@gmail.com" : "",
  );
  final TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? "123456789" : "",
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
    change(null, status: RxStatus.loading());

    try {
      Response response = await ApiRequest().login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      var token = response.body['token'];
      await AuthService.to.saveAuth(token);
      Notifier.withMode(NotifierMode.snackbar, (notifier) {
        notifier.success(
          'Welcome back!',
          title: 'Sign In Successful',
        );
      });
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Notifier.of.error(
        'Please check your credentials and try again.',
        title: 'Sign In Failed',
      );
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  void rememberMeOnClick(bool value) {
    rememberMe = value;
    update();
  }
}
