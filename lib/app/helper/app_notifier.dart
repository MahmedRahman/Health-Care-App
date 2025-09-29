import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 1) Config/Theme (مكان واحد تغيّر منه كل السيستم)
class NotifierTheme {
  static Duration duration = const Duration(seconds: 3);
  static EdgeInsets margin = const EdgeInsets.all(16);
  static double radius = 12;

  static Color successColor = Colors.green.shade600;
  static Color errorColor = Colors.red.shade600;
  static Color textOnColor = Colors.white;

  // يمكن إضافة fonts, icons, positions... حسب الحاجة
}

/// 2) Contract موحّد
abstract class AppNotifier {
  void success(String message, {String title = 'Success'});
  void error(String message, {String title = 'Error'});
}

/// 3) Snackbar implementation
class SnackbarNotifier implements AppNotifier {
  @override
  void success(String message, {String title = 'Success'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: NotifierTheme.successColor,
      colorText: NotifierTheme.textOnColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: NotifierTheme.margin,
      borderRadius: NotifierTheme.radius,
      duration: NotifierTheme.duration,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  @override
  void error(String message, {String title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: NotifierTheme.errorColor,
      colorText: NotifierTheme.textOnColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: NotifierTheme.margin,
      borderRadius: NotifierTheme.radius,
      duration: NotifierTheme.duration,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }
}

/// 4) Dialog implementation (UI موحّد مع أيقونة)
class DialogNotifier implements AppNotifier {
  @override
  void success(String message, {String title = 'Success'}) {
    _dialog(
      title: title,
      color: NotifierTheme.successColor,
      icon: Icons.check_circle,
      message: message,
    );
  }

  @override
  void error(String message, {String title = 'Error'}) {
    _dialog(
      title: title,
      color: NotifierTheme.errorColor,
      icon: Icons.error,
      message: message,
    );
  }

  void _dialog({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NotifierTheme.radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ]),
              const SizedBox(height: 12),
              Text(message, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: NotifierTheme.textOnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(NotifierTheme.radius),
                    ),
                  ),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}

class AwesomeDialogNotifier implements AppNotifier {
  BuildContext? get _ctx => Get.context;

  void _ensureContextOrFallback(
      VoidCallback showFn, String fallbackTitle, String msg, Color bg) {
    final ctx = _ctx;
    if (ctx == null) {
      // Fallback if no context (e.g., called before first frame)
      Get.snackbar(fallbackTitle, msg,
          backgroundColor: bg,
          colorText: NotifierTheme.textOnColor,
          snackPosition: SnackPosition.BOTTOM,
          margin: NotifierTheme.margin,
          borderRadius: NotifierTheme.radius,
          duration: NotifierTheme.duration);
      return;
    }
    showFn();
  }

  @override
  void success(String message, {String title = 'Success'}) {
    _ensureContextOrFallback(() {
      AwesomeDialog(
        context: _ctx!,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        headerAnimationLoop: false,
        title: title,
        desc: message,
        btnOkOnPress: () {},
        btnOkColor: NotifierTheme.successColor,
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: true,
        padding: const EdgeInsets.all(16),
        borderSide: BorderSide(color: NotifierTheme.successColor, width: 1),
      ).show();
    }, title, message, NotifierTheme.successColor);
  }

  @override
  void error(String message, {String title = 'Error'}) {
    _ensureContextOrFallback(() {
      AwesomeDialog(
        context: _ctx!,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        headerAnimationLoop: false,
        title: title,
        desc: message,
        btnOkOnPress: () {},
        btnOkColor: NotifierTheme.errorColor,
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: true,
        padding: const EdgeInsets.all(16),
        borderSide: BorderSide(color: NotifierTheme.errorColor, width: 1),
      ).show();
    }, title, message, NotifierTheme.errorColor);
  }
}

/// 5) Factory/Switch مركزي
enum NotifierMode { snackbar, dialog, awesome }

class Notifier {
  static AppNotifier _impl = SnackbarNotifier(); // default

  static void use(NotifierMode mode) {
    switch (mode) {
      case NotifierMode.dialog:
        _impl = DialogNotifier();
        break;
      case NotifierMode.awesome:
        _impl = AwesomeDialogNotifier();
        break;
      case NotifierMode.snackbar:
      default:
        _impl = SnackbarNotifier();
    }
  }

  static AppNotifier get of => _impl;

  // override مؤقت بدون تغيير النظام كله
  static void withMode(NotifierMode mode, void Function(AppNotifier n) action) {
    final prev = _impl;
    use(mode);
    action(_impl);
    _impl = prev; // رجّع القديم
  }
}
