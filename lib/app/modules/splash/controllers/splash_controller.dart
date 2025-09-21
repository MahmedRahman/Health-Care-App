import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  late VideoPlayerController videoController;

  @override
  void onInit() async {
    super.onInit();
    videoController = VideoPlayerController.asset("assets/videos/Comp_1_5.mp4")
      ..initialize().then((_) {
        videoController.play();
        update();
      })
      ..setLooping(false);

    videoController.addListener(() {
      if (videoController.value.position == videoController.value.duration) {
        if (Get.find<AuthService>().isLoggedIn) {
          // await Get.putAsync<InitialDataService>(
          //     () async => await InitialDataService().init());
          if (Get.find<AuthService>().isFirstLogin) {
            Get.offAndToNamed(Routes.HOME);
            return;
          } else {
            Get.offAllNamed('/onboarding');
            return;
          }
        } else {
          Get.offAndToNamed(Routes.SIGN_IN);
          return;
        }
      }
    });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
