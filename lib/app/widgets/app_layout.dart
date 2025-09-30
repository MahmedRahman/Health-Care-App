import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/routes/app_pages.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;

    if (selectedIndex.value == 0) {
      Get.offAllNamed(Routes.HOME);
    } else if (selectedIndex.value == 1) {
      Get.offAllNamed(Routes.CARE_GEVERS);
    } else if (selectedIndex.value == 2) {
      Get.offAllNamed(Routes.PROFILE);
    } else if (selectedIndex.value == 3) {
      Get.offAllNamed(Routes.CONTACT);
    } else if (selectedIndex.value == 4) {
      Get.offAllNamed(Routes.MORE);
    }
  }
}

const List<String> svgIcons = [
  "assets/svg/Home.svg",
  "assets/svg/Care_Gevers.svg",
  "assets/svg/Profile.svg",
  "assets/svg/Contact.svg",
  "assets/svg/More.svg",
];

const List<String> labels = [
  "Home",
  "Care Givers",
  "Profile",
  "Contact",
  "More",
];

class AppLayout extends StatelessWidget {
  final Widget body;

  const AppLayout({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.put(
      NavigationController(),
      permanent: true,
    );

    return Scaffold(
      body: body,
      bottomNavigationBar: Obx(() {
        final current = navController.selectedIndex.value;

        return NavigationBar(
          selectedIndex: current,
          onDestinationSelected: navController.changeTab,
          height: 60.h,
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor: Colors.transparent,
          destinations: List.generate(svgIcons.length, (index) {
            return NavigationDestination(
              icon: navIcon(svgIcons[index], false),
              selectedIcon: navIcon(svgIcons[index], true),
              label: labels[index],

              //iconColor: current == index ? AppColors.primary : Colors.grey,
            );
          }),
        );
      }),
    );
  }
}

Widget navIcon(String assetPath, bool isSelected) {
  return SvgPicture.asset(
    assetPath,
    width: 24.w,
    height: 24.h,
    colorFilter: ColorFilter.mode(
      isSelected ? AppColors.primary : Colors.grey,
      BlendMode.srcIn,
    ),
  );
}

class LayoutMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    final child = page?.page() ?? Container();

    if (page?.name == '/home') {
      if (Get.isRegistered<NavigationController>()) {
        Get.find<NavigationController>().selectedIndex.value = 0;
      }
    }

    final routesWithLayout = [
      '/home',
      '/care-gevers',
      '/profile',
      '/contact',
      '/more',
    ];

    if (routesWithLayout.contains(page?.name)) {
      return GetPage(
        name: page!.name,
        page: () => AppLayout(
          body: child,
        ),
        transition: page.transition,
        binding: page.binding,
      );
    }

    return page;
  }
}
