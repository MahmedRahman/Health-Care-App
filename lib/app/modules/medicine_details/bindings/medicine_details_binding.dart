import 'package:get/get.dart';

import '../controllers/medicine_details_controller.dart';

class MedicineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineDetailsController>(
      () => MedicineDetailsController(),
    );
  }
}
