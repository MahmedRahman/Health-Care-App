import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;

  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.iconColor = Colors.blue, // default facebook blue
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onPressed,
        iconSize: 28,
        splashRadius: 28,
      ),
    );
  }
}
