import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_care_app/app/constants/colors.dart';
import 'package:health_care_app/app/helper/dialog_show_confirm.dart';
import 'package:health_care_app/app/modules/medications/component/day_time_line.dart';
import 'package:health_care_app/app/modules/medications/component/progress_status_bar.dart';
import 'package:health_care_app/app/modules/medicine_details/component/action_button.dart';
import 'package:health_care_app/app/modules/medicine_details/component/label_card.dart';
import 'package:health_care_app/app/modules/medicine_details/component/medicine_info_card.dart';

import '../controllers/medicine_details_controller.dart';

class MedicineDetailsView extends GetView<MedicineDetailsController> {
  const MedicineDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsMedications.grey,
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: AppColorsMedications.primary,
      ),
      body: controller.obx(
        (data) {
          var rawValue = data['doseCompliance']?.toString() ?? '0';
          var cleaned = rawValue.replaceAll('%', '').trim(); // "0"
          var progress = double.tryParse(cleaned) ?? 0.0;

          var progress_value = (double.tryParse((data['doseCompliance']
                          ?.toString()
                          .replaceAll('%', '')
                          .trim()) ??
                      '0') ??
                  0.0) /
              100;

          return RefreshIndicator(
            onRefresh: () async {
              controller.featchMedications(data['id']?.toString() ?? '');
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  MedicineInfoCard(
                    imagePath: data['medicineImage']! ?? '' ?? '',
                    medicineName: data['medicineName']! ?? '' ?? '',
                    dose: data['dose']?.toString() ?? '',
                    compliance: data['doseCompliance']! ?? '' ?? '',
                    doctorName: data['doctorName']?.toString() ?? '',
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DayTimeline(
                      currentStep: 1,
                      steps: (data['doseTimeList'] as List<dynamic>?)
                              ?.map((e) => DoseStep(
                                  label: 'Dose ',
                                  time: e['doseTime'].toString()))
                              .toList() ??
                          [],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        ProgressStatusBar(
                          percentage: progress_value,
                          daysLeft: data['leftDosesCount']! ?? '0' ?? '0',
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: LabelCard(
                                label: 'Route',
                                value: data['doseRoute']! ?? '' ?? '',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: LabelCard(
                                label: 'Frequency',
                                value: data['doseFrequency']! ?? '' ?? '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Timing
                        LabelCard(
                          label: 'Timing',
                          value: (data['doseTimeList'] as List<dynamic>?)
                                  ?.map((e) => e['doseTime'].toString())
                                  .join(', ') ??
                              '',
                        ),
                        SizedBox(height: 12.h),

                        // Duration with subtitle
                        LabelCard(
                          label: 'Duration',
                          subtitle:
                              '${data['doseDuration']} ${data['doseDurationList']}',
                          value: '16, Sep 2024 – 30, Des 2024',
                        ),
                        SizedBox(height: 12.h),
                        LabelCard(
                          label: 'Description',
                          value: data['description']?.toString() ?? '',
                        ),
                        SizedBox(height: 12.h),
                        LabelCard(
                          label: 'Specials Instruction',
                          value: data['specialInstructions']?.toString() ?? '',
                        ),
                        SizedBox(height: 12.h),

                        // Check Done Button
                        ActionButton(
                          icon: Icons.check_circle_outline,
                          label: 'Check Done',
                          onTap: () {
                            controller.checkDone(data['id']?.toString() ?? '');
                          },
                          bgColor: const Color(0xFFF0F5FF),
                          iconColor: const Color(0xFF0A2942),
                          isExpanded: true,
                        ),
                        SizedBox(height: 12.h),

                        // Row with delete, edit, renew
                        Row(
                          children: [
                            // Delete
                            ActionButton(
                              icon: Icons.delete_outline,
                              onTap: () async {
                                controller.deleteMedicine(
                                  data['id']?.toString() ?? '',
                                );
                              },
                              bgColor: const Color(0xFFFFF0F0),
                              iconColor: Colors.red,
                            ),
                            SizedBox(width: 12.w),

                            // Edit
                            ActionButton(
                              icon: Icons.edit_outlined,
                              onTap: () {},
                            ),
                            SizedBox(width: 12.w),

                            // Renew
                            Expanded(
                              child: ActionButton(
                                icon: Icons.refresh_outlined,
                                label: 'Renew',
                                onTap: () {
                                  controller.renewMedicine(
                                    data['id']?.toString() ?? '',
                                  );
                                },
                                bgColor: const Color(0xFFF0F5FF),
                                iconColor: const Color(0xFF0A2942),
                                isExpanded: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
