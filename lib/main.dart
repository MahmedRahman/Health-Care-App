import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_care_app/app/core/auth_service.dart';
import 'package:health_care_app/app/core/service/lookup_service.dart';
import 'package:health_care_app/app/core/service/ver.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';
import 'package:health_care_app/app/modules/home/controllers/home_controller.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/filter_controller.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/upload_controller.dart';
import 'package:health_care_app/app/services/notification_channel_service.dart';
import 'package:health_care_app/app/services/notification_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Get.put(AuthService());

  Get.lazyPut<LookupService>(() => LookupService());
  Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  Get.lazyPut<VersionService>(() => VersionService(), fenix: true);

  Notifier.use(NotifierMode.awesome);

  // تهيئة خدمة الإشعارات
  final notificationService = NotificationService();
  await notificationService.initialize(
    channels: NotificationChannelService.defaultChannels,
    debug: true,
  );

  // إعداد listener للإشعارات
  notificationService.setNotificationListener(
    onActionReceived: (ReceivedAction action) async {
      debugPrint('Received action: ${action.payload}');
    },
  );

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const HeartCareApp(),
    ),
  );
}

class HeartCareApp extends StatelessWidget {
  const HeartCareApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Heart Care",
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          initialBinding: BindingsBuilder(
            () {
              Get.put(UploadController());
              Get.put(FilterController());
            },
          ),
          transitionDuration: const Duration(milliseconds: 0),
          getPages: AppPages.routes,
          theme: ThemeData(
            useMaterial3: false,
            fontFamily: 'Poppins',
            primaryColor: const Color(0xFF06283D), // example custom color
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF06283D),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
