import 'package:get/get.dart';

import '../controllers/medications_controller.dart';

class MedicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicationsController>(
      () => MedicationsController(),
    );
  }
}
