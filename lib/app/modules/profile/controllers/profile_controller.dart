import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/network/api_request.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';

import 'dart:math' as Math;

class ProfileController extends GetxController with StateMixin {
  // Text controllers

  final List<String> countries = [
    "UAE",
    "KSA",
    "Qatar",
    "Kuwait",
    "Egypt",
    "Bahrain",
    "Oman",
    "Jordan",
    "Lebanon",
    "Iraq",
    "Syria",
    "Palestine",
    "Sudan",
    "Morocco",
    "Algeria",
    "Tunisia",
    "Libya",
    "Yemen"
  ];

  final profImg = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['profImg'] ?? '',
  );

  final firstName = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['firstName'] ?? '',
  );
  final lastName = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['lastName'] ?? '',
  );
  final phone = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['telephoneNumber'] ?? '',
  );
  final email = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['emailAddress'] ?? '',
  );
  final hospitalId = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['hospitalId'] ?? '',
  ); // ID

  final address1 = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['address'] ?? '',
  );

  final age = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['age']?.toString() ?? '0',
  );
  final race = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['race']?.toString() ?? '',
  );
  final weight = TextEditingController(
    text:
        Get.find<AuthService>().currentUser.value!['weight']?.toString() ?? '0',
  ); // Kg
  final height = TextEditingController(
    text:
        Get.find<AuthService>().currentUser.value!['height']?.toString() ?? '0',
  ); // Cm
  final bsa = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['bsa']?.toString() ?? '0',
  ); // m2
  final bmi = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['bmi']?.toString() ?? '0',
  ); // kg/m2

  // Dropdowns / pickers
  final country = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['country'] ?? 'UAE',
  );
  final city = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['city'] ?? 'City 1',
  );

  final gender = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['gender'] ?? 'Male',
  );
  final marital = TextEditingController(
    text:
        Get.find<AuthService>().currentUser.value!['maritalStatus'] ?? 'Single',
  );
  final language = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['language'] ?? 'English',
  );

  final dob = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['dateOfBirth'] ?? '',
  );

  final nextofKin = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['nameOfKin']?.toString() ??
        '',
  );

  final clinicName = TextEditingController(
    text:
        Get.find<AuthService>().currentUser.value!['clinicName']?.toString() ??
            '',
  );

  final nationalId = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['nationalId'] ?? '',
  );

  final idCard = TextEditingController(
    text: Get.find<AuthService>().currentUser.value!['idCard'] ?? '',
  );

  final physicianTeam = TextEditingController(
    text: Get.find<AuthService>().currentUser.value?['physicianTeam']
            ?["name"] ??
        '',
  );

  final nurseNames = TextEditingController(
    text:
        Get.find<AuthService>().currentUser.value?['nurseNames']?["name"] ?? '',
  );

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await getDiagnosePrimary();
    await getDiagnoseSecondary();
    await getDiagnoseTertiary();

    await getPresonalTeam();
    await getNurse();
    change(null, status: RxStatus.success());
  }

  RxList<String> DiagnosePrimaryListNames = RxList.empty();
  List<String> selectDiagnosePrimaryListNames = (Get.find<AuthService>()
              .currentUser
              .value?['diagnosesPrimary'] as List<dynamic>? ??
          [])
      .map((item) => item['name']?.toString() ?? '')
      .toList();

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

  List<String> SelectDiagnoseSecondaryListNames = (Get.find<AuthService>()
              .currentUser
              .value?['secondryUser'] as List<dynamic>? ??
          [])
      .map((item) => item['name']?.toString() ?? '')
      .toList();

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

  List<String> SelectDiagnoseTertiaryListNames = (Get.find<AuthService>()
              .currentUser
              .value?['teritiaryList'] as List<dynamic>? ??
          [])
      .map((item) => item['name']?.toString() ?? '')
      .toList();

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

  Future updateProfile() async {
    change(null, status: RxStatus.loading());
    try {
      Response response = await ApiRequest().updateProfile(
        id: Get.find<AuthService>().currentUser.value!['id'],
        profImg: profImg.text,
        firstName: firstName.text,
        lastName: lastName.text,
        hospitalId: hospitalId.text,
        country: country.text,
        city: city.text,
        address: address1.text,
        gender: gender.text,
        age: age.text,
        race: race.text,
        weight: weight.text,
        height: height.text,
        bsa: bsa.text,
        bmi: bmi.text,
        maritalStatus: marital.text,
        language: language.text,
        nameOfKin: nextofKin.text,
        clinicName: clinicName.text,
        diagnosesPrimary: selectDiagnosePrimaryListNames,
        diagnosesSecondary: SelectDiagnoseSecondaryListNames,
        teritiaryList: SelectDiagnoseTertiaryListNames,
        nurseNames: nurseNames.text,
        physicianTeam: physicianTeam.text,
        nationalId: nationalId.text,
        idCard: idCard.text,
        dob: dob.text,
      );

      //Get.find<AuthService>().currentUser.value = response.body;

      Get.find<AuthService>().getUserProfile();

      Notifier.of.success("Update Done");
    } catch (e) {
      Notifier.of.error(
        '{$e}',
        title: 'erro',
      );
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  List<String> extractNames(List<dynamic> data) {
    return data
        .map<String>((item) => item['name']?.toString() ?? '')
        .where((name) => name.isNotEmpty) // يتأكد إنها مش فاضية
        .toList();
  }

  double calculateBMI(double weightKg, double heightCm) {
    double heightM = heightCm / 100; // تحويل الطول لمتر
    double bmi = weightKg / (heightM * heightM);
    return bmi;
  }

  double calculateBSA(double weightKg, double heightCm) {
    return Math.sqrt((weightKg * heightCm) / 3600);
  }

  void calculateBMIAndBSA() {
    final weightValue = double.tryParse(weight.text);
    final heightValue = double.tryParse(height.text);

    if (weightValue != null &&
        heightValue != null &&
        weightValue > 0 &&
        heightValue > 0) {
      // ✅ حساب BMI
      bmi.text = calculateBMI(weightValue, heightValue).toStringAsFixed(2);

      // ✅ حساب BSA
      bsa.text = calculateBSA(weightValue, heightValue).toStringAsFixed(2);
    } else {
      // ⚠️ مدخلات غير صالحة
      bmi.text = "0.0";
      bsa.text = "0.0";
    }
  }
}


// final List<String> countries = [
//   "Afghanistan",
//   "Albania",
//   "Algeria",
//   "Andorra",
//   "Angola",
//   "Antigua and Barbuda",
//   "Argentina",
//   "Armenia",
//   "Australia",
//   "Austria",
//   "Azerbaijan",
//   "Bahamas",
//   "Bahrain",
//   "Bangladesh",
//   "Barbados",
//   "Belarus",
//   "Belgium",
//   "Belize",
//   "Benin",
//   "Bhutan",
//   "Bolivia",
//   "Bosnia and Herzegovina",
//   "Botswana",
//   "Brazil",
//   "Brunei",
//   "Bulgaria",
//   "Burkina Faso",
//   "Burundi",
//   "Cabo Verde",
//   "Cambodia",
//   "Cameroon",
//   "Canada",
//   "Central African Republic",
//   "Chad",
//   "Chile",
//   "China",
//   "Colombia",
//   "Comoros",
//   "Congo (Congo-Brazzaville)",
//   "Costa Rica",
//   "Croatia",
//   "Cuba",
//   "Cyprus",
//   "Czechia (Czech Republic)",
//   "Democratic Republic of the Congo",
//   "Denmark",
//   "Djibouti",
//   "Dominica",
//   "Dominican Republic",
//   "Ecuador",
//   "Egypt",
//   "El Salvador",
//   "Equatorial Guinea",
//   "Eritrea",
//   "Estonia",
//   "Eswatini",
//   "Ethiopia",
//   "Fiji",
//   "Finland",
//   "France",
//   "Gabon",
//   "Gambia",
//   "Georgia",
//   "Germany",
//   "Ghana",
//   "Greece",
//   "Grenada",
//   "Guatemala",
//   "Guinea",
//   "Guinea-Bissau",
//   "Guyana",
//   "Haiti",
//   "Honduras",
//   "Hungary",
//   "Iceland",
//   "India",
//   "Indonesia",
//   "Iran",
//   "Iraq",
//   "Ireland",
//   "Israel",
//   "Italy",
//   "Jamaica",
//   "Japan",
//   "Jordan",
//   "Kazakhstan",
//   "Kenya",
//   "Kiribati",
//   "Kuwait",
//   "Kyrgyzstan",
//   "Laos",
//   "Latvia",
//   "Lebanon",
//   "Lesotho",
//   "Liberia",
//   "Libya",
//   "Liechtenstein",
//   "Lithuania",
//   "Luxembourg",
//   "Madagascar",
//   "Malawi",
//   "Malaysia",
//   "Maldives",
//   "Mali",
//   "Malta",
//   "Marshall Islands",
//   "Mauritania",
//   "Mauritius",
//   "Mexico",
//   "Micronesia",
//   "Moldova",
//   "Monaco",
//   "Mongolia",
//   "Montenegro",
//   "Morocco",
//   "Mozambique",
//   "Myanmar (Burma)",
//   "Namibia",
//   "Nauru",
//   "Nepal",
//   "Netherlands",
//   "New Zealand",
//   "Nicaragua",
//   "Niger",
//   "Nigeria",
//   "North Korea",
//   "North Macedonia",
//   "Norway",
//   "Oman",
//   "Pakistan",
//   "Palau",
//   "Palestine State",
//   "Panama",
//   "Papua New Guinea",
//   "Paraguay",
//   "Peru",
//   "Philippines",
//   "Poland",
//   "Portugal",
//   "Qatar",
//   "Romania",
//   "Russia",
//   "Rwanda",
//   "Saint Kitts and Nevis",
//   "Saint Lucia",
//   "Saint Vincent and the Grenadines",
//   "Samoa",
//   "San Marino",
//   "Sao Tome and Principe",
//   "Saudi Arabia",
//   "Senegal",
//   "Serbia",
//   "Seychelles",
//   "Sierra Leone",
//   "Singapore",
//   "Slovakia",
//   "Slovenia",
//   "Solomon Islands",
//   "Somalia",
//   "South Africa",
//   "South Korea",
//   "South Sudan",
//   "Spain",
//   "Sri Lanka",
//   "Sudan",
//   "Suriname",
//   "Sweden",
//   "Switzerland",
//   "Syria",
//   "Taiwan",
//   "Tajikistan",
//   "Tanzania",
//   "Thailand",
//   "Timor-Leste",
//   "Togo",
//   "Tonga",
//   "Trinidad and Tobago",
//   "Tunisia",
//   "Turkey",
//   "Turkmenistan",
//   "Tuvalu",
//   "Uganda",
//   "Ukraine",
//   "United Arab Emirates",
//   "United Kingdom",
//   "United States",
//   "Uruguay",
//   "Uzbekistan",
//   "Vanuatu",
//   "Vatican City",
//   "Venezuela",
//   "Vietnam",
//   "Yemen",
//   "Zambia",
//   "Zimbabwe",
// ];