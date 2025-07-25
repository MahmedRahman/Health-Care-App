import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:health_care_app/app/constants/colors.dart';
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
        title: const Text('Details'),
        centerTitle: false,
        backgroundColor: AppColorsMedications.primary,
      ),
      body: controller.obx((data) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              MedicineInfoCard(
                imagePath: data!.imagePath,
                medicineName: data.name,
                dose: data.dose,
                compliance: '80 %',
                doctorName: data.doctorName,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DayTimeline(
                  currentStep: 1,
                  steps: [
                    DoseStep(label: 'Dose 1', time: '9:00 AM'),
                    DoseStep(label: 'Dose 2', time: '3:00 PM'),
                    DoseStep(label: 'Dose 3', time: '6:00 PM'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ProgressStatusBar(
                      percentage: 0.5,
                      daysLeft: 12,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: LabelCard(
                            label: 'Route',
                            value: data.route,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: LabelCard(
                            label: 'Frequency',
                            value: data.frequency,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Timing
                    LabelCard(
                      label: 'Timing',
                      value: data.timings.join(', '),
                    ),
                    const SizedBox(height: 12),

                    // Duration with subtitle
                    LabelCard(
                      label: 'Duration',
                      subtitle: '2 weeks',
                      value: '16, Sep 2024 – 30, Des 2024',
                    ),
                    const SizedBox(height: 12),
                    LabelCard(
                      label: 'Description',
                      value: data.description,
                    ),
                    const SizedBox(height: 12),
                    LabelCard(
                      label: 'Specials Instruction',
                      value: 'Should be taken after food',
                    ),
                    const SizedBox(height: 12),

                    // Check Done Button
                    ActionButton(
                      icon: Icons.check_circle_outline,
                      label: 'Check Done',
                      onTap: () {
                        print('Check Done tapped');
                      },
                      bgColor: const Color(0xFFF0F5FF),
                      iconColor: const Color(0xFF0A2942),
                      isExpanded: true,
                    ),
                    const SizedBox(height: 12),

                    // Row with delete, edit, renew
                    Row(children: [
                      // Delete
                      ActionButton(
                        icon: Icons.delete_outline,
                        onTap: () {
                          print('Delete tapped');
                        },
                        bgColor: const Color(0xFFFFF0F0),
                        iconColor: Colors.red,
                      ),
                      const SizedBox(width: 12),

                      // Edit
                      ActionButton(
                        icon: Icons.edit_outlined,
                        onTap: () {
                          print('Edit tapped');
                        },
                      ),
                      const SizedBox(width: 12),

                      // Renew
                      Expanded(
                        child: ActionButton(
                          icon: Icons.refresh_outlined,
                          label: 'Renew',
                          onTap: () {
                            print('Renew tapped');
                          },
                          bgColor: const Color(0xFFF0F5FF),
                          iconColor: const Color(0xFF0A2942),
                          isExpanded: true,
                        ),
                      ),
                    ]),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
