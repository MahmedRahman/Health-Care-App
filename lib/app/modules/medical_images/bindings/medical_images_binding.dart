import 'package:get/get.dart';
import '../controllers/medical_images_controller.dart';

class MedicalImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicalImagesController>(
      () => MedicalImagesController(),
    );
  }
}