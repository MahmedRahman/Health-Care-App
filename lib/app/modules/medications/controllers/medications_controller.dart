import 'package:get/get.dart';
import 'package:health_care_app/app/data/medicine.dart';

class MedicationsController extends GetxController
    with StateMixin<List<Medicine>> {
  @override
  void onInit() {
    super.onInit();
    change(medicines, status: RxStatus.success());
  }
}
