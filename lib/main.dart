import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';

import 'app/routes/app_pages.dart';
//use   device_preview: ^1.3.1

void main() {
  runApp(
    DevicePreview(
      builder: (context) => const HeartCareApp(),
    ),
  );
  // تغيير لون الستاتس بار
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary, // ← اللون اللي تريده
      statusBarIconBrightness:
          Brightness.light, // ← لون الأيقونات (light or dark)
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
            // Add MediaQuery fix for text scaling if needed
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        );
      },
    );
  }
}
