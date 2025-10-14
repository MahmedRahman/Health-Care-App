import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_care_app/app/constants/colors.dart';

class FilterItem extends StatelessWidget {
  final String title;
  final int count;
  final bool isSelected;
  void Function()? onTap;
  FilterItem({
    super.key,
    required this.title,
    required this.count,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColorsMedications.white,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: isSelected
                ? AppColorsMedications.black
                : AppColorsMedications.white,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 0,
              ),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColorsMedications.black,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColorsMedications.grey,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w,
                        vertical: 4.h,
                      ),
                      child: Text(
                        count.toString(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColorsMedications.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
