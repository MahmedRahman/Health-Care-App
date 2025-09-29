// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:health_care_app/app/widgets/app_date_field.dart';
// import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
// import 'package:health_care_app/app/widgets/app_id_card.dart';
// import 'package:health_care_app/app/widgets/app_image_picker_box.dart';
// import 'package:health_care_app/app/widgets/app_text_field.dart';

// class ProfilePersonalInfo extends StatelessWidget {
//   const ProfilePersonalInfo({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 24.h),
//           Center(
//             child: AppImagePickerBox(
//               size: 120,
//               borderRadius: 20,
//               onImageSelected: (image) {}, controller: ,
//             ),
//           ),
//           SizedBox(height: 16.h),
//           AppTextField(
//             label: "First Name",
//             hintText: "Enter your first name",
//             controller: TextEditingController(),
//             keyboardType: TextInputType.text,
//             labelColor: Colors.black,
//             radius: 18,
//           ),
//           SizedBox(height: 16.h),
//           AppTextField(
//             label: "Last Name",
//             hintText: "Enter your last name",
//             controller: TextEditingController(),
//             keyboardType: TextInputType.text,
//             labelColor: Colors.black,
//             radius: 18,
//           ),
//           SizedBox(height: 16.h),
//           AppTextField(
//             label: "Phone Number",
//             hintText: "Enter your phone number",
//             controller: TextEditingController(),
//             keyboardType: TextInputType.phone,
//             labelColor: Colors.black,
//             radius: 18,
//           ),
//           SizedBox(height: 16.h),
//           AppTextField(
//             label: "Email Address",
//             hintText: "Enter your email address",
//             controller: TextEditingController(),
//             keyboardType: TextInputType.emailAddress,
//             labelColor: Colors.black,
//             radius: 18,
//           ),
//           SizedBox(height: 16.h),
//           //id
//           AppTextField(
//             label: "ID",
//             hintText: "Enter your ID",
//             controller: TextEditingController(),
//             keyboardType: TextInputType.number,
//             labelColor: Colors.black,
//             radius: 18,
//           ),
//           SizedBox(height: 16.h),
//           AppIdCard(
//             code: "123456789",
//             name: "John Doe",
//             password: "123456",
//             extraText: "Extra Text",
//           ),
//           SizedBox(height: 16.h),
//           Text(
//             "Address",
//             style: TextStyle(
//                 color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//           ),

//           Row(
//             children: [
//               Expanded(
//                 child: AppDropdownField(
//                   label: "Country",
//                   value: "UAE",
//                   items: ["UAE", "KSA", "Qatar", "Kuwait"],
//                   onChanged: (newValue) {
//                     if (newValue != null) {
//                       //selectedCountry = newValue;
//                     }
//                   },
//                   labelColor: Colors.black,
//                   radius: 12,
//                   showLabel: false,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: AppDropdownField(
//                   label: "City",
//                   value: "City 1",
//                   items: ["City 1", "City 2", "City 3", "City 4"],
//                   onChanged: (newValue) {
//                     if (newValue != null) {
//                       //selectedCountry = newValue;
//                     }
//                   },
//                   labelColor: Colors.black,
//                   radius: 12,
//                   showLabel: false,
//                 ),
//               ),
//             ],
//           ),
//           AppTextField(
//             label: "Address",
//             hintText: "Enter your address",
//             controller: TextEditingController(),
//             keyboardType: TextInputType.emailAddress,
//             showLabel: false,
//             radius: 12,
//           ),
//           AppTextField(
//             label: "Address",
//             hintText: "Enter your address",
//             controller: TextEditingController(),
//             keyboardType: TextInputType.emailAddress,
//             showLabel: false,
//             radius: 12,
//           ),
//           SizedBox(height: 16.h),
//           Row(
//             children: [
//               Expanded(
//                 child: AppDateField(
//                   label: "Date of Birth",
//                   showLabel: true,
//                   labelColor: Colors.black,
//                   radius: 12,
//                   onDateSelected: (date) {},
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: AppDropdownField(
//                   label: "Gender",
//                   value: "Male",
//                   items: ["Male", "Female"],
//                   onChanged: (newValue) {
//                     if (newValue != null) {
//                       //    selectedCountry = newValue;
//                     }
//                   },
//                   labelColor: Colors.black,
//                   radius: 12,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // Age
//           Row(
//             children: [
//               Expanded(
//                 child: AppTextField(
//                   label: "Age",
//                   hintText: "Age",
//                   controller: TextEditingController(),
//                   keyboardType: TextInputType.number,
//                   radius: 12,
//                   showLabel: true,
//                   labelColor: Colors.black,
//                   suffixText: "Years",
//                 ),
//               ),
//               const SizedBox(width: 16),
//               //Race
//               Expanded(
//                 child: AppTextField(
//                   label: "Race",
//                   hintText: "Race",
//                   controller: TextEditingController(),
//                   keyboardType: TextInputType.emailAddress,
//                   radius: 12,
//                   showLabel: true,
//                   labelColor: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),

//           //Weight and height
//           Row(
//             children: [
//               Expanded(
//                 child: AppTextField(
//                   label: "Weight",
//                   hintText: "Weight",
//                   controller: TextEditingController(),
//                   keyboardType: TextInputType.number,
//                   radius: 12,
//                   showLabel: true,
//                   labelColor: Colors.black,
//                   suffixText: "Kg",
//                 ),
//               ),
//               const SizedBox(width: 16),
//               //Height
//               Expanded(
//                 child: AppTextField(
//                   label: "Height",
//                   hintText: "Height",
//                   controller: TextEditingController(),
//                   keyboardType: TextInputType.number,
//                   radius: 12,
//                   showLabel: true,
//                   labelColor: Colors.black,
//                   suffixText: "Cm",
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),

//           //BSA and BMI
//           Row(
//             children: [
//               Expanded(
//                 child: AppTextField(
//                   label: "BSA",
//                   hintText: "BSA",
//                   controller: TextEditingController(),
//                   keyboardType: TextInputType.number,
//                   radius: 12,
//                   showLabel: true,
//                   labelColor: Colors.black,
//                   suffixText: "m2",
//                 ),
//               ),
//               const SizedBox(width: 16),
//               //BMI
//               Expanded(
//                 child: AppTextField(
//                   label: "BMI",
//                   hintText: "BMI",
//                   controller: TextEditingController(),
//                   keyboardType: TextInputType.number,
//                   radius: 12,
//                   showLabel: true,
//                   labelColor: Colors.black,
//                   suffixText: "kg/m2",
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 16.h),

//           //Marital  State and Language drop down
//           Row(
//             children: [
//               Expanded(
//                 child: AppDropdownField(
//                   label: "Marital State",
//                   value: "Single",
//                   items: ["Single", "Married", "Divorced", "Widowed"],
//                   onChanged: (newValue) {
//                     if (newValue != null) {
//                       // selectedCountry = newValue;
//                     }
//                   },
//                   labelColor: Colors.black,
//                   radius: 12,
//                   showLabel: true,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: AppDropdownField(
//                   label: "Language",
//                   value: "English",
//                   items: ["English", "Arabic", "French", "Spanish"],
//                   onChanged: (newValue) {
//                     if (newValue != null) {
//                       // selectedCountry = newValue;
//                     }
//                   },
//                   labelColor: Colors.black,
//                   radius: 12,
//                   showLabel: true,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
