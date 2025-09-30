import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

// class AppCircleImage extends StatelessWidget {
//   final String? base64String; // صورة base64
//   final double size;
//   final String? placeholder; // صورة افتراضية من assets لو مفيش base64

//   const AppCircleImage({
//     super.key,
//     this.base64String,
//     this.size = 80,
//     this.placeholder,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Uint8List? bytes;

//     if (base64String != null && base64String!.isNotEmpty) {
//       try {
//         final cleaned = base64String!.contains(',')
//             ? base64String!.split(',').last
//             : base64String!;
//         bytes = base64Decode(cleaned);
//       } catch (_) {
//         bytes = null;
//       }
//     }

//     return ClipOval(
//       child: bytes != null
//           ? Image.memory(
//               bytes,
//               height: size,
//               width: size,
//               fit: BoxFit.cover,
//             )
//           : (placeholder != null
//               ? Image.asset(
//                   placeholder!,
//                   height: size,
//                   width: size,
//                   fit: BoxFit.cover,
//                 )
//               : Container(
//                   height: size,
//                   width: size,
//                   color: Colors.grey.shade300,
//                   child:
//                       const Icon(Icons.person, size: 40, color: Colors.white),
//                 )),
//     );
//   }
// }

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
      final cleaned = data.contains(',') ? data.split(',').last : data;

      // تنظيف من أي newlines أو مسافات
      final normalized = cleaned.replaceAll(RegExp(r'\s+'), '');

      return base64Decode(normalized);
    } catch (e) {
      debugPrint("⚠️ Invalid base64 image: $e");
      return null;
    }
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
