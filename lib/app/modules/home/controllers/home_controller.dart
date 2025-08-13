import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  void onInit() {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Color(0xFF002B45), // ← لون الهيدر عندك
    //     statusBarColor: Color(0xFF002B45), // ← لون الهيدر عندك
    //     statusBarIconBrightness: Brightness.light, // ← لون الأيقونات أبيض
    //   ),
    // );
    super.onInit();
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
