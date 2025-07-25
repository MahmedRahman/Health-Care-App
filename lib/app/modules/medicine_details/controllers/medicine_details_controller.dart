import 'package:get/get.dart';
import 'package:health_care_app/app/data/medicine.dart';

class MedicineDetailsController extends GetxController
    with StateMixin<Medicine> {
  @override
  void onInit() {
    super.onInit();
    change(Get.arguments, status: RxStatus.success());
  }
}
