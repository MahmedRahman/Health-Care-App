import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';

class AppImagePickerBox extends FormField<File?> {
  AppImagePickerBox({
    Key? key,
    double size = 120,
    double borderRadius = 8,
    FormFieldValidator<File?>? validator,
    required Function(File image) onImageSelected,
  }) : super(
          key: key,
          validator: validator,
          builder: (FormFieldState<File?> state) {
            final ImagePickerController controller =
                Get.put(ImagePickerController());

            Future<void> _pickImage() async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                final file = File(pickedFile.path);
                controller.setImage(file);
                state.didChange(file); // تحديث الفورم
                onImageSelected(file);
              }
            }

            return Obx(() {
              final image = controller.selectedImage.value;

              return GestureDetector(
                onTap: _pickImage,
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
                          color:
                              state.hasError ? Colors.red : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: image == null
                          ? const Icon(
                              Icons.add_photo_alternate_outlined,
                              color: Color(0xFF0C2D48),
                              size: 40,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(borderRadius),
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    if (state.hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          state.errorText ?? '',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            });
          },
        );
}

class ImagePickerController extends GetxController {
  final Rx<File?> selectedImage = Rx<File?>(null);

  void setImage(File? file) {
    selectedImage.value = file;
  }

  void clearImage() {
    selectedImage.value = null;
  }
}
