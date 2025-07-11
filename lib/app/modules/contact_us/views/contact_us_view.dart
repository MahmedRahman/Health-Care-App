import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:health_care_app/app/widgets/app_primary_button.dart';
import 'package:health_care_app/app/widgets/app_text_area.dart';
import 'package:health_care_app/app/widgets/app_text_field.dart';

import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        //title: const Text('ContactUsView'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SvgPicture.asset("assets/svg/info.svg"),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  "We’re Here To Help..!",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              AppTextField(
                label: "Name",
                hintText: "Enter your name",
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                labelColor: Colors.black,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                label: "Email",
                hintText: "Enter your email",
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                labelColor: Colors.black,
              ),
              SizedBox(height: 16.h),
              AppTextField(
                label: "Subject",
                hintText: "Enter your subject",
                controller: TextEditingController(),
                keyboardType: TextInputType.phone,
                labelColor: Colors.black,
              ),
              SizedBox(height: 16.h),
              AppTextArea(
                label: "Message",
                hintText: "Enter your message",
                controller: TextEditingController(),
                labelColor: Colors.black,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: AppPrimaryButton(
                      text: "Send Message",
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 48.w,
                    height: 48.w,
                    child: AppIconButtonSvg(
                      onPressed: () {
                        print("Facebook button pressed!");
                      },
                      assetPath: 'assets/svg/apple.svg',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ContactInfoItem(
                    icon: "assets/svg/call.svg",
                    label: "Phone",
                    value: "55 215647",
                  ),
                  SizedBox(height: 16.h),
                  ContactInfoItem(
                    icon: "assets/svg/email.svg",
                    label: "Email",
                    value: "walid.eltahlawy@gmail.com",
                  ),
                  SizedBox(height: 16.h),
                  ContactInfoItem(
                    icon: "assets/svg/map.svg",
                    label: "Adress",
                    value: "address text here",
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactInfoItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color valueColor;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = Colors.black,
    this.valueColor = const Color(0xFF0C2D48), // الأزرق الغامق
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: "$label: ",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
