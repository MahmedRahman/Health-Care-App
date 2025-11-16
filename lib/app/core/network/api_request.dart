import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/web_services/web_services.dart';
import 'package:intl/intl.dart';

import 'web_services/http_helper.dart';

export 'web_services/api_extension.dart';

class ApiRequest {
  static final ApiRequest _instance = ApiRequest._internal();

  factory ApiRequest() {
    return _instance;
  }

  ApiRequest._internal();

  // API Instances
  WebServices webServices = WebServices();

  var baseUrl = "http://159.198.36.67:8080"; // Localhost for Android Emulator

//API End Point

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/login",
      method: HttpMethod.POST,
      requiresAuth: false,
      body: {
        "emailAddress": "$email",
        "password": "$password",
      },
    );
  }

  Future<Response> logout() async {
    return await webServices.execute(
      endpoint: "$baseUrl/logout/user",
      method: HttpMethod.POST,
      requiresAuth: true,
    );
  }

  Future<Response> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String hospitalId,
    required String password,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/register",
      method: HttpMethod.POST,
      requiresAuth: false,
      body: {
        "firstName": "$firstName",
        "lastName": "$lastName",
        "emailAddress": "$email",
        "hospitalId": "$hospitalId",
        "telephoneNumber": "$phone",
        "password": "$password",
      },
    );
  }

  Future<Response> getPatientInfo() async {
    return await webServices.execute(
      endpoint: "$baseUrl/get/user/profile",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> sendOTP({
    required String email,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/send/edit/password/otp?email=$email",
      method: HttpMethod.POST,
      requiresAuth: false,
    );
  }

  Future<Response> verifyOTP({
    required String email,
    required String otp,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/verify/mail/otp",
      method: HttpMethod.POST,
      requiresAuth: false,
      body: {
        "otp": "$otp",
        "email": "$email",
      },
    );
  }

  Future<Response> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/edit/password",
      method: HttpMethod.PUT,
      requiresAuth: false,
      body: {
        "email": "$email",
        "password": "$newPassword",
      },
    );
  }

  Future<Response> getUserProfile() async {
    return await webServices.execute(
      endpoint: "$baseUrl/get/user/profile",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> getDiagnosePrimary() async {
    return await webServices.execute(
      endpoint: "$baseUrl/primary/diagnose/list",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> getDiagnoseSecondary() async {
    return await webServices.execute(
      endpoint: "$baseUrl/secondary/diagnose/list",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> getDiagnoseTeritary() async {
    return await webServices.execute(
      endpoint: "$baseUrl/teritary/list",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> getTeamList() async {
    return await webServices.execute(
      endpoint: "$baseUrl/physician/team/list",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> getNurseNamesList() async {
    return await webServices.execute(
      endpoint: "$baseUrl/nurse/names/list",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> updateProfile({
    required id,
    profImg,
    firstName,
    lastName,
    hospitalId,
    country,
    city,
    address,
    gender,
    dob,
    age,
    race,
    weight,
    height,
    bsa,
    bmi,
    maritalStatus,
    language,
    nameOfKin,
    clinicName,
    diagnosesPrimary,
    diagnosesSecondary,
    teritiaryList,
    nurseNames,
    physicianTeam,
    nationalId,
    idCard,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/update/$id/profile",
      method: HttpMethod.PUT,
      requiresAuth: true,
      body: {
        "profImg": "$profImg",
        "firstName": "$firstName",
        "lastName": "$lastName",
        // "verified": false,
        // "emailVerified": false,
        "hospitalId": "$hospitalId",
        //"emailAddress": "atpfreelancer2020@gmail.com",
        //"telephoneNumber": null,
        "country": "$country",
        "city": "$city",
        "address": "$address",
        "nationalId": "$nationalId",
        "idCard": "$idCard",

        // "street": null,
        // "area": null,
        //"skinColor": null,

        "dateOfBirth": "$dob",
        "race": "$race",
        "gender": "$gender",
        "age": "$age",

        "weight": "$weight",
        "height": "$height",
        "bsa": "$bsa",
        "bmi": "$bmi",

        "maritalStatus": "$maritalStatus",
        "language": "$language",

        "nameOfKin": "$nameOfKin",
        "clinicName": "$clinicName",

        "diagnosesPrimary": diagnosesPrimary,
        "diagnosesSecondary": diagnosesSecondary,
        "teritiaryList": teritiaryList,

        "nurseNames": nurseNames,
        "physicianTeam": physicianTeam,

        "bloodPressure": [],
        "bloodRate": [],
        "oxygenSaturation": [],
        "weightUser": [],
        "bloodSugarRandom": [],
        "fluidBalance": []
      },
    );
  }

// Medicine
  Future<Response> getMedicineNamesList() async {
    return await webServices.execute(
      endpoint: "$baseUrl/get/medicine/saved",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> addMedicine({
    required String medicineName,
    required String medicineImage,
    required String dose,
    required String doseForm,
    required String doseRoute,
    required String doseFrequency,
    required String doseDuration,
    required String doseDurationList,
    required List<String> doseTimeList,
    required String specialInstructions,
    required String description,
    required String doctorName,
    required String startFrom,
    required String renewalDate,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/add/medicine",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "medicineName": "$medicineName",
        "medicineImage": "$medicineImage",
        "dose": "$dose",
        "doseForm": "$doseForm",
        "doseRoute": "$doseRoute",
        "doseFrequency": "$doseFrequency", //weekly/monthly/daily
        "doseDuration": "$doseDuration",
        "doseDurationList": "$doseDurationList", // days/weeks/months
        "doseTimeList": doseTimeList,
        "specialInstructions": "$specialInstructions",
        "description": "$description",
        "doctorName": "$doctorName",
        "startFrom": "$startFrom",
        "renewalDate": "$renewalDate",
      },
    );
  }

  Future<Response> getMedicines() async {
    return await webServices.execute(
      endpoint: "$baseUrl/get/medicine/list",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> getMedicinesDetailes(id) async {
    return await webServices.execute(
      endpoint: "$baseUrl/medicine/details/${id}",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> checkDone({
    required String medicineId,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/check/done/$medicineId",
      method: HttpMethod.PUT,
      requiresAuth: true,
    );
  }

  Future<Response> renewMedicine({
    required String medicineId,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/renew/medicine/$medicineId",
      method: HttpMethod.POST,
      requiresAuth: true,
    );
  }

  Future<Response> deleteMedicine({
    required String medicineId,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/remove/medicine/$medicineId",
      method: HttpMethod.DELETE,
      requiresAuth: true,
    );
  }

// Images

  Future<Response> getImages() async {
    return await webServices.execute(
      endpoint: "$baseUrl/get/images",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> addImage({
    required List<String> images,
    required String folderName,
  }) async {
    return await webServices.execute(
        endpoint: "$baseUrl/add/images",
        method: HttpMethod.POST,
        requiresAuth: true,
        body: {
          "images": images,
          "folderName": folderName,
        });
  }

  Future<Response> getLabs() async {
    return await webServices.execute(
      endpoint: "$baseUrl/labs/reports",
      method: HttpMethod.GET,
      requiresAuth: true,
    );
  }

  Future<Response> deleteImage({
    required String imageId,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/delete/image/$imageId",
      method: HttpMethod.DELETE,
      requiresAuth: true,
    );
  }

  //filterImages
  Future<Response> filterImages({
    required String? dateFrom,
    required String? dateTo,
    required String? xrayType,
    required String? ordering,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/filter/images",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "dateFrom": dateFrom, //format in mm-DD-yyyy
        "dateTo": dateTo,
        "xrayType": xrayType,
        "ordering": ordering,
      },
    );
  }

  Future<Response> addLabReport({
    required String labName,
    required List<String> images,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/add/lab/report",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "labType": labName,
        "report": images,
      },
    );
  }

// curl --location --request DELETE '159.198.36.67:8080/delete/lab/report/4' \
// --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZXN0MTBAZ21haWwuY29tIiwiaWF0IjoxNzYwMzU2ODkxLCJleHAiOjE4NjgzNTY4OTF9.C3ORT3P87Mc2vgC4J8XM8JsBEow28rbqZarDnoY4AT0'

  Future<Response> deleteLabReport({
    required String labId,
  }) async {
    return await webServices.execute(
      endpoint: "$baseUrl/delete/lab/report/$labId",
      method: HttpMethod.DELETE,
      requiresAuth: true,
    );
  }

  Future<Response> addBloodPressure({
    required double sbp,
    required double dbp,
    required double heartRate,
    required String symptoms,
    required double meanBloodPressure,
    required String date,
    required String time,
  }) async {
    final formattedDate = "${date}T${time}";

    return await webServices.execute(
      endpoint: "$baseUrl/add/blood/pressure",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "sbp": sbp,
        "dbp": dbp,
        "heartRate": heartRate,
        "symtopms": symptoms, // Fixed typo: symtopms -> symptoms
        "meanBloodPressure": meanBloodPressure, // Added missing field
        "date": formattedDate,
        "time": formattedDate,
      },
    );
  }

  Future<Response> addBloodRate({
    required String heartRate,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    final formattedDate = "${date}T${time}";
    return await webServices.execute(
      endpoint: "$baseUrl/add/blood/rate",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "heartRate": heartRate,
        "symtopms": symptoms,
        "date": formattedDate,
        "time": formattedDate,
      },
    );
  }

  Future<Response> addOxygenSaturation({
    required double oxygenSaturation,
    required String oxygenDeliveryMethod,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    final formattedDate = "${date}T${time}";
    return await webServices.execute(
      endpoint: "$baseUrl/add/oxygen/saturation",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "oxygenSaturation": oxygenSaturation,
        "oxygenDeliveryMethod": oxygenDeliveryMethod,
        "symtopms": symptoms,
        "date": formattedDate,
        "time": formattedDate,
      },
    );
  }

  Future<Response> addWeight({
    required double weight,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    final formattedDate = "${date}T${time}";
    return await webServices.execute(
      endpoint: "$baseUrl/add/weight",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "weight": weight,
        "symtopms": symptoms,
        "date": formattedDate,
        "time": formattedDate,
      },
    );
  }

  Future<Response> addRandomBloodSugar({
    required String insulineDose,
    required String bloodSugarRandom,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    final formattedDate = "${date}T${time}";
    return await webServices.execute(
      endpoint: "$baseUrl/add/random/blood-sugar",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "insulineDose": insulineDose,
        "bloodSugarRandom": bloodSugarRandom,
        "symtopms": symptoms,
        "date": formattedDate,
        "time": formattedDate,
      },
    );
  }

  Future<Response> addFluidBalance({
    required double fluidIn,
    required double fluidOut,
    required double netBalance,
    required String symptoms,
    required String date,
    required String time,
  }) async {
    final formattedDate = "${date}T${time}";
    return await webServices.execute(
      endpoint: "$baseUrl/add/fluid/balance",
      method: HttpMethod.POST,
      requiresAuth: true,
      body: {
        "fluidIn": fluidIn,
        "fluidOut": fluidOut,
        "netBalance": netBalance,
        "symtopms": symptoms,
        "date": formattedDate,
        "time": formattedDate,
      },
    );
  }
}
