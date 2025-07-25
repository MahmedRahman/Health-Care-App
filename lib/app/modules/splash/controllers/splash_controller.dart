import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;

  @override
  void onInit() {
    super.onInit();
    videoController = VideoPlayerController.asset("assets/videos/Comp_1_5.mp4")
      ..initialize().then((_) {
        videoController.play();
        update();
      })
      ..setLooping(false);

    videoController.addListener(() {
      if (videoController.value.position == videoController.value.duration) {
        // بعد انتهاء الفيديو
        Get.offAllNamed('/onboarding'); // غيّر المسار حسب شاشتك التالية
      }
    });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
