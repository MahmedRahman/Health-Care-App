import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'upload_controller.dart';

class UploadBottomSheet extends GetView<UploadController> {
  const UploadBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orange = const Color(0xFFFF6A2A);
    final navy = const Color(0xFF0E2A38);
    final border = BorderSide(color: Colors.black12, width: 1);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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
              child: Text(
                'Choose file',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: navy,
                ),
              ),
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

            // Selected file tile + progress
            Obx(() {
              final name = controller.pickedFileName.value;
              if (name.isEmpty) return const SizedBox();
              final pct = (controller.progress.value * 100).clamp(0, 100);
              final uploading = controller.isUploading.value;

              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                          Text(name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(controller.pickedFileSize.value,
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black45)),
                              const SizedBox(width: 12),
                              Text(
                                '${pct.toStringAsFixed(0)}% ${uploading ? 'Uploading' : pct >= 100 ? 'Done' : 'Ready'}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // small progress bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: controller.progress.value == 0
                                  ? null
                                  : controller.progress.value,
                              minHeight: 6,
                              backgroundColor: const Color(0xFFF2F2F2),
                              color: orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: uploading ? null : controller.removeFile,
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: Colors.black38,
                      tooltip: 'Remove',
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 22),

            // Actions
            Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
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
                        onPressed:
                            Get.find<UploadController>().isUploading.value
                                ? null
                                : Get.find<UploadController>().startUpload,
                        child: const Text('Add'),
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
    );
  }
}
