import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class AppCircleImage extends StatelessWidget {
  final String? base64String; // صورة base64
  final double size;
  final String? placeholder; // صورة افتراضية من assets لو مفيش base64

  const AppCircleImage({
    super.key,
    this.base64String,
    this.size = 80,
    this.placeholder,
  });

  Uint8List? _decodeBase64(String? data) {
    if (data == null || data.isEmpty) return null;

    try {
      // إزالة "data:image/png;base64," لو موجودة
      String cleaned = data.contains(',') ? data.split(',').last : data;

      // تنظيف من أي newlines أو مسافات
      cleaned = cleaned.replaceAll(RegExp(r'\s+'), '').trim();

      // Validate base64 format
      if (!_isValidBase64(cleaned)) {
        debugPrint("⚠️ Invalid base64 format");
        return null;
      }

      Uint8List bytes = base64Decode(cleaned);

      // Validate that we have actual image data
      if (bytes.isEmpty) {
        debugPrint("⚠️ Empty image bytes after base64 decode");
        return null;
      }

      // Validate image format by checking magic bytes
      if (!_isValidImageFormat(bytes)) {
        debugPrint("⚠️ Invalid image format detected");
        return null;
      }

      return bytes;
    } catch (e) {
      debugPrint("⚠️ Invalid base64 image: $e");
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

  @override
  Widget build(BuildContext context) {
    final bytes = _decodeBase64(base64String);

    return ClipOval(
      child: bytes != null
          ? Image.memory(
              bytes,
              height: size,
              width: size,
              fit: BoxFit.cover,
              errorBuilder: (ctx, error, stack) {
                return _buildFallback();
              },
            )
          : _buildFallback(),
    );
  }

  Widget _buildFallback() {
    if (placeholder != null) {
      return Image.asset(
        placeholder!,
        height: size,
        width: size,
        fit: BoxFit.cover,
      );
    }
    return Container(
      height: size,
      width: size,
      color: Colors.grey.shade300,
      child: const Icon(Icons.person, size: 40, color: Colors.white),
    );
  }
}
