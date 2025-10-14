import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:health_care_app/app/core/network/api_request.dart';

class LookupService extends GetxService {
  @override
  void onInit() {
    super.onInit();
  }

  Future init() async {
    await Future.wait([
      getDiagnosePrimary(),
      getDiagnoseSecondary(),
      getDiagnoseTertiary(),
      getPresonalTeam(),
      getNurse(),
      getMedicine(),
    ]);
  }

  RxList<String> DiagnosePrimaryListNames = RxList.empty();
  Future getDiagnosePrimary() async {
    try {
      if (DiagnosePrimaryListNames.value.isEmpty) {
        Response response = await ApiRequest().getDiagnosePrimary();
        DiagnosePrimaryListNames.value = extractNames(response.body);
      }
    } catch (e) {
      DiagnosePrimaryListNames.value = [];
    }
  }

  RxList<String> DiagnoseSecondaryListNames = RxList.empty();
  Future getDiagnoseSecondary() async {
    try {
      if (DiagnoseSecondaryListNames.value.isEmpty) {
        Response response = await ApiRequest().getDiagnoseSecondary();
        DiagnoseSecondaryListNames.value = extractNames(response.body);
      }
    } catch (e) {
      DiagnoseSecondaryListNames.value = [];
    }
  }

  RxList<String> DiagnoseTertiaryListNames = RxList.empty();

  Future getDiagnoseTertiary() async {
    try {
      if (DiagnoseTertiaryListNames.value.isEmpty) {
        Response response = await ApiRequest().getDiagnoseSecondary();
        DiagnoseTertiaryListNames.value = extractNames(response.body);
      }
    } catch (e) {
      DiagnoseTertiaryListNames.value = [];
    }
  }

  RxList<String> PresonalTeamListNames = RxList.empty();
  Future getPresonalTeam() async {
    try {
      if (PresonalTeamListNames.value.isEmpty) {
        Response response = await ApiRequest().getTeamList();
        PresonalTeamListNames.value = extractNames(response.body);
      }
    } catch (e) {
      PresonalTeamListNames.value = [];
    }
  }

  RxList<String> NurseListNames = RxList.empty();
  Future getNurse() async {
    try {
      if (NurseListNames.value.isEmpty) {
        Response response = await ApiRequest().getNurseNamesList();
        NurseListNames.value = extractNames(response.body);
      }
    } catch (e) {
      NurseListNames.value = [];
    }
  }

  RxList<String> MedicineListNames = RxList.empty();
  Future getMedicine() async {
    try {
      if (MedicineListNames.value.isEmpty) {
        Response response = await ApiRequest().getMedicineNamesList();
        MedicineListNames.value = extractNames(response.body);
      }
    } catch (e) {
      MedicineListNames.value = [];
    }
  }

  List<String> extractNames(List<dynamic> data) {
    return data
        .map<String>((item) => item['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty) // يتأكد إنها مش فاضية
        .toList();
  }
}
