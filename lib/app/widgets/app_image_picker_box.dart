import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppImagePickerBox extends StatefulWidget {
  final double size;
  final double borderRadius;

  const AppImagePickerBox({
    super.key,
    this.size = 120,
    this.borderRadius = 20,
  });

  @override
  State<AppImagePickerBox> createState() => _AppImagePickerBoxState();
}

class _AppImagePickerBoxState extends State<AppImagePickerBox> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Color.fromARGB(16, 240, 240, 240), // رمادي فاتح
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: _image == null
            ? const Icon(
                Icons.add_photo_alternate_outlined,
                color: Color(0xFF0C2D48),
                size: 40,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
