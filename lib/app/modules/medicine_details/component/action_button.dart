import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final Color bgColor;
  final Color iconColor;
  final bool isExpanded;

  const ActionButton({
    super.key,
    required this.icon,
    this.label,
    required this.onTap,
    this.bgColor = const Color(0xFFF0F5FF),
    this.iconColor = const Color(0xFF0A2942),
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: label != null ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 20),
        if (label != null) ...[
          const SizedBox(width: 8),
          Text(
            label!,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]
      ],
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child:
            isExpanded ? SizedBox(width: double.infinity, child: child) : child,
      ),
    );
  }
}
