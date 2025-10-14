import 'package:get/get.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/service/lookup_service.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/services/notification_service.dart';
import 'package:health_care_app/app/services/notification_channel_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:video_player/video_player.dart';

class SplashController extends GetxController {
  VideoPlayerController? videoController;
  final NotificationService _notificationService = NotificationService();

  @override
  void onInit() async {
    super.onInit();

    // تهيئة الإشعارات وطلب الأذونات
    await _initializeNotifications();

    // تهيئة الفيديو
    videoController = VideoPlayerController.asset("assets/videos/Comp_1_5.mp4")
      ..initialize().then((_) {
        videoController?.play();
        update();
      })
      ..setLooping(false);

    videoController!.addListener(
      () {
        if (videoController!.value.position ==
            videoController!.value.duration) {
          if (Get.find<AuthService>().isLoggedIn) {
            Get.find<LookupService>().init();
            Get.offAndToNamed(Routes.HOME);
            return;
          }

          if (Get.find<AuthService>().isFirstLogin) {
            Get.offAndToNamed(Routes.ONBOARDING);
            return;
          }

          if (Get.find<AuthService>().isFirstLogin != true) {
            Get.offAndToNamed(Routes.SIGN_IN);
            return;
          }

          Get.offAndToNamed(Routes.ONBOARDING);
        }
      },
    );
  }

  /// تهيئة الإشعارات وطلب الأذونات
  Future<void> _initializeNotifications() async {
    try {
      // تهيئة خدمة الإشعارات
      await _notificationService.initialize(
        channels: NotificationChannelService.defaultChannels,
        debug: true,
      );

      // التحقق من إذن الإشعارات أولاً
      final isAllowed = await _notificationService.isNotificationAllowed();

      if (!isAllowed) {
        // طلب إذن الإشعارات فقط إذا لم يكن مسموحاً
        await _notificationService.requestPermissions(
          channelKey: 'medication_channel',
          permissions: [
            NotificationPermission.Alert,
            NotificationPermission.Sound,
            NotificationPermission.Badge,
            NotificationPermission.Vibration,
            NotificationPermission.Light,
            NotificationPermission.FullScreenIntent,
            NotificationPermission.CriticalAlert,
          ],
        );
        print('Notification permissions requested');
      } else {
        print('Notification permissions already granted');
      }

      // إعداد listener للإشعارات
      _notificationService.setNotificationListener(
        onActionReceived: (action) async {
          print('Notification action received: ${action.payload}');
          // يمكن إضافة منطق إضافي هنا للتعامل مع الإشعارات
        },
      );

      print('Notifications initialized successfully');
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  @override
  void onClose() {
    videoController?.dispose();
    super.onClose();
  }
}
