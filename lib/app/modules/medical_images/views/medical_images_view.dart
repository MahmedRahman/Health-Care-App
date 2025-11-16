import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/helper/app_notifier.dart';
import 'package:health_care_app/app/modules/medical_images/controllers/medical_images_controller.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/filter_bottom_sheet.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/filter_controller.dart';
import 'package:health_care_app/app/modules/medical_images/widgets/record_card.dart';
import 'package:health_care_app/app/widgets/image_viewer.dart';
import 'package:shimmer/shimmer.dart';

class MedicalImagesView extends GetView<MedicalImagesController> {
  const MedicalImagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.yellow, // لون الهيدر
        statusBarIconBrightness: Brightness.light, // لون الأيقونات أبيض
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          controller.initializeData();
        },
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.grey[100],
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => Get.back(),
            ),
            title: Text(
              'Images',
              style: TextStyle(
                color: Colors.black,
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
                    Colors.black,
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                  );

                  if (res != null) {
// chake if data
                    // if (res.from != null && res.to != null) {
                    //   Notifier.of.error("From date must be before to date",
                    //       title: "Invalid date range");
                    //   return;
                    // }

                    controller.filteredImages(res);
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24.sp,
                ),
                onPressed: controller.addNewImage,
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: controller.obx(
              (snapshot) {
                return Column(
                  children: [
                    // Responsive filter chips
                    SizedBox(
                      height: 35.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categoriesList
                            .length, // Example: All, X-rays, CT Scans
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: _buildFilterChip(
                              label:
                                  controller.categoriesList[index].toString(),
                              count: 0,
                              isSelected: index ==
                                  controller.selectedCategoryIndex.value,
                              onTap: () => controller.selectCategory(index),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // 2 Column Grid Layout
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(bottom: 20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                        ),
                        itemCount: snapshot?.length ?? 0, // Example data
                        itemBuilder: (context, index) {
                          final item = snapshot?[index];
                          final imgs = item?["imgs"] as List<dynamic>?;
                          final thumbnail = (imgs != null && imgs.isNotEmpty)
                              ? imgs[0]["imgs"].toString()
                              : null;

                          return RecordCard(
                            thumbnail: thumbnail,
                            date: item?["date"] ?? DateTime.now(),
                            name: item?["folderName"] ?? '',
                            imageCount: imgs?.length ?? 0,
                            onTap: () {
                              // Show image viewer with navigation
                              if (imgs != null && imgs.isNotEmpty) {
                                Get.bottomSheet(
                                  ImageViewer(
                                    images: imgs,
                                    initialIndex: 0,
                                  ),
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  enableDrag: false,
                                );
                              }
                            },
                            onDeletePressed: () {
                              controller.deleteImage(item);
                              // TODO: Implement delete
                            },
                            attachments: [
                              RecordAttachment(icon: Icons.picture_as_pdf)
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
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
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: controller.addNewImage
                          // TODO: Add image functionality
                          ,
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
              onLoading: _buildShimmerLoading(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffFE6F2B) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xffFE6F2B) : Colors.grey[300]!,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(width: 2.w),
            // Container(
            //   height: 12.h,
            //   padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            //   decoration: BoxDecoration(
            //     color:
            //         isSelected ? Colors.white.withOpacity(0.3) : Colors.grey[200],
            //     borderRadius: BorderRadius.circular(10.r),
            //   ),
            //   child: Text(
            //     count.toString(),
            //     style: TextStyle(
            //       fontSize: 12.sp,
            //       fontWeight: FontWeight.w600,
            //       color: isSelected ? Colors.white : Colors.black54,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Column(
      children: [
        // Shimmer filter chips
        SizedBox(
          height: 35.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        // Shimmer grid
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(bottom: 20.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12000000),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
