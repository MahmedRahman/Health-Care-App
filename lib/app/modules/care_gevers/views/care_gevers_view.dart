import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/care_gevers_controller.dart';

class CareGeversView extends GetView<CareGeversController> {
  const CareGeversView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CareGeversView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CareGeversView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
