import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppointmentsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AppointmentsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
