import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/modules/medical_images/controllers/medical_images_controller.dart';
import 'upload_controller.dart';

class UploadBottomSheet extends GetView<UploadController> {
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
    final orange = const Color(0xFFFF6A2A);
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
        child: SingleChildScrollView(
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
                    'Upload',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: navy,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Folder Name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Folder Name',
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
                    onChanged: (v) => controller.folderName.value = v,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      hintText: 'Text here..',
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
                          child: const Icon(Icons.upload_rounded, size: 40),
                        ),
                        const SizedBox(height: 14),
                        Text('Choose file',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: navy,
                            )),
                        const SizedBox(height: 6),
                        Text(
                          'JPG, PNG, max file size is 5mb',
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
                          onPressed: () {
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
                  if (controller.pickedFiles.isEmpty) return const SizedBox();

                  return Column(
                    children: [
                      for (int i = 0; i < controller.pickedFiles.length; i++)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.pickedFileNames[i],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      controller.pickedFileSizes[i],
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(color: Colors.black45),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () => controller.removeFileAt(i),
                                icon: const Icon(Icons.delete_outline_rounded),
                                color: Colors.black38,
                                tooltip: 'Remove',
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),

                // Progress indicator
                Obx(() {
                  if (!controller.isUploading.value) return const SizedBox();

                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.blue.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(orange),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Uploading images...',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: navy,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${(controller.progress.value * 100).toInt()}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: orange,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: controller.progress.value,
                              backgroundColor: Colors.blue.withOpacity(0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(orange),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 22),

                // Actions
                Obx(() => Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: controller.isUploading.value
                                  ? Colors.grey
                                  : orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                                    // التحقق من وجود ملفات واسم المجلد
                                    if (controller.pickedFiles.isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Please select files first',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }

                                    if (controller.folderName.value
                                        .trim()
                                        .isEmpty) {
                                      Get.snackbar(
                                        'Error',
                                        'Please enter a folder name',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }

                                    // بدء عملية الرفع
                                    controller.isUploading.value = true;
                                    controller.progress.value = 0.0;

                                    List<String> images = [];

                                    try {
                                      // تحويل جميع الملفات إلى base64
                                      for (int i = 0;
                                          i < controller.pickedFiles.length;
                                          i++) {
                                        final file = controller.pickedFiles[i];
                                        final bytes = file.readAsBytesSync();
                                        final base64String =
                                            base64Encode(bytes);
                                        images.add(base64String);

                                        // تحديث التقدم
                                        controller.progress.value = (i + 1) /
                                            controller.pickedFiles.length;
                                      }

                                      Get.back();
                                      await Get.find<MedicalImagesController>()
                                          .uploadImage(
                                        controller.folderName.value,
                                        images,
                                      );

                                      controller.removeFile();
                                      controller.folderName.value = '';

                                      // مسح البيانات بعد النجاح
                                    } catch (e) {
                                      Get.snackbar(
                                        'Error',
                                        'Failed to upload images: ${e.toString()}',
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    } finally {
                                      controller.isUploading.value = false;
                                      controller.progress.value = 0.0;
                                    }
                                  },
                            child: controller.isUploading.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Uploading...'),
                                    ],
                                  )
                                : const Text('Add'),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 12),
                Obx(() => TextButton(
                      onPressed: controller.isUploading.value
                          ? null
                          : () => Get.back(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:
                              controller.isUploading.value ? Colors.grey : navy,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
