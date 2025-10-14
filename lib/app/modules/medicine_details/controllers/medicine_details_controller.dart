import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/data/medicine.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';
import 'package:health_care_app/app/helper/dialog_show_confirm.dart';
import 'package:health_care_app/app/modules/medications/controllers/medications_controller.dart';

class MedicineDetailsController extends GetxController
    with StateMixin<dynamic> {
  @override
  void onInit() {
    super.onInit();
    change(Get.arguments, status: RxStatus.success());
  }

  void checkDone(String medicineId) async {
    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().checkDone(
        medicineId: medicineId,
      );
      if (response.statusCode == 200) {
        Notifier.of.success('Medicine checked done successfully');
      } else {
        Notifier.of.error('Failed to check done');
      }
    } catch (e) {
      Notifier.of.error('Failed to check done');
    } finally {
      featchMedications(medicineId);
    }
  }

  void featchMedications(id) async {
    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().getMedicinesDetailes(id);
      change(response.body, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('Failed to fetch medications'));
    }
  }

  void renewMedicine(String medicineId) async {
    final confirmed = await showConfirm(
      title: 'Renew item',
      message: 'Are you sure you want to renew this item?',
    );

    if (confirmed == false) return;
    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().renewMedicine(
        medicineId: medicineId,
      );
      if (response.statusCode == 200) {
        Notifier.of.success('Medicine renewed successfully');
      } else {
        Notifier.of.error('Failed to renew medicine');
      }
    } catch (e) {
      Notifier.of.error('Failed to renew medicine');
    } finally {
      featchMedications(medicineId);
    }
  }

  void deleteMedicine(String medicineId) async {
    final confirmed = await showConfirm(
      title: 'Delete item',
      message: 'Are you sure you want to delete this item?',
    );

    if (confirmed == false) return;

    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().deleteMedicine(
        medicineId: medicineId,
      );
      Notifier.withMode(NotifierMode.snackbar, (notifier) {
        notifier.success(
          'Medicine deleted successfully',
          title: 'Medicine Deleted',
        );
      });
    } catch (e) {
      print(e);
    } finally {
      Get.find<MedicationsController>().featchMedications();

      Get.back(closeOverlays: true);
    }
  }
}
