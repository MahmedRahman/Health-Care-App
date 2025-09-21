import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class UploadController extends GetxController {
  // Form
  final folderName = ''.obs;

  // File
  final pickedFile = Rxn<File>();
  final pickedFileName = ''.obs;
  final pickedFileSize = ''.obs;

  // Progress
  final progress = 0.0.obs; // 0..1
  final isUploading = false.obs;

  // Constraints
  final allowedExts = const ['jpg', 'jpeg', 'png'];
  final maxSizeBytes = 5 * 1024 * 1024; // 5 MB

  Future<void> pickFile() async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: allowedExts,
      withData: true,
    );
    if (res == null || res.files.isEmpty) return;

    final f = res.files.single;
    if ((f.size) > maxSizeBytes) {
      Get.snackbar('File too large', 'Max file size is 5 MB');
      return;
    }

    final path = f.path;
    if (path == null) {
      Get.snackbar('Error', 'Could not read file path');
      return;
    }

    pickedFile.value = File(path);
    pickedFileName.value = f.name;
    pickedFileSize.value = _formatSize(f.size);
    progress.value = 0;
    isUploading.value = false;
  }

  void removeFile() {
    pickedFile.value = null;
    pickedFileName.value = '';
    pickedFileSize.value = '';
    progress.value = 0;
    isUploading.value = false;
  }

  Future<void> startUpload() async {
    if (pickedFile.value == null) {
      Get.snackbar('Select a file', 'Please choose a JPG/PNG first.');
      return;
    }
    if ((folderName.value).trim().isEmpty) {
      Get.snackbar('Folder name required', 'Please enter a folder name.');
      return;
    }

    isUploading.value = true;
    progress.value = 0;

    // Simulated upload — replace with your API call / storage upload
    final timer = Timer.periodic(const Duration(milliseconds: 120), (t) {
      final next = progress.value + 0.03;
      if (next >= 1.0) {
        progress.value = 1.0;
        isUploading.value = false;
        t.cancel();
        Get.back(); // close sheet on success
        Get.snackbar('Uploaded', 'Your file has been uploaded.');
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
