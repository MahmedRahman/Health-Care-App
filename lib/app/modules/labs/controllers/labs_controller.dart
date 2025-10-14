import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/modules/labs/widgets/upload_bottom_sheet.dart';
import 'package:health_care_app/app/modules/labs/widgets/upload_controller.dart';

class LabsController extends GetxController with StateMixin {
  @override
  void onInit() async {
    await getLabs();
    super.onInit();
  }

  List<dynamic> labs = [];
  Future<void> getLabs() async {
    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().getLabs();
      labs = response.body;

      if (labs.isEmpty) {
        change(null, status: RxStatus.empty());
        return;
      }

      change(labs, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('Failed to fetch labs'));
    }
  }

  void addLabReport({
    required String labName,
    required List<String> images,
  }) async {
    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().addLabReport(
        labName: labName,
        images: images,
      );

      if (response.statusCode == 200) {
        // إعادة تحميل البيانات
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to upload lab report: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      await getLabs();
    }
  }

  // إضافة تقرير مختبر جديد
  void addNewLabReport() {
    // مسح البيانات المحددة عند فتح الـ upload sheet
    try {
      final uploadController = Get.find<LabsUploadController>();
      uploadController.removeFile();
    } catch (e) {
      // الـ controller غير موجود، لا مشكلة
    }

    Get.bottomSheet(
      const UploadBottomSheet(),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      backgroundColor: Colors.transparent, // we style inside
    );
  }

  void deleteLabReport({
    required labReport,
  }) async {
    change(null, status: RxStatus.loading());
    try {
      var response =
          await ApiRequest().deleteLabReport(labId: labReport['id'].toString());

      if (response.statusCode == 200) {
        labs.remove(labReport);
      }
    } catch (e) {
      change(null, status: RxStatus.error('Failed to delete lab report'));
    } finally {
      if (labs.isEmpty) {
        change(null, status: RxStatus.empty());
        return;
      }
      change(labs, status: RxStatus.success());
    }
  }
}
