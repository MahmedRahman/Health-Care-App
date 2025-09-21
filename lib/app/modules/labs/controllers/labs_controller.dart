import 'package:get/get.dart';

class LabsController extends GetxController with StateMixin {
  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }
}
