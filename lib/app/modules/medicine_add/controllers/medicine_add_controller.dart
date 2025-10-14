import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';
import 'package:health_care_app/app/modules/medications/controllers/medications_controller.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class MedicineAddController extends GetxController with StateMixin<dynamic> {
  //TODO: Implement MedicineAddController

  final formKey = GlobalKey<FormState>();

  final medicineImage = TextEditingController();

  final doctorNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final specialInstructionController = TextEditingController();
  final renewalDateController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );
  final startDateController = TextEditingController(
    text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
  );

  final selectedMedicineName = ''.obs;
  final medicineNames = ['Medicine 1', 'Medicine 2', 'Medicine 3'].obs;

  final selectedDose = '1'.obs;
  final doseNames = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'].obs;

  final selectedForm = ''.obs;
  final formNames = ['Tablet', 'Capsule', 'Syrup', "Ointment"].obs;

  final selectedRoute = ''.obs;
  final routeNames =
      ['Oral', 'Intravenous', 'Intramuscular', 'Subcutaneous', 'Topical'].obs;

  final selectedFrequency = 'daily'.obs;
  final frequencyNames = ["daily", "weekly", "monthly"].obs;

  final selectedDuration = '1'.obs;
  final durationNames = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"].obs;

  final selectedDurationFrequency = 'days'.obs;
  final DurationFrequencyNames = ["days", "weeks", "months"].obs;

  final doseTimeList = <String>[].obs;

  var doseDateList = "${DateTime.now().toLocal()}".split(' ')[0];
  final doseDaysList = [].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize doseTimeList with default time
    doseTimeList.add("${TimeOfDay.now().format(Get.context!)}");
    change(null, status: RxStatus.success());
  }

  Future<void> addMedicine() async {
    if (formKey.currentState!.validate() == false) {
      return;
    }

    change(null, status: RxStatus.loading());

    // معالجة التكرار بناءً على النوع المختار
    if (selectedFrequency.value == "daily") {
      // للجرعات اليومية، لا نحتاج لتعديل doseTimeList
    } else if (selectedFrequency.value == "weekly") {
      // للجرعات الأسبوعية، نضيف أيام الأسبوع المختارة
      if (doseDaysList.isNotEmpty) {
        var newDoseTime = <String>[];
        for (var time in doseTimeList) {
          newDoseTime.add("$time (${doseDaysList.join(", ")})");
        }
        doseTimeList.value = newDoseTime;
      }
    } else if (selectedFrequency.value == "monthly") {
      // للجرعات الشهرية، نضيف التاريخ المحدد
      if (doseDateList.isNotEmpty) {
        var newDoseTime = <String>[];
        for (var time in doseTimeList) {
          newDoseTime.add("$time (${doseDateList})");
        }
        doseTimeList.value = newDoseTime;
      }
    }

    try {
      await ApiRequest().addMedicine(
        medicineName: selectedMedicineName.value,
        medicineImage: medicineImage.text,
        dose: selectedDose.value,
        doseForm: selectedForm.value,
        doseRoute: selectedRoute.value,
        doseFrequency: selectedFrequency.value,
        doseDuration: selectedDuration.value,
        doseDurationList: selectedDurationFrequency.value,
        doseTimeList: List<String>.from(doseTimeList),
        specialInstructions: specialInstructionController.text,
        description: descriptionController.text,
        doctorName: doctorNameController.text,
        startFrom: startDateController.text,
        renewalDate: renewalDateController.text,
      );

      Get.snackbar(
        'Medicine added successfully!',
        'Medicine Added',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Notifier.withMode(NotifierMode.snackbar, (notifier) {
        notifier.error(
          '${e.toString()}',
          title: 'Medicine',
        );
      });
    } finally {
      Get.find<MedicationsController>().featchMedications();
      Get.back(closeOverlays: true);
    }
  }

  final _fmt = DateFormat('dd/MM/yyyy');
  int _daysInMonth(int year, int month) {
    final firstOfNextMonth =
        (month == 12) ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return firstOfNextMonth.subtract(const Duration(days: 1)).day;
  }

  /// إضافة أشهر مع الحفاظ على اليوم قدر الإمكان
  DateTime _addMonths(DateTime dt, int months) {
    final m0 = dt.month;
    final y0 = dt.year;
    final total = m0 + months; // قد تتخطى 12
    final year = y0 + ((total - 1) ~/ 12);
    final month = ((total - 1) % 12) + 1;
    final day = min(dt.day, _daysInMonth(year, month));
    return DateTime(year, month, day, dt.hour, dt.minute, dt.second,
        dt.millisecond, dt.microsecond);
  }

  String computeRenewalDate({
    required String startDateStr, // بصيغة dd/MM/yyyy
    required int amount, // 1,2,3…
    required String unit, // daily, weekly, monthly, yearly
  }) {
    final start = _fmt.parse(startDateStr);
    final u = unit.trim().toLowerCase();

    DateTime renewal;
    if (u == 'day' || u == 'daily' || u == 'days') {
      renewal = start.add(Duration(days: amount));
    } else if (u == 'week' || u == 'weekly' || u == 'weeks') {
      renewal = start.add(Duration(days: 7 * amount));
    } else if (u == 'month' || u == 'monthly' || u == 'months') {
      renewal = _addMonths(start, amount);
    } else if (u == 'year' || u == 'yearly' || u == 'years') {
      renewal = _addMonths(start, 12 * amount);
    } else {
      // fallback: اعتبرها أيام
      renewal = start.add(Duration(days: amount));
    }

    return _fmt.format(renewal);
  }

  void calculateRenewalDate() {
    final renewalDate = computeRenewalDate(
      startDateStr: startDateController.text,
      amount: int.parse(selectedDuration.value),
      unit: selectedDurationFrequency.value,
    );
    renewalDateController.text = renewalDate;
  }

  final otherMedicineController = TextEditingController();

  void addOtherMedicine() {
    Get.defaultDialog(
      title: 'Add Other Medicine',
      content: TextFormField(
        controller: otherMedicineController,
        decoration: InputDecoration(labelText: 'Other Medicine'),
      ),
      actions: [
        AppPrimaryButton(
          text: 'Add',
          borderRadius: 12,
          onPressed: () {
            selectedMedicineName.value = otherMedicineController.text;
            otherMedicineController.clear();
            Get.back();
          },
        ),
      ],
    );
  }
}
