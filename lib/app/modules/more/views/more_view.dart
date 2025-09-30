import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

import '../controllers/more_controller.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 24.h),
            userProfile(),
            SizedBox(
              height: 24.h,
            ),
            MoreItem(
              title: "Contact Us",
              icon: "assets/svg/more_call_us.svg",
              color: Color(0xff1BDDFF),
              onTap: () {
                Get.toNamed(Routes.CONTACT_US);
              },
            ),
            SizedBox(height: 12.h),
            MoreItem(
              title: "About App",
              icon: "assets/svg/more_info.svg",
              color: Color(0xff6A6565),
              onTap: () {
                Get.toNamed(Routes.ABOUT_APP);
              },
            ),
            SizedBox(height: 12.h),
            MoreItem(
              title: "Patient Info",
              icon: "assets/svg/more_info.svg",
              color: Color(0xff6A6565),
              onTap: () {
                Get.toNamed(Routes.PATIENT_INFO);
              },
            ),
            SizedBox(height: 12.h),
            MoreItem(
              title: "Delete Account",
              icon: "assets/svg/more_delete_icon.svg",
              color: Color(0xffF34F4F),
              onTap: () {
                Get.defaultDialog(
                  title: "Delete Account",
                  middleText:
                      "Are you sure you want to delete your account? This action cannot be undone.",
                  textCancel: "Cancel",
                  textConfirm: "Delete",
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  cancelTextColor: Colors.black,
                  onConfirm: () {
                    Get.back(); // يغلق الـ dialog
                    // ينفذ الإجراء اللي تبعته من فوق
                  },
                );
              },
            ),
            Spacer(),
            LogoutButton(
              onPressed: () async {
                controller.logout();
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class userProfile extends StatelessWidget {
  const userProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image(
          image: AssetImage("assets/images/user_profile.png"),
          width: 50,
          height: 50,
        ),
        SizedBox(width: 16.w),
        Text(
          "Ahmed Khaled",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.HOME);
          },
          child: SvgPicture.asset(
            "assets/svg/close.svg",
          ),
        )
      ],
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String icon;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                icon,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Color(0xff01052A).withOpacity(.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFF0C1543), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(
            color: Color(0xFF0C1543),
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class DeleteAccountButton extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteAccountButton({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        backgroundColor: Colors.white,
      ),
      child: const Text(
        'Delete Account',
        style: TextStyle(
          color: Colors.red,
          fontSize: 18,
        ),
      ),
    );
  }
}
