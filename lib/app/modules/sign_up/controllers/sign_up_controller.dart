import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_success_dialog.dart';

class SignUpController extends GetxController with StateMixin {
  var showStepOne = true.obs;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController hospitalId = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String selectedCode = "+20";

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  void signUp() {
    showSuccessDialog(
      Get.context!,
      userId: "123654",
      onAddInfo: () {
        Get.offAllNamed(Routes.HOME);
      },
    );
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
