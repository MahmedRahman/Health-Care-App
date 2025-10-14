import 'package:get/get.dart';

import '../controllers/care_gevers_controller.dart';

class CareGeversBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CareGeversController>(
      () => CareGeversController(),
    );
  }
}
