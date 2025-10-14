import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/home/component/app_circle_image.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';

class ProfileInfo extends StatelessWidget {
  final void Function()? onTap;
  String userName = ""; // Example user name
  String userAge = ""; // Example age
  String userGender = ""; // Example
  String userId = ""; // Example ID
  String base64String = "";
  String userHealthStatus = "";
  ProfileInfo({
    super.key,
    this.onTap,
    this.userName = "",
    this.userAge = "",
    this.userGender = "",
    this.userId = "",
    this.userHealthStatus = "",
    this.base64String = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // height: 228.h,
        decoration: BoxDecoration(
          color: Color(0xff0D268D),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.r),
            bottomRight: Radius.circular(40.r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            left: 24.0,
            right: 24.0,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Hi, $userName",
                    style: TextStyle(
                      fontSize: 29.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Image.asset(
                    "assets/images/happy_face.png",
                    height: 30.h,
                    width: 30.w,
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/svg/notifications.svg',
                  )
                  // AppIconButtonSvg(
                  //   assetPath: 'assets/svg/notifications.svg',
                  //   iconSize: 40.w,
                  //   onPressed: () {
                  //     Get.dialog(
                  //       Center(
                  //         child: Container(
                  //           width: 300,
                  //           padding: EdgeInsets.all(20),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(20),
                  //           ),
                  //           child: Material(
                  //             child: Stack(
                  //               children: [
                  //                 Column(
                  //                   mainAxisSize: MainAxisSize.min,
                  //                   children: [
                  //                     SizedBox(height: 16.h),
                  //                     // Icon
                  //                     Image.asset(
                  //                       'assets/images/medication_icon.png', // بدلها بمسار الصورة بتاعتك
                  //                       width: 64,
                  //                       height: 64,
                  //                     ),
                  //                     SizedBox(height: 16.h),

                  //                     // Title
                  //                     Text(
                  //                       'Medication Alert',
                  //                       style: TextStyle(
                  //                         fontSize: 18,
                  //                         fontWeight: FontWeight.bold,
                  //                         color: Colors.redAccent,
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 12.h),

                  //                     // Message
                  //                     Text(
                  //                       "It seems you’re not taking your medication regularly. Please follow your prescribed schedule to stay healthy.",
                  //                       textAlign: TextAlign.center,
                  //                       style: TextStyle(
                  //                         fontSize: 14,
                  //                         color: Colors.grey[700],
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),

                  //                 // Close button
                  //                 Positioned(
                  //                   top: 0,
                  //                   right: 0,
                  //                   child: GestureDetector(
                  //                     onTap: () => Get.back(),
                  //                     child: Icon(
                  //                       Icons.close,
                  //                       color: Colors.grey[600],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (base64String.isNotEmpty)
                            AppCircleImage(
                              base64String: base64String,
                              size: 80,
                              placeholder:
                                  "assets/images/ix_user-profile-filled.png",
                            ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "$userGender,$userAge Years",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "ID: $userId",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "$userHealthStatus",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
