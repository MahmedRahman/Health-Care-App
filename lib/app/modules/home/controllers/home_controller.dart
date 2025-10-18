import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/service/ver.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    Get.find<VersionService>().LoadVersionsData();
    getBloodPressure();
    await getHeartRate();
  }

  RxString avgSBP = '0'.obs;
  RxString avgDBP = '0'.obs;
  Rx<Color> bloodPressureColor = Colors.green.obs;
  List<Map<String, dynamic>> sbpChartSpots = [];
  List<Map<String, dynamic>> dbpChartSpots = [];
  List<Map<String, dynamic>> meanBloodPressureChartSpots = [];
  List<dynamic> bloodPressure = [];

  List<dynamic> heartRate = [];

  RxString avgHeartRate = '0'.obs;
  List<Map<String, dynamic>> heartRateChartSpots = [];
  Rx<Color> heartRateColor = Colors.green.obs;

  Future<void> getHeartRate() async {
    heartRate = Get.find<VersionService>().bloodRate;

    if (heartRate.isNotEmpty) {
      // حساب المتوسطات
      avgHeartRate.value =
          _calculateAverage(heartRate, 'heartRate').toStringAsFixed(2);

      heartRateChartSpots = _convertToChartSpots(heartRate, 'heartRate');
    }
    update();
  }

  void getBloodPressure() {
    bloodPressure = Get.find<VersionService>().bloodPressure;

    if (bloodPressure.isNotEmpty) {
      // حساب المتوسطات
      avgSBP.value = _calculateAverage(bloodPressure, 'sbp').toStringAsFixed(2);
      avgDBP.value = _calculateAverage(bloodPressure, 'dbp').toStringAsFixed(2);

      bloodPressureColor.value = getBloodPressureColor(
          double.parse(avgSBP.value), double.parse(avgDBP.value));

      sbpChartSpots = _convertToChartSpots(bloodPressure, 'sbp');
      dbpChartSpots = _convertToChartSpots(bloodPressure, 'dbp');

      meanBloodPressureChartSpots =
          _convertToChartSpots(bloodPressure, 'meanBloodPressure');
    }
  }

  double _parseToDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.parse(value);
    } else {
      return 0.0;
    }
  }

  /// Helper function to convert data list to chart spots
  List<Map<String, dynamic>> _convertToChartSpots(
    List<dynamic> dataList,
    String valueKey,
  ) {
    return dataList.asMap().entries.map((entry) {
      final index = entry.key.toDouble(); // x-axis = index
      final value = _parseToDouble(entry.value[valueKey]); // y-axis = value
      return {
        "x": index,
        "y": value,
        "date": entry.value['date'],
      };
    }).toList();
  }

  /// Helper function to calculate average of a specific key from data list
  double _calculateAverage(List<dynamic> dataList, String valueKey) {
    if (dataList.isEmpty) return 0.0;

    double sum = 0.0;
    for (var item in dataList) {
      sum += _parseToDouble(item[valueKey]);
    }

    return sum / dataList.length;
  }

  Color getBloodPressureColor(double sbp, double dbp) {
    // Red condition
    if (sbp >= 160 || dbp <= 50) {
      return Colors.red;
    }

    // Yellow condition
    if ((sbp >= 140 && sbp <= 159) || (dbp > 50 && dbp <= 60)) {
      return Colors.yellow;
    }

    // Green (normal)
    return Colors.green;
  }
}
