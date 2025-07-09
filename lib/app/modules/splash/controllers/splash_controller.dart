import 'package:get/get.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(
        Routes.ONBOARDING,
      ); // يروح لصفحة الـ home ويشيل كل الشاشات السابقة
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
