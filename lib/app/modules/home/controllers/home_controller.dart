import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/service/version_service.dart';
import 'package:intl/intl.dart';

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

// Heart Rate
  RxString avgHeartRate = '0'.obs;
  List<dynamic> heartRate = [];
  List<Map<String, dynamic>> heartRateChartSpots = [];
  Rx<Color> heartRateColor = Colors.green.obs;
  Future<void> getHeartRate() async {
    heartRate = Get.find<VersionService>().bloodRate;

    if (heartRate.isNotEmpty) {
      // حساب المتوسطات
      avgHeartRate.value =
          _calculateAverage(heartRate, 'heartRate').toStringAsFixed(0);

      heartRateChartSpots = _convertToChartSpots(heartRate, 'heartRate');

      heartRateColor.value =
          getHeartRateColor(double.parse(avgHeartRate.value));
    }
    update();
  }

  Color getHeartRateColor(double heartRate) {
    if (heartRate >= 100) {
      return Colors.red;
    }
    return Colors.green;
  }

// Weight

  RxString avgWeight = '0'.obs;
  List<dynamic> weight = [];
  RxList<Map<String, dynamic>> weightChartSpots = RxList.empty();
  Rx<Color> weightColor = Colors.green.obs;
  Future<void> getWeight() async {
    weight = Get.find<VersionService>().WeightListData;

    if (weight.isNotEmpty) {
      // حساب المتوسطات
      avgWeight.value = _calculateAverage(weight, 'bmi').toStringAsFixed(0);
      weightChartSpots.value = _convertToChartSpots(weight, 'bmi');
      weightColor.value = getWeightColor(double.parse(avgWeight.value));
    }
  }

  Color getWeightColor(double weight) {
    if (weight >= 25) {
      return Colors.red;
    }
    return Colors.green;
  }

// Blood Pressure
  RxString avgSBP = '0'.obs;
  RxString avgDBP = '0'.obs;
  Rx<Color> bloodPressureColor = Colors.green.obs;
  List<Map<String, dynamic>> sbpChartSpots = [];
  List<Map<String, dynamic>> dbpChartSpots = [];
  List<Map<String, dynamic>> meanBloodPressureChartSpots = [];
  List<dynamic> bloodPressure = [];
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

// Oxygen Saturation

  List<dynamic> oxygenSaturationListData = [];
  RxString avgOxygenSaturation = '0'.obs;
  List<Map<String, dynamic>> oxygenSaturationChartSpots = [];
  Rx<Color> oxygenSaturationColor = Colors.green.obs;
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

      oxygenSaturationColor.value =
          getOxygenSaturationColor(double.parse(avgOxygenSaturation.value));
    }
  }

  Color getOxygenSaturationColor(double oxygenSaturation) {
    if (oxygenSaturation >= 95) {
      return Colors.red;
    }
    return Colors.green;
  }

// Blood Sugar
  List<dynamic> bloodSugar = [];
  RxString avgBloodSugar = '0'.obs;
  List<Map<String, dynamic>> bloodSugarChartSpots = [];
  Rx<Color> bloodSugarColor = Colors.green.obs;
  Future<void> getBloodSugar() async {
    bloodSugar = Get.find<VersionService>().bloodSugar;
    if (bloodSugar.isNotEmpty) {
      avgBloodSugar.value =
          _calculateAverage(bloodSugar, 'randomBloodSugar').toStringAsFixed(0);
      bloodSugarChartSpots =
          _convertToChartSpots(bloodSugar, 'randomBloodSugar');
      bloodSugarColor.value =
          getBloodSugarColor(double.parse(avgBloodSugar.value));
    }
  }

  Color getBloodSugarColor(double bloodSugar) {
    if (bloodSugar >= 100) {
      return Colors.red;
    }
    return Colors.green;
  }

// Fluid Balance

  List<dynamic> fluidBalanceListData = [];
  RxString avgFluidBalance = '0'.obs;
  List<Map<String, dynamic>> fluidBalanceChartSpots = [];
  Rx<Color> fluidBalanceColor = Colors.green.obs;
  Future<void> getFluidBalance() async {
    fluidBalanceListData = Get.find<VersionService>().fluidBalance;
    if (fluidBalanceListData.isNotEmpty) {
      avgFluidBalance.value =
          _calculateAverage(fluidBalanceListData, 'netBalance')
              .toStringAsFixed(0);
      fluidBalanceChartSpots =
          _convertToChartSpots(fluidBalanceListData, 'netBalance');
      fluidBalanceColor.value =
          getFluidBalanceColor(double.parse(avgFluidBalance.value));
    }
  }

  Color getFluidBalanceColor(double fluidBalance) {
    if (fluidBalance >= 100) {
      return Colors.red;
    }
    return Colors.green;
  }

  DateTime _safeParseDate(dynamic raw) {
    if (raw is DateTime) return raw;
    final s = raw?.toString()?.trim();
    if (s == null || s.isEmpty) {
      throw const FormatException('Empty date');
    }

    // جرّب ISO أولًا
    try {
      return DateTime.parse(s);
    } catch (_) {}

    // جرّب dd/MM/yyyy بدقّة
    try {
      return DateFormat('dd/MM/yyyy').parseStrict(s);
    } catch (_) {}

    // صيغ إضافية (اختياري)
    for (final f in ['d/M/yyyy', 'MM/dd/yyyy', 'yyyy-MM-dd']) {
      try {
        return DateFormat(f).parseStrict(s);
      } catch (_) {}
    }

    throw FormatException('Unsupported date format: $s');
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

      final dt = _safeParseDate(entry.value['date']); // <= هنا التغيير

      return {
        "x": index,
        "y": value,
        "date": DateFormat('EEE').format(dt), // اليوم فقط (01..31)
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
}
