import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/data/medicine.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';

class MedicationsController extends GetxController
    with StateMixin<List<dynamic>> {
  RxList<dynamic> meds = RxList.empty();
  @override
  void onInit() {
    super.onInit();

    featchMedications();
  }

  void featchMedications() async {
    change(null, status: RxStatus.loading());

    try {
      Response response = await ApiRequest().getMedicines();

      meds.value = response.body;

      List<dynamic> data = response.body;

      if (data.isEmpty) {
        change(null, status: RxStatus.empty());
        return;
      }

      change(data, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('Failed to fetch medications'));
    }
  }

  void checkDone(String medicineId) async {
    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().checkDone(
        medicineId: medicineId,
      );
      if (response.statusCode == 200) {
        Notifier.of.success('Medicine checked done successfully');
      } else {
        Notifier.of.error('Failed to check done');
      }
    } catch (e) {
      Notifier.of.error('Failed to check done');
    } finally {
      featchMedications();
    }
  }

  double percentToFraction(dynamic value) {
    if (value == null) return 0.0;
    final s = value.toString().replaceAll('%', '').trim();
    final d = double.tryParse(s) ?? 0.0;
    return d > 1 ? d / 100.0 : d; // supports both 0..1 and 0..100 inputs
  }
}
