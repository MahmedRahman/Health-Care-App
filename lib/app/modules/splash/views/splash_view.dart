import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xff2445CE),
          body: Center(
            child: controller.videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller.videoController.value.aspectRatio,
                    child: VideoPlayer(controller.videoController),
                  )
                : const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
