import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/data/medicine.dart';

class MedicationsController extends GetxController
    with StateMixin<List<dynamic>> {
  @override
  void onInit() {
    super.onInit();
    change(medicines, status: RxStatus.success());
    featchMedications();
  }

  void featchMedications() async {
    Response response = await ApiRequest().getMedicines();

    if (response.statusCode == 200) {
      List<dynamic> data = response.body;

      change(data, status: RxStatus.success());

      if (data.isEmpty) {
        change(null, status: RxStatus.empty());
      }
    } else {
      change(null, status: RxStatus.error('Failed to fetch medications'));
    }
  }
}
