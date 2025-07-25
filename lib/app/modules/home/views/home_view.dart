import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/home/component/profile_Info.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF002B45), // لون الهيدر
        statusBarIconBrightness: Brightness.light, // لون الأيقونات أبيض
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileInfo(),
              SizedBox(height: 18.h),
              Expanded(
                child: Column(
                  children: [
                    VitalsignsBox(),
                    SizedBox(height: 24.h),
                    QuickLinks(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickLinks extends StatelessWidget {
  const QuickLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Links",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardItem(
                  svgPath: "assets/svg/Vitals.svg",
                  label: "Vitals",
                  iconColor: Colors.red,
                  onTap: () {},
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Medications.svg",
                  label: "Medications",
                  iconColor: Colors.blue,
                  onTap: () {
                    Get.toNamed(Routes.MEDICATIONS);
                  },
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Images.svg",
                  label: "Images",
                  iconColor: Colors.green,
                  onTap: () {},
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Appointments.svg",
                  label: "Appointments",
                  iconColor: Color(0xffCCBE7A),
                  onTap: () {},
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Labs.svg",
                  label: "Labs",
                  // iconColor: Colors.blue,
                  onTap: () {},
                ),
                SizedBox(width: 8.w),
                DashboardItem(
                  svgPath: "assets/svg/Reports.svg",
                  label: "Reports",
                  // iconColor: Colors.green,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          DashboardItemHorizontal(
            title: "vitals",
            svgPath: "assets/svg/Vitals.svg",
            iconColor: Colors.red,
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          DashboardItemHorizontal(
            title: "Medications",
            svgPath: "assets/svg/Medications.svg",
            iconColor: Colors.blue,
            onTap: () {
              Get.toNamed(Routes.MEDICATIONS);
            },
          )
        ],
      ),
    );
  }
}

class DashboardItemHorizontal extends StatelessWidget {
  final String title;
  final String svgPath;
  final Color iconColor;
  final Function() onTap;
  const DashboardItemHorizontal({
    super.key,
    required this.title,
    required this.svgPath,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SvgPicture.asset(
            svgPath,
            color: iconColor,
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class VitalsignsBox extends StatelessWidget {
  const VitalsignsBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vital signs",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              VitalSignsCard(
                title: "Blood Pressure",
                value: "120/80",
              ),
              SizedBox(width: 8.w),
              VitalSignsCard(
                title: "Heart Rate",
                value: "60 bpm",
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              VitalSignsCard(
                title: "Oxygen Saturation",
                value: "95%",
              ),
              SizedBox(width: 8.w),
              VitalSignsCard(
                title: "Weight",
                value: "70 kg",
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              VitalSignsCard(
                title: "R.B.S",
                value: "112 mg/dl",
              ),
              SizedBox(width: 8.w),
              VitalSignsCard(
                title: "Fluid Balance",
                value: "-200 ml",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VitalSignsCard extends StatelessWidget {
  const VitalSignsCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VitalCard extends StatelessWidget {
  const VitalCard({super.key});

  Widget buildItem(
    String title,
    String value, {
    Color? valueColor,
    IconData? icon,
    Color? iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Icon(icon, size: 14, color: iconColor ?? Colors.black54),
              ),
          ],
        ),

        // const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      height: 130.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildItem(
                  'BP',
                  '120/80',
                  icon: Icons.north_east,
                  iconColor: Colors.orange,
                  valueColor: Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildItem(
                  'HR --',
                  '56',
                  valueColor: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildItem(
                  'SATS --',
                  '40',
                  valueColor: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: buildItem(
                  'WT',
                  '75',
                  icon: Icons.south_west,
                  iconColor: Colors.red,
                  valueColor: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildItem(
                  'R.B.S --',
                  '40',
                  valueColor: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: buildItem(
                  'BALANCE --',
                  '50',
                  valueColor: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String svgPath;
  final String label;
  final Color iconColor;
  final VoidCallback? onTap;

  const DashboardItem({
    super.key,
    required this.svgPath,
    required this.label,
    this.iconColor = Colors.pink,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 106.w,
        height: 92.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: iconColor.withOpacity(0.5),
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: Color(0xff0D1B34),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
