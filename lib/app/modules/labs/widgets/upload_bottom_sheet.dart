import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/modules/labs/controllers/labs_controller.dart';
import 'upload_controller.dart';

class UploadBottomSheet extends GetView<LabsUploadController> {
  const UploadBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // مسح البيانات عند فتح الـ sheet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.pickedFiles.isNotEmpty) {
        controller.removeFile();
      }
    });

    final theme = Theme.of(context);
    final purple = const Color(0xffDC61E0);
    final navy = const Color(0xFF0E2A38);
    final border = BorderSide(color: Colors.black12, width: 1);

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.9, // حد أقصى للارتفاع
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Obx(() => controller.isUploading.value
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(purple),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Uploading lab report...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: Get.height * 0.3, // حد أدنى للارتفاع
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // drag handle
                      Container(
                        width: 48,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upload Lab Report',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: navy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Lab Name
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lab Name',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: navy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.fromBorderSide(border),
                        ),
                        child: TextField(
                          onChanged: (v) => controller.labName.value = v,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            hintText: 'Enter lab name...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Choose file
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => Text(
                              'Choose file${controller.pickedFiles.isNotEmpty ? ' (${controller.pickedFiles.length} selected)' : ''}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: navy,
                              ),
                            )),
                      ),
                      const SizedBox(height: 10),

                      // Drop zone / picker
                      InkWell(
                        onTap: controller.pickFile,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 28),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.fromBorderSide(border),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFF8FAFC), Colors.white],
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 88,
                                height: 88,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xFFEFF4F8), Colors.white],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x0F000000),
                                      blurRadius: 16,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child:
                                    const Icon(Icons.upload_rounded, size: 40),
                              ),
                              const SizedBox(height: 14),
                              Text('Choose file',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: navy,
                                  )),
                              const SizedBox(height: 6),
                              Text(
                                'JPG, PNG, PDF, max file size is 5mb',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Clear all files button
                      Obx(() => controller.pickedFiles.isNotEmpty
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: controller.isUploading.value
                                    ? null
                                    : () {
                                        controller.removeFile();
                                      },
                                child: Text(
                                  'Clear all',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox()),

                      // Selected files list
                      Obx(() {
                        if (controller.pickedFiles.isEmpty)
                          return const SizedBox();
                        final uploading = controller.isUploading.value;

                        return Column(
                          children: [
                            for (int i = 0;
                                i < controller.pickedFiles.length;
                                i++)
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.fromBorderSide(border),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.pickedFileNames[i],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            controller.pickedFileSizes[i],
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: uploading
                                          ? null
                                          : () => controller.removeFileAt(i),
                                      icon: const Icon(
                                          Icons.delete_outline_rounded),
                                      color: Colors.black38,
                                      tooltip: 'Remove',
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      }),

                      const SizedBox(height: 22),

                      // Actions
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.isUploading.value
                                            ? Colors.grey
                                            : purple,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  onPressed: controller.isUploading.value
                                      ? null
                                      : () async {
                                          // التحقق من وجود ملفات واسم المختبر
                                          if (controller.pickedFiles.isEmpty) {
                                            Get.snackbar(
                                              'Error',
                                              'Please select files first',
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                            return;
                                          }

                                          if (controller.labName.value
                                              .trim()
                                              .isEmpty) {
                                            Get.snackbar(
                                              'Error',
                                              'Please enter a lab name',
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                            return;
                                          }

                                          List<String> images = [];

                                          // بدء حالة التحميل
                                          controller.isUploading.value = true;

                                          try {
                                            // تحويل جميع الملفات إلى base64 مع هيكل متعدد الصور
                                            for (final file
                                                in controller.pickedFiles) {
                                              final bytes =
                                                  file.readAsBytesSync();
                                              final base64String =
                                                  base64Encode(bytes);
                                              // إضافة الصور بهيكل متوافق مع النظام
                                              images.add(base64String);
                                            }

                                            Get.find<LabsController>()
                                                .addLabReport(
                                              labName: controller.labName.value,
                                              images: images,
                                            );

                                            // إعادة تعيين حالة التحميل
                                            controller.isUploading.value =
                                                false;

                                            // مسح البيانات بعد النجاح
                                            controller.removeFile();
                                            controller.labName.value = '';

                                            // إعادة تحميل البيانات
                                            Get.find<LabsController>()
                                                .getLabs();

                                            // إغلاق الـ dialog بعد النجاح
                                            Get.back();
                                          } catch (e) {
                                            // إعادة تعيين حالة التحميل في حالة الخطأ
                                            controller.isUploading.value =
                                                false;
                                            Get.snackbar(
                                              'Error',
                                              'Failed to process lab report: $e',
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                            );
                                          }
                                        },
                                  child: controller.isUploading.value
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Text('Uploading...'),
                                          ],
                                        )
                                      : const Text('Add Lab Report'),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
      ),
    );
  }
}
