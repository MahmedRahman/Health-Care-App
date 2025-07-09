import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButtonSvg extends StatelessWidget {
  final VoidCallback onPressed;
  final String assetPath;
  final double iconSize;
  final Color? iconColor;

  const AppIconButtonSvg({
    super.key,
    required this.onPressed,
    required this.assetPath,
    this.iconSize = 28,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        iconSize: iconSize + 16, // adjust clickable area
        splashRadius: iconSize + 2,
        icon: SvgPicture.asset(
          assetPath,
          width: iconSize,
          height: iconSize,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
