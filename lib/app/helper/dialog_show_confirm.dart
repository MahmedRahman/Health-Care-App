import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

/// Shows a confirm dialog. Returns true if user pressed "Yes".
Future<bool> showConfirm({
  String title = 'Confirm',
  required String message,
  String okText = 'Yes',
  String cancelText = 'No',
  DialogType type = DialogType.question,
  bool dismissOnBackKeyPress = true,
  bool dismissOnTouchOutside = false,
}) async {
  // Use Get.currentContext if available, otherwise overlayContext.
  final ctx = Get.context ?? Get.overlayContext;
  if (ctx == null) return false;

  bool result = false;

  await AwesomeDialog(
    context: ctx,
    dialogType: type,
    headerAnimationLoop: false,
    dismissOnTouchOutside: dismissOnTouchOutside,
    dismissOnBackKeyPress: dismissOnBackKeyPress,
    animType: AnimType.scale,
    title: title,
    desc: message,
    btnCancelText: cancelText,
    btnOkText: okText,
    btnCancelOnPress: () {
      result = false;
    },
    btnOkOnPress: () {
      result = true;
    },
  ).show();

  return result;
}
