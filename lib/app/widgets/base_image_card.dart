import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Base64ImageCard extends StatelessWidget {
  final String? base64String;
  final String placeholderAsset;
  final double? width;
  final double? height;
  final double? borderRadius;

  const Base64ImageCard({
    super.key,
    required this.base64String,
    this.placeholderAsset = "assets/images/placeholder.png",
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100.w,
      height: height ?? 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    // Check if base64String is valid
    if (base64String == null || base64String!.isEmpty) {
      return _buildPlaceholder();
    }

    try {
      // Clean the base64 string by removing data URL prefix if present
      String cleanBase64 = base64String!.trim();

      // Remove data URL prefix (e.g., "data:image/png;base64,")
      if (cleanBase64.contains(',')) {
        cleanBase64 = cleanBase64.split(',').last;
      }

      // Validate base64 string format
      if (!_isValidBase64(cleanBase64)) {
        print('Invalid base64 format: $cleanBase64');
        return _buildPlaceholder();
      }

      // Decode base64 to bytes
      Uint8List imageBytes = base64Decode(cleanBase64);

      // Validate that we have actual image data
      if (imageBytes.isEmpty) {
        print('Empty image bytes after base64 decode');
        return _buildPlaceholder();
      }

      // Validate image format by checking magic bytes
      if (!_isValidImageFormat(imageBytes)) {
        print('Invalid image format detected');
        return _buildPlaceholder();
      }

      return Image.memory(
        imageBytes,
        fit: BoxFit.cover,
        width: 100.w,
        excludeFromSemantics: true,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading image: $error');
          return _buildPlaceholder();
        },
      );
    } catch (e) {
      print('Error decoding base64 image: $e');
      return _buildPlaceholder();
    }
  }

  Widget _buildPlaceholder() {
    return Image.asset(
      placeholderAsset,
      fit: BoxFit.cover,
      width: 100.w,
      errorBuilder: (context, error, stackTrace) {
        // If even the placeholder fails, show a simple container
        return Container(
          width: 100.w,
          color: Colors.grey.shade200,
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 40,
          ),
        );
      },
    );
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
