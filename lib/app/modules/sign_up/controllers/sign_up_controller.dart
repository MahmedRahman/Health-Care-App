import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/core/network/web_services/api_exceptions.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';
import 'package:health_care_app/app/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_success_dialog.dart';

class SignUpController extends GetxController with StateMixin {
  var showStepOne = true.obs;
  final TextEditingController firstNameController = TextEditingController(
    text: "Ahmed",
  );
  final TextEditingController lastNameController = TextEditingController(
    text: "Ali",
  );
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController phoneController = TextEditingController(
    text: "1000000000",
  );
  final TextEditingController hospitalId = TextEditingController(
    text: "123456",
  );
  final TextEditingController passwordController = TextEditingController(
    text: "123456789",
  );
  final TextEditingController confirmPasswordController = TextEditingController(
    text: "123456789",
  );

  String selectedCode = "+20";

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void signUp() async {
    change(null, status: RxStatus.loading());

    try {
      Response response = await ApiRequest().register(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: "$selectedCode${phoneController.text.trim()}",
        hospitalId: hospitalId.text.trim(),
        password: passwordController.text.trim(),
      );

      showSuccessDialog(
        Get.context!,
        userId: "123654",
        onAddInfo: () {
          if (Get.isRegistered<SignInController>()) {
            Get.find<SignInController>().rememberMe = true;
            Get.find<SignInController>().emailController.text =
                emailController.text;
            Get.find<SignInController>().passwordController.text =
                passwordController.text;
          }
          Get.toNamed(Routes.SIGN_IN);
        },
      );
    } catch (e) {
      Notifier.of.error(
        '${e.toString()}',
        title: 'Sign Up Failed',
      );
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  @override
  void onClose() {
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    hospitalId.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
