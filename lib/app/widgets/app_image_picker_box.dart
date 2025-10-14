import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class AppImagePickerBox extends FormField<File?> {
//   AppImagePickerBox({
//     Key? key,
//     double size = 120,
//     double borderRadius = 8,
//     FormFieldValidator<File?>? validator,
//     required Function(File image) onImageSelected,
//   }) : super(
//           key: key,
//           validator: validator,
//           builder: (FormFieldState<File?> state) {
//             final ImagePickerController controller =
//                 Get.put(ImagePickerController());

//             Future<void> _pickImage() async {
//               final pickedFile =
//                   await ImagePicker().pickImage(source: ImageSource.gallery);
//               if (pickedFile != null) {
//                 final file = File(pickedFile.path);
//                 controller.setImage(file);
//                 state.didChange(file); // تحديث الفورم
//                 onImageSelected(file);
//               }
//             }

//             return Obx(() {
//               final image = controller.selectedImage.value;

//               return GestureDetector(
//                 onTap: _pickImage,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: size,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(borderRadius),
//                         border: Border.all(
//                           color:
//                               state.hasError ? Colors.red : Colors.transparent,
//                           width: 1.5,
//                         ),
//                       ),
//                       child: image == null
//                           ? const Icon(
//                               Icons.add_photo_alternate_outlined,
//                               color: Color(0xFF0C2D48),
//                               size: 40,
//                             )
//                           : ClipRRect(
//                               borderRadius: BorderRadius.circular(borderRadius),
//                               child: Image.file(
//                                 image,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                     ),
//                     if (state.hasError)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8, left: 4),
//                         child: Text(
//                           state.errorText ?? '',
//                           style: const TextStyle(
//                             color: Colors.red,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               );
//             });
//           },
//         );
// }

// class ImagePickerController extends GetxController {
//   final Rx<File?> selectedImage = Rx<File?>(null);

//   void setImage(File? file) {
//     selectedImage.value = file;
//   }

//   void clearImage() {
//     selectedImage.value = null;
//   }
// }

import 'dart:convert';
import 'dart:typed_data';

class AppImagePickerBox extends StatelessWidget {
  final TextEditingController controller; // يحفظ Base64
  final double size;
  final double borderRadius;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String>? onBase64Changed; // اختياري: إنت تسمع للقيمة
  final bool enableLongPressClear; // مسح بالضغط المطوّل

  const AppImagePickerBox({
    super.key,
    required this.controller,
    this.size = 120,
    this.borderRadius = 8,
    this.validator,
    this.onBase64Changed,
    this.enableLongPressClear = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String?>(
      initialValue: controller.text.isNotEmpty ? controller.text : null,
      validator: validator,
      onSaved: (v) {
        if (v != null && v != controller.text) controller.text = v;
      },
      builder: (state) {
        final hasError = state.hasError;
        final b64 = state.value ?? controller.text;
        final bytes = _decodeBase64OrNull(b64);

        Future<void> _pickImage() async {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          if (pickedFile == null) return;

          final file = File(pickedFile.path);
          final raw = await file.readAsBytes();
          final base64Str = base64Encode(raw);

          controller.text = base64Str;
          state.didChange(base64Str);
          onBase64Changed?.call(base64Str);
        }

        void _clear() {
          controller.clear();
          state.didChange(null);
          onBase64Changed?.call('');
        }

        return GestureDetector(
          onTap: _pickImage,
          onLongPress: enableLongPressClear ? _clear : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: hasError ? Colors.red : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: (bytes == null)
                    ? const Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Color(0xFF0C2D48),
                        size: 40,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: Image.memory(
                          bytes,
                          gaplessPlayback: true,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              if (hasError) const SizedBox(height: 8),
              if (hasError)
                Text(
                  state.errorText ?? '',
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
            ],
          ),
        );
      },
    );
  }

  /// يقبل Base64 بصيغة خام أو data URI (مثل: data:image/jpeg;base64,...)
  Uint8List? _decodeBase64OrNull(String? input) {
    if (input == null || input.isEmpty) return null;
    try {
      String cleaned = input.contains(',')
          ? input.split(',').last // يشيل الـ data:...;base64, prefix
          : input;

      // تنظيف من أي newlines أو مسافات
      cleaned = cleaned.replaceAll(RegExp(r'\s+'), '').trim();

      // Validate base64 format
      if (!_isValidBase64(cleaned)) {
        return null;
      }

      Uint8List bytes = base64Decode(cleaned);

      // Validate that we have actual image data
      if (bytes.isEmpty) {
        return null;
      }

      // Validate image format by checking magic bytes
      if (!_isValidImageFormat(bytes)) {
        return null;
      }

      return bytes;
    } catch (_) {
      return null;
    }
  }

  bool _isValidBase64(String str) {
    if (str.isEmpty) return false;

    // Check if string contains only valid base64 characters
    final base64Regex = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
    if (!base64Regex.hasMatch(str)) return false;

    // Check if string length is valid for base64 (must be multiple of 4)
    return str.length % 4 == 0;
  }

  bool _isValidImageFormat(Uint8List bytes) {
    if (bytes.length < 4) return false;

    // Check for common image format magic bytes
    // PNG: 89 50 4E 47
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return true;
    }

    // JPEG: FF D8 FF
    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return true;
    }

    // GIF: 47 49 46 38
    if (bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x38) {
      return true;
    }

    // WebP: 52 49 46 46 (RIFF) followed by 57 45 42 50 (WEBP)
    if (bytes.length >= 12 &&
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50) {
      return true;
    }

    return false;
  }
}
