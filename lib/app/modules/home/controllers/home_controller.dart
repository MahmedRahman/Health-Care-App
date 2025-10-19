import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/service/version_service.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    Get.find<VersionService>().LoadVersionsData();
    await getBloodPressure();
    await getHeartRate();
    await getWeight();
    await getOxygenSaturation();
    await getBloodSugar();
    await getFluidBalance();
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

  RxString avgWeight = '0'.obs;
  List<dynamic> weight = [];

  RxList<Map<String, dynamic>> weightChartSpots = RxList.empty();

  Future<void> getHeartRate() async {
    heartRate = Get.find<VersionService>().bloodRate;

    if (heartRate.isNotEmpty) {
      // حساب المتوسطات
      avgHeartRate.value =
          _calculateAverage(heartRate, 'heartRate').toStringAsFixed(0);

      heartRateChartSpots = _convertToChartSpots(heartRate, 'heartRate');
    }
    update();
  }

  Future<void> getBloodPressure() async {
    bloodPressure = Get.find<VersionService>().bloodPressure;

    if (bloodPressure.isNotEmpty) {
      // حساب المتوسطات
      avgSBP.value = _calculateAverage(bloodPressure, 'sbp').toStringAsFixed(0);
      avgDBP.value = _calculateAverage(bloodPressure, 'dbp').toStringAsFixed(0);

      bloodPressureColor.value = getBloodPressureColor(
          double.parse(avgSBP.value), double.parse(avgDBP.value));

      sbpChartSpots = _convertToChartSpots(bloodPressure, 'sbp');
      dbpChartSpots = _convertToChartSpots(bloodPressure, 'dbp');

      meanBloodPressureChartSpots =
          _convertToChartSpots(bloodPressure, 'meanBloodPressure');
    }
  }

  double _parseToDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      // Remove any non-numeric characters except decimal point and minus sign
      String cleanedValue = value.replaceAll(RegExp(r'[^0-9.-]'), '');
      if (cleanedValue.isEmpty) {
        return 0.0;
      }
      try {
        return double.parse(cleanedValue);
      } catch (e) {
        return 0.0;
      }
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

  Future<void> getWeight() async {
    weight = Get.find<VersionService>().WeightListData;

    if (weight.isNotEmpty) {
      // حساب المتوسطات
      avgWeight.value = _calculateAverage(weight, 'bmi').toStringAsFixed(0);
      weightChartSpots.value = _convertToChartSpots(weight, 'bmi');
    }
  }

  List<dynamic> oxygenSaturationListData = [];
  RxString avgOxygenSaturation = '0'.obs;
  List<Map<String, dynamic>> oxygenSaturationChartSpots = [];
  Future<void> getOxygenSaturation() async {
    oxygenSaturationListData =
        Get.find<VersionService>().oxygenSaturationListData;

    for (var item in oxygenSaturationListData) {
      if (item['oxygenSaturation'] != null) {
        item['oxygenSaturation'] =
            item['oxygenSaturation'].toString().replaceAll('%', '');
      }
    }

    if (oxygenSaturationListData.isNotEmpty) {
      // حساب المتوسطات
      avgOxygenSaturation.value =
          _calculateAverage(oxygenSaturationListData, 'oxygenSaturation')
              .toStringAsFixed(0);
      oxygenSaturationChartSpots =
          _convertToChartSpots(oxygenSaturationListData, 'oxygenSaturation');
    }
  }

  List<dynamic> bloodSugar = [];
  RxString avgBloodSugar = '0'.obs;
  List<Map<String, dynamic>> bloodSugarChartSpots = [];
  Future<void> getBloodSugar() async {
    bloodSugar = Get.find<VersionService>().bloodSugar;
    if (bloodSugar.isNotEmpty) {
      avgBloodSugar.value =
          _calculateAverage(bloodSugar, 'randomBloodSugar').toStringAsFixed(0);
      bloodSugarChartSpots =
          _convertToChartSpots(bloodSugar, 'randomBloodSugar');
    }
  }

  List<dynamic> fluidBalanceListData = [];
  RxString avgFluidBalance = '0'.obs;
  List<Map<String, dynamic>> fluidBalanceChartSpots = [];
  Future<void> getFluidBalance() async {
    fluidBalanceListData = Get.find<VersionService>().fluidBalance;
    if (fluidBalanceListData.isNotEmpty) {
      avgFluidBalance.value =
          _calculateAverage(fluidBalanceListData, 'netBalance')
              .toStringAsFixed(0);
      fluidBalanceChartSpots =
          _convertToChartSpots(fluidBalanceListData, 'netBalance');
    }
  }
}
