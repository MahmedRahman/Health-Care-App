import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  /// Dialog تحميل (Loading)
  static void showLoading([String message = 'Loading...']) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 20),
                Flexible(child: Text(message)),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// إخفاء أي Dialog مفتوح
  static void hideDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  /// Dialog خطأ أو تحذير
  static void showError(String message, {String title = 'Error'}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      backgroundColor: Colors.white,
      titleStyle:
          const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      middleTextStyle: const TextStyle(color: Colors.black87),
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  /// Dialog تأكيد
  static void showConfirm({
    required String message,
    String title = 'Confirm',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: confirmText,
      textCancel: cancelText,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        if (onConfirm != null) onConfirm();
      },
      onCancel: () {
        if (onCancel != null) onCancel();
      },
    );
  }
}
