import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/medications/component/filter_item.dart';
import 'package:health_care_app/app/modules/medications/component/medicine_card.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

import '../controllers/medications_controller.dart';

class MedicationsView extends GetView<MedicationsController> {
  const MedicationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsMedications.grey,
      appBar: AppBar(
        title: const Text('Medications'),
        actions: [
          CircleAvatar(
            backgroundColor: AppColorsMedications.white,
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: AppColorsMedications.black,
              ),
              onPressed: () {
                Get.toNamed(Routes.MEDICINE_ADD);
              },
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
        centerTitle: false,
        backgroundColor: AppColorsMedications.primary,
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
      }),
    );
  }
}
