import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';

class PatientInfoController extends GetxController with StateMixin {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getPatientInfo();
    await getDiagnosePrimary();
  }

  Future getPatientInfo() async {
    Response response = await ApiRequest().getPatientInfo();
    if (response.statusCode == 200) {
      var data = response.body;
      print("Patient Info: $data");
    } else {
      print("Failed to fetch patient info: ${response.statusCode}");
    }
  }

  List<dynamic> DiagnosePrimaryList = [];

  Future getDiagnosePrimary() async {
    try {
      if (DiagnosePrimaryList.isEmpty) {
        Response response = await ApiRequest().getDiagnosePrimary();
        DiagnosePrimaryList = response.body;
      }
    } catch (e) {
      DiagnosePrimaryList = [];
    }
  }

  // void getPatientInfo() async {
  //   Response response = await ApiRequest().getPatientInfo();
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     print("Patient Info: $data");
  //   } else {
  //     print("Failed to fetch patient info: ${response.statusCode}");
  //   }
  // }

  // void getPatientInfo() async {
  //   Response response = await ApiRequest().getPatientInfo();
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     print("Patient Info: $data");
  //   } else {
  //     print("Failed to fetch patient info: ${response.statusCode}");
  //   }
  // }

  // void getPatientInfo() async {
  //   Response response = await ApiRequest().getPatientInfo();
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     print("Patient Info: $data");
  //   } else {
  //     print("Failed to fetch patient info: ${response.statusCode}");
  //   }
  // }
}
