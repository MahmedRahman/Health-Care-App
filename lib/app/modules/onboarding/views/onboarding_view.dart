import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/modules/onboarding/controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      _OnboardingPageData(
        title: "Welcome To \nYour Heart Care App",
        description:
            "Your heart health is our top priority!To support your Heart, we’re proud to introduce our Heart Care App—designed to help you monitor, manage, and improve your heart health with ease and confidence.Here’s how our app can help you.",
        image: null,
        isTextPage: true,
      ),
      _OnboardingPageData(
        title: "Get Connected and Stay on Top of Your Heart Health",
        description:
            "Track heart rate, blood pressure, oxygen levels, blood sugar, fluids balance and Receive alerts for abnormal vitals and medication reminders",
        image: "assets/images/onboarding/1.png",
      ),
      _OnboardingPageData(
        title: "Never Miss a Dose",
        description:
            "Set gentle reminders for medications and receive alerts when it’s time for a refill.",
        image: "assets/images/onboarding/2.png",
      ),
      _OnboardingPageData(
        title: "Quick Access To Care",
        description:
            "Need help?  Book virtual appointments with your doctor or connect instantly for advice",
        image: "assets/images/onboarding/3.png",
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              return Column(
                children: [
                  page.image != null
                      ? Stack(
                          children: [
                            if (page.image != null)
                              Container(
                                // color: Colors.red,
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ), // ← your desired radius
                                    child: Image.asset(
                                      width: double.infinity,

                                      page.image!,
                                      fit: BoxFit
                                          .fill, // optional, depends on your design
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: GestureDetector(
                                onTap: controller.skip,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: controller.skip,
                                    style: TextButton.styleFrom(
                                      foregroundColor: AppColors.primary,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: page.image != null
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        if (page.isTextPage) ...[
                          const SizedBox(height: 60),
                          Text(
                            page.title,
                            style: page.image != null
                                ? TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  )
                                : TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.description,
                            style: page.image != null
                                ? TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black54,
                                  )
                                : TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.black54,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                          ),
                        ] else ...[
                          const SizedBox(height: 16),
                          Padding(
                            padding: page.image != null
                                ? EdgeInsets.symmetric(
                                    horizontal: 12,
                                  )
                                : EdgeInsets.zero,
                            child: Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: page.image != null
                                  ? TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w900,
                                      height: 1.4,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Indicator
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: controller.currentPage.value == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? AppColors.primary
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              );
            }),
          ),

          // Button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06283D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    controller.currentPage.value == pages.length - 1
                        ? "Start"
                        : "Next ->",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageData {
  final String title;
  final String description;
  final String? image;
  final bool isTextPage;

  _OnboardingPageData({
    required this.title,
    required this.description,
    this.image,
    this.isTextPage = false,
  });
}
