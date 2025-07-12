import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppIdCard extends StatefulWidget {
  final String code;
  final String name;
  final String password;
  final String extraText;

  const AppIdCard({
    super.key,
    required this.code,
    required this.name,
    required this.password,
    required this.extraText,
  });

  @override
  State<AppIdCard> createState() => _AppIdCardState();
}

class _AppIdCardState extends State<AppIdCard> {
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
    return Container(
      //width: 300,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_image == null)
                    Column(
                      children: [
                        const Icon(Icons.upload,
                            size: 40, color: Color(0xFF0C2D48)),
                        const SizedBox(height: 8),
                        const Text(
                          "Choose file",
                          style: TextStyle(
                              color: Color(0xFF0C2D48),
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "JPG, PNG, max file size is 5mb",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _image!,
                        height: 100,
                        // width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
