import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const AppCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            shape: const CircleBorder(), // round checkbox
            side: const BorderSide(color: Colors.white),
            activeColor: Colors.white,
            checkColor: const Color(0xFF06283D),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

            visualDensity: VisualDensity.compact, // يقلل الحجم الإضافي
          ),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
