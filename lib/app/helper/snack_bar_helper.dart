import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void showSuccess(String message, {String title = 'Success'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  static void showError(String message, {String title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }
}

class DialogHelper {
  static void showSuccess(String message, {String title = 'Success'}) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(fontSize: 16),
      backgroundColor: Colors.white,
      radius: 12,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      buttonColor: Colors.green,
      onConfirm: () => Get.back(),
    );
  }

  static void showError(String message, {String title = 'Error'}) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(fontSize: 16),
      backgroundColor: Colors.white,
      radius: 12,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () => Get.back(),
    );
  }
}
