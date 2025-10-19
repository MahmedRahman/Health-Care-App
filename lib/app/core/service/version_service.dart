import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:intl/intl.dart';

class VersionService extends GetxService {
  List<dynamic> bloodPressure = [];
  List<dynamic> bloodRate = [];

  List<dynamic> oxygenSaturationListData = [];
  List<dynamic> WeightListData = [];

  List<dynamic> bloodSugar = [];
  List<dynamic> fluidBalance = [];

  Future<void> LoadVersionsData() async {
    bloodPressure =
        Get.find<AuthService>().currentUser.value?['bloodPressure'] ?? [];
    bloodRate = Get.find<AuthService>().currentUser.value?['bloodRate'] ?? [];
    oxygenSaturationListData =
        Get.find<AuthService>().currentUser.value?['oxygenSaturation'] ?? [];
    WeightListData =
        Get.find<AuthService>().currentUser.value?['weightUser'] ?? [];
    bloodSugar =
        Get.find<AuthService>().currentUser.value?['bloodSugarRandom'] ?? [];
    fluidBalance =
        Get.find<AuthService>().currentUser.value?['fluidBalance'] ?? [];
  }

  void addBloodPressure({
    required String startDate,
    required String time,
    required double systolic,
    required double diastolic,
    required double map,
    required double heartRate,
    required String symptoms,
  }) async {
    bloodPressure.add({
      "date": startDate, //LocalDateTime Object
      "time": time, //LocalDateTime Object
      "sbp": systolic,
      "dbp": diastolic,
      "meanBloodPressure": map,
      "heartRate": heartRate,
      "symtopms": symptoms, //if other is choosed will send "symtopmText"
    });
    try {
      var response = await ApiRequest().addBloodPressure(
        date: convertDate(startDate),
        time: convertTime(time),
        sbp: double.parse(systolic.toString()),
        dbp: double.parse(diastolic.toString()),
        meanBloodPressure: double.parse(map.toString()),
        heartRate: double.parse(heartRate.toString()),
        symptoms: symptoms,
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Blood Pressure added successfully!',
          'Blood Pressure Added',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed to add blood pressure!',
        'Blood Pressure Added ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void addHeartRateData({
    required String heartRate,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    bloodRate.add({
      "heartRate": heartRate,
      "symptoms": symptoms, //if other is choosed will send "symtopmText"
      "date": date,
      "time": time,
    });

    try {
      var response = await ApiRequest().addBloodRate(
        heartRate: heartRate,
        symptoms: symptoms,
        date: convertDate(date),
        time: convertTime(time),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Heart Rate added successfully!',
          'Heart Rate Added',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed to add heart rate!',
        'Heart Rate Added ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void addOxygenSaturationData({
    required String oxygenSaturation,
    required String oxygenDeliveryMethod,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    oxygenSaturationListData.add({
      "oxygenSaturation": oxygenSaturation,
      "oxygenDeliveryMethod": oxygenDeliveryMethod,
      "symptoms": symptoms,
      "date": date,
      "time": time,
    });
    try {
      var response = await ApiRequest().addOxygenSaturation(
        date: convertDate(date),
        time: convertTime(time),
        oxygenSaturation: double.parse(oxygenSaturation),
        oxygenDeliveryMethod: oxygenDeliveryMethod,
        symptoms: symptoms,
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Oxygen Saturation added successfully!',
          'Oxygen Saturation Added',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed to add oxygen saturation!',
        'Oxygen Saturation Added ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void addWeightData({
    required double weightData,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    WeightListData.add(
      {
        "weight": weightData,
        "symptoms": symptoms,
        "date": date,
        "time": time,
      },
    );

    try {
      var response = await ApiRequest().addWeight(
        weight: weightData,
        symptoms: symptoms,
        date: convertDate(date),
        time: convertTime(time),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Weight added successfully!',
          'Weight Added',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed to add weight!',
        'Weight Added ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void addBloodSugarData({
    required String insulineDose,
    required String bloodSugarRandom,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    bloodSugar.add({
      "insulineDose": insulineDose,
      "bloodSugarRandom": bloodSugarRandom,
      "symptoms": symptoms,
      "date": date,
      "time": time,
    });
    try {
      var response = await ApiRequest().addRandomBloodSugar(
        insulineDose: insulineDose,
        bloodSugarRandom: bloodSugarRandom,
        symptoms: symptoms,
        date: convertDate(date),
        time: convertTime(time),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'Blood Sugar added successfully!',
          'Blood Sugar Added',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed to add blood sugar!',
        'Blood Sugar Added ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void addFluidBalanceData({
    required double fluidIn,
    required double fluidOut,
    required double netBalance,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    fluidBalance.add({
      "fluidIn": fluidIn,
      "fluidOut": fluidOut,
      "netBalance": netBalance,
      "symptoms": symptoms,
      "date": date,
      "time": time,
    });
    try {
      var response = await ApiRequest().addFluidBalance(
        fluidIn: fluidIn,
        fluidOut: fluidOut,
        netBalance: netBalance,
        symptoms: symptoms,
        date: convertDate(date),
        time: convertTime(time),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Fluid Balance added successfully!',
          'Fluid Balance Added',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Failed to add fluid balance!',
        'Fluid Balance Added ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String convertDate(String inputDate) {
    // أول حاجة: parse من الشكل اللي جاي (dd/MM/yyyy)
    final parsedDate = DateFormat("dd/MM/yyyy").parse(inputDate);

    // بعدين نعمل format للشكل اللي مطلوب (yyyy-MM-dd)
    final formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);

    return formattedDate;
  }

  String convertTime(String inputTime) {
    // parse من صيغة 12 ساعة مع AM/PM
    final parsedTime = DateFormat("hh:mm a").parse(inputTime);

    // format للصيغة النهائية اللي API محتاجها (24 ساعة)
    return DateFormat("HH:mm:ss").format(parsedTime);
  }
}
