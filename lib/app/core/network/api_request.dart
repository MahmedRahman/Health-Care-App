import 'package:get/get.dart';
import 'package:health_care_app/app/core/network/web_services/web_services.dart';

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
        "phoneNumber": "$phone",
        "password": "$password",
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
}
