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

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;

    if (base64String != null && base64String!.isNotEmpty) {
      try {
        final cleaned = base64String!.contains(',')
            ? base64String!.split(',').last
            : base64String!;
        bytes = base64Decode(cleaned);
      } catch (_) {
        bytes = null;
      }
    }

    return ClipOval(
      child: bytes != null
          ? Image.memory(
              bytes,
              height: size,
              width: size,
              fit: BoxFit.cover,
            )
          : (placeholder != null
              ? Image.asset(
                  placeholder!,
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: size,
                  width: size,
                  color: Colors.grey.shade300,
                  child:
                      const Icon(Icons.person, size: 40, color: Colors.white),
                )),
    );
  }
}
