import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/medical_images/controllers/medical_images_controller.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/filter_bottom_sheet.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/filter_chips.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/filter_controller.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/medical_image_card.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/record_card.dart';

class MedicalImagesView extends GetView<MedicalImagesController> {
  const MedicalImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.yellow, // لون الهيدر
        statusBarIconBrightness: Brightness.light, // لون الأيقونات أبيض
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primary,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Images',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                'assets/svg/filter-list.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () async {
                final res = await Get.bottomSheet<FilterResult>(
                  const FilterBottomSheet(),
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                );

                if (res != null) {
                  // TODO: apply your filtering to list/API using res
                  Get.snackbar(
                    'Applied',
                    'from=${res.from} to=${res.to} sort=${res.sort}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: AppColors.primary,
                size: 24.sp,
              ),
              onPressed: controller.addNewImage,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: controller.obx(
            (snapshot) {
              final filteredImages = controller.filteredImages;

              return Column(
                children: [
                  Row(
                    children: [
                      clipText(),
                      clipText(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RecordCard(
                        thumbnail:
                            'assets/images/3d175c41acec1d81f48dee00ac2623283483af50.png',
                        date: DateTime(2022, 8, 1),
                        name: 'X-rays',
                        imageCount: 2,
                        attachments: const [
                          RecordAttachment(icon: Icons.picture_as_pdf),
                          RecordAttachment(icon: Icons.picture_as_pdf),
                        ],
                      ),
                      Spacer(),
                      RecordCard(
                        thumbnail:
                            'assets/images/3d175c41acec1d81f48dee00ac2623283483af50.png',
                        date: DateTime(2022, 8, 1),
                        name: 'X-rays',
                        imageCount: 2,
                        attachments: const [
                          RecordAttachment(icon: Icons.picture_as_pdf),
                          RecordAttachment(icon: Icons.picture_as_pdf),
                        ],
                      ),
                    ],
                  ),
                ],
              );
              ;
            },
            onEmpty: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/empty_Inbox.svg",
                    width: 200.w,
                    height: 200.h,
                  ),
                  Text(
                    'No Images yet',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.change(null, status: RxStatus.success());
                        },
                        child: Text(
                          "Add Image",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFE6F2B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding clipText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 80.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),

              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "All",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 24.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text("5"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
