import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';

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
        backgroundColor: AppColors.accent,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: 0,
          onTap: (index) {},
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/Home.svg"),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/Care_Gevers.svg"),
              label: 'Care Gevers',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/Profile.svg"),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/Contact.svg"),
              label: 'Contact',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/More.svg"),
              label: 'More',
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hi, Ahmed",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.notifications_active_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/image.png",
                                height: 80.h,
                                width: 80.w,
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Male,42 Years",
                                    style: TextStyle(
                                      color: Color(0xffCCCCCC),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    "ID: 12345678",
                                    style: TextStyle(
                                      color: Color(0xffCCCCCC),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    "Heart Attack",
                                    style: TextStyle(
                                      color: Color(0xffCCCCCC),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -110.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: VitalCard(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 118.h),
              SizedBox(height: 24.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explore",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardItem(
                          svgPath: "assets/svg/Vitals.svg",
                          label: "Vitals",
                          iconColor: Colors.red,
                          onTap: () {},
                        ),
                        DashboardItem(
                          svgPath: "assets/svg/Medications.svg",
                          label: "Medications",
                          iconColor: Colors.blue,
                          onTap: () {},
                        ),
                        DashboardItem(
                          svgPath: "assets/svg/Images.svg",
                          label: "Images",
                          iconColor: Colors.green,
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DashboardItem(
                          svgPath: "assets/svg/Appointments.svg",
                          label: "Appointments",
                          iconColor: Color(0xffCCBE7A),
                          onTap: () {},
                        ),
                        DashboardItem(
                          svgPath: "assets/svg/Labs.svg",
                          label: "Labs",
                          // iconColor: Colors.blue,
                          onTap: () {},
                        ),
                        DashboardItem(
                          svgPath: "assets/svg/Reports.svg",
                          label: "Reports",
                          // iconColor: Colors.green,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              )
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
