import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void skip() {
    finishOnboarding();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void finishOnboarding() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Get.offAllNamed(Routes.SIGN_IN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
