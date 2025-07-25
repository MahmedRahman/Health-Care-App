import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineAddController extends GetxController {
  //TODO: Implement MedicineAddController

  final formKey = GlobalKey<FormState>();

  final doctorNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final specialInstructionController = TextEditingController();
  final renewalDateController = TextEditingController();
  final startDateController = TextEditingController();

  final selectedMedicineName = ''.obs;
  final medicineNames = ['Medicine 1', 'Medicine 2', 'Medicine 3'].obs;

  final selectedDose = ''.obs;
  final doseNames = ['Dose 1', 'Dose 2', 'Dose 3'].obs;

  final selectedForm = ''.obs;
  final formNames = ['Form 1', 'Form 2', 'Form 3'].obs;

  final selectedRoute = ''.obs;
  final routeNames = ['Route 1', 'Route 2', 'Route 3'].obs;

  final selectedFrequency = ''.obs;
  final frequencyNames = ['Frequency 1', 'Frequency 2', 'Frequency 3'].obs;

  final selectedDuration = ''.obs;
  final durationNames = ['Duration 1', 'Duration 2', 'Duration 3'].obs;
}
