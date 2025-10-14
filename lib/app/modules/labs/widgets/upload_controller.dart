import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class LabsUploadController extends GetxController {
  // Form
  final labName = ''.obs;

  // Files
  final pickedFiles = <File>[].obs;
  final pickedFileNames = <String>[].obs;
  final pickedFileSizes = <String>[].obs;

  // Progress
  final progress = 0.0.obs; // 0..1
  final isUploading = false.obs;

  // Constraints
  final allowedExts = const ['jpg', 'jpeg', 'png', 'pdf'];
  final maxSizeBytes = 5 * 1024 * 1024; // 5 MB

  Future<void> pickFile() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: allowedExts,
      withData: true,
    );
    if (res == null || res.files.isEmpty) return;

    // إضافة الملفات الجديدة إلى القائمة
    for (final f in res.files) {
      if ((f.size) > maxSizeBytes) {
        Get.snackbar('File too large', '${f.name} is larger than 5 MB');
        continue;
      }

      final path = f.path;
      if (path == null) {
        Get.snackbar('Error', 'Could not read file path for ${f.name}');
        continue;
      }

      final file = File(path);
      // التحقق من عدم وجود الملف مسبقاً
      if (!pickedFiles.any((existingFile) => existingFile.path == file.path)) {
        pickedFiles.add(file);
        pickedFileNames.add(f.name);
        pickedFileSizes.add(_formatSize(f.size));
      }
    }

    progress.value = 0;
    isUploading.value = false;
  }

  void removeFile() {
    pickedFiles.clear();
    pickedFileNames.clear();
    pickedFileSizes.clear();
    progress.value = 0;
    isUploading.value = false;
    labName.value = '';
  }

  void removeFileAt(int index) {
    if (index >= 0 && index < pickedFiles.length) {
      pickedFiles.removeAt(index);
      pickedFileNames.removeAt(index);
      pickedFileSizes.removeAt(index);
    }
  }

  Future<void> startUpload() async {
    if (pickedFiles.isEmpty) {
      Get.snackbar('Select files', 'Please choose JPG/PNG/PDF files first.');
      return;
    }
    if ((labName.value).trim().isEmpty) {
      Get.snackbar('Lab name required', 'Please enter a lab name.');
      return;
    }

    isUploading.value = true;
    progress.value = 0;

    // Simulated upload — replace with your API call / storage upload
    Timer.periodic(const Duration(milliseconds: 120), (t) {
      final next = progress.value + 0.03;
      if (next >= 1.0) {
        progress.value = 1.0;
        isUploading.value = false;
        t.cancel();
        Get.back(); // close sheet on success
        Get.snackbar('Uploaded', 'Your lab report has been uploaded.');
      } else {
        progress.value = next;
      }
    });

    // If you call a real uploader, cancel timer and update progress from callbacks.
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(0)}kb';
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(2)}MB';
  }
}
