import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/widgets/simple_pdf_viewer.dart';

import '../controllers/labs_controller.dart';
import '../widgets/lab_report_card.dart';

class LabsView extends GetView<LabsController> {
  const LabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        title: Text(
          'Labs',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xffF2F2F2),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/svg/filter-list.svg',
                width: 24.w,
                height: 24.h,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () async {},
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
                size: 24.sp,
              ),
              onPressed: controller.addNewLabReport,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.getLabs,
        child: controller.obx(
          (snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: GridView.builder(
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
                      ? imgs[0]["imgs"]
                      : item?["report"];

                  return LabReportCard(
                    thumbnail: thumbnail,
                    date: item?["date"] ?? '',
                    labName: item?["labType"] ?? '',
                    imageCount: imgs?.length ?? 1,
                    onDeletePressed: () {
                      Get.dialog(
                        AlertDialog(
                          title: Text('Delete Lab Report'),
                          content: Text(
                              'Are you sure you want to delete this lab report?'),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                                controller.deleteLabReport(
                                  labReport: item,
                                );
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    onTap: () {
                      // Show PDF viewer for lab reports
                      if (imgs != null && imgs.isNotEmpty) {
                        // If there are multiple images, show the first one as PDF
                        final firstImage = imgs[0];
                        if (firstImage["imgs"] != null) {
                          Get.bottomSheet(
                            SimplePDFViewer(
                              base64String: firstImage["imgs"],
                              fileName:
                                  '${item?["labType"] ?? "Lab Report"}.pdf',
                            ),
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            enableDrag: false,
                          );
                        }
                      } else if (item?["report"] != null) {
                        // Show single PDF report
                        Get.bottomSheet(
                          SimplePDFViewer(
                            base64String: item?["report"],
                            fileName: '${item?["labType"] ?? "Lab Report"}.pdf',
                          ),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          enableDrag: false,
                        );
                      }
                    },
                    attachments: [
                      LabReportAttachment(
                        icon: Icons.picture_as_pdf,
                        onTap: () {
                          // Open PDF when attachment is tapped
                          if (imgs != null && imgs.isNotEmpty) {
                            final firstImage = imgs[0];
                            if (firstImage["imgs"] != null) {
                              Get.bottomSheet(
                                SimplePDFViewer(
                                  base64String: firstImage["imgs"],
                                  fileName:
                                      '${item?["labType"] ?? "Lab Report"}.pdf',
                                ),
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                enableDrag: false,
                              );
                            }
                          } else if (item?["report"] != null) {
                            Get.bottomSheet(
                              SimplePDFViewer(
                                base64String: item?["report"],
                                fileName:
                                    '${item?["labType"] ?? "Lab Report"}.pdf',
                              ),
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              enableDrag: false,
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          },
          onEmpty: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/EmptyInbox_orainge.svg",
                  width: 200.w,
                  height: 200.h,
                ),
                SizedBox(height: 16.h),
                Text(
                  'No Labs yet',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Add your lab reports to keep track of your health',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: controller.addNewLabReport,
                      child: Text(
                        "Add Lab Report",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffDC61E0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
