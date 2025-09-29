import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/medications/component/filter_item.dart';
import 'package:health_care_app/app/modules/medications/component/medicine_card.dart';
import 'package:health_care_app/app/routes/app_pages.dart';
import 'package:health_care_app/app/widgets/app_button.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';

import '../controllers/medications_controller.dart';

class MedicationsView extends GetView<MedicationsController> {
  const MedicationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF60A5FA), // لون خلفية الـ Status Bar (أندرويد)
        statusBarIconBrightness: Brightness.light, // لون الأيقونات (أندرويد)
        statusBarBrightness: Brightness.dark, // لون الأيقونات في iOS (عكسي)
      ),
      child: Scaffold(
        backgroundColor: AppColorsMedications.grey,
        appBar: AppBar(
          backgroundColor: AppColorsMedications.primary, // الأزرق المتدرج
          elevation: 0,
          automaticallyImplyLeading: false,
          systemOverlayStyle:
              SystemUiOverlayStyle.light, // أيقونات بيضاء بالـ Status Bar

          title: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              const SizedBox(width: 4),
              const Text(
                'Medications',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: [
            // زر الإضافة
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.add, size: 20, color: Colors.black),
                onPressed: () {
                  Get.toNamed(Routes.MEDICINE_ADD);
                },
              ),
            ),
            SizedBox(width: 8.w),
            // زر الإشعارات مع مؤشر أحمر
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.dialog(
                    popItems(),
                    barrierDismissible: true,
                  );
                },
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
        body: controller.obx((data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(height: 16),
                      FilterItem(
                        title: "All",
                        count: 5,
                        isSelected: true,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      FilterItem(
                        title: "Morning",
                        count: 2,
                        isSelected: false,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      FilterItem(
                        title: "Evening",
                        count: 3,
                        isSelected: false,
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      FilterItem(
                        title: "Night",
                        count: 2,
                        isSelected: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(data!.length, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                          ),
                          child: MedicineCard(
                            medicineName: data[index].name,
                            dose: data[index].dose,
                            route: data[index].route,
                            description: data[index].description,
                            timings: data[index].timings,
                            tablets: data[index].tablets,
                            progress: data[index].progress,
                            daysLeft: data[index].daysLeft,
                            imagePath: data[index].imagePath,
                            onTap: () {
                              Get.toNamed(
                                Routes.MEDICINE_DETAILS,
                                arguments: data[index],
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          );
        },
            onLoading: const Center(
              child: CircularProgressIndicator(),
            ),
            onEmpty: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No medications found.',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppPrimaryButton(
                      text: "Add Medication",
                      backgroundColor: AppColorsMedications.primary,
                      borderRadius: 20,
                      onPressed: () {
                        Get.toNamed(Routes.MEDICINE_ADD);
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class popItems extends StatelessWidget {
  const popItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Image.asset(
                  "assets/images/2133f04783829b9f5a1daa9136c491ab2fe2c20f.png",
                  width: 128.w,
                  height: 128.h,
                ),
                Text(
                  "Medication Reminder",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "3:00 PM",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "It is the time for your blood \n thinner medicine",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xff8A97AA),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  "assets/images/Frame 2147208349.png",
                ),
                SizedBox(height: 8),
                Text(
                  "Panadol",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffD4582E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Each dose is a step toward recovery",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Color(0xff386DD8),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Make Sure to take it after food",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xff386DD8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  text: "Check Done",
                  backgroundColor: Color(0xff18A86B),
                  borderRadius: 50,
                  onPressed: () {},
                ),
                const SizedBox(height: 8),
                AppPrimaryButton(
                  text: "Remind me",
                  backgroundColor: Colors.transparent,
                  borderColor: Color(0xffCC9E14),
                  textColor: Color(0xffCC9E14),
                  borderRadius: 50,
                  onPressed: () {},
                ),
                const SizedBox(height: 8),
                AppPrimaryButton(
                  text: "Dismiss",
                  backgroundColor: Colors.transparent,
                  textColor: Colors.red.shade600,
                  borderRadius: 50,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
