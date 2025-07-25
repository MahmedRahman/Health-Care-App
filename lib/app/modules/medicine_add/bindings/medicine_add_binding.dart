import 'package:get/get.dart';

import '../controllers/medicine_add_controller.dart';

class MedicineAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineAddController>(
      () => MedicineAddController(),
    );
  }
}
