import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/PatientInfo/views/patient_info_view.dart';
import 'package:health_care_app/app/widgets/app_date_field.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
import 'package:health_care_app/app/widgets/app_id_card.dart';
import 'package:health_care_app/app/widgets/app_image_picker_box.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  //String selectedCountry = "UAE";
  RxBool isPersonalInfo = true.obs;
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textLight.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:
            const Text('Profile', style: TextStyle(color: AppColors.primary)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: AppPrimaryButton(
                      onPressed: () {
                        isPersonalInfo.value = true;
                      },
                      text: "Personal Info",
                      borderRadius: 12,
                      backgroundColor: isPersonalInfo.value
                          ? AppColors.primary
                          : Colors.white,
                      textColor:
                          isPersonalInfo.value ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppPrimaryButton(
                      onPressed: () {
                        isPersonalInfo.value = false;
                      },
                      text: "Health Info",
                      borderRadius: 12,
                      backgroundColor: !isPersonalInfo.value
                          ? AppColors.primary
                          : Colors.white,
                      textColor:
                          !isPersonalInfo.value ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 8.h),
            Expanded(
              child: Obx(() {
                return Visibility(
                  visible: isPersonalInfo.value,
                  child: ProfilePersonalInfo(),
                  replacement: ProfileHealthInfo(),
                );
              }),
            ),
            const SizedBox(height: 16),
            AppPrimaryButton(
              onPressed: () {},
              text: "Save",
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
