import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';

class PatientInfoController extends GetxController with StateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPatientInfo();
  }

  void getPatientInfo() async {
    Response response = await ApiRequest().getPatientInfo();
    if (response.statusCode == 200) {
      var data = response.body;
      print("Patient Info: $data");
    } else {
      print("Failed to fetch patient info: ${response.statusCode}");
    }
  }
}
