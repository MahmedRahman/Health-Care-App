import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetHelper {
  /// Bottom Sheet مخصص بالكامل بأي Widget
  static void showCustom({
    required Widget child,
    double radius = 20,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    Get.bottomSheet(
      Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        ),
        child: child,
      ),
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// Bottom Sheet بسيط فيه عنوان، رسالة، وزرين (إجراء أو إلغاء)
  static void showAction({
    required String title,
    required String message,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color confirmColor = Colors.blue,
  }) {
    showCustom(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(message,
              style: const TextStyle(fontSize: 16, color: Colors.black54)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.back();
                    if (onCancel != null) onCancel();
                  },
                  child: Text(cancelText),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    if (onConfirm != null) onConfirm();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: confirmColor),
                  child: Text(confirmText),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
