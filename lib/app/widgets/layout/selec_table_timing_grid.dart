import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectableTimingGrid extends FormField<Set<String>> {
  SelectableTimingGrid({
    Key? key,
    required List<List<String>> timings,
    bool multiSelect = true,
    FormFieldValidator<Set<String>>? validator,
    Function(Set<String>)? onSelectionChanged,
    Set<String>? initialSelectedTimes,
    bool showLabel = true,
    bool showIcon = true,
  }) : super(
          key: key,
          initialValue: initialSelectedTimes ?? <String>{},
          validator: validator,
          builder: (FormFieldState<Set<String>> state) {
            final TimingController controller = Get.put(TimingController());

            /// ✅ تأجيل إعداد القيم المبدئية لما بعد build
            if (initialSelectedTimes != null &&
                controller.selectedTimes.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                controller.setInitialSelection(initialSelectedTimes);
                state.didChange(initialSelectedTimes);
              });
            }

            void handleTap(String time) {
              controller.toggleSelection(time, multiSelect: multiSelect);
              state.didChange(controller.selectedTimes.toSet());
              if (onSelectionChanged != null) {
                onSelectionChanged(controller.selectedTimes.toSet());
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showLabel)
                  Row(
                    children: [
                      if (showIcon) Icon(Icons.alarm, color: Colors.black54),
                      SizedBox(width: 8),
                      Text(
                        'Timing',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                Obx(() => Column(
                      children: timings.map((row) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: row.map((time) {
                              final isSelected =
                                  controller.selectedTimes.contains(time);

                              return Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: GestureDetector(
                                  onTap: () => handleTap(time),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF4A90E2)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF4A90E2)
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Text(
                                      time,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF4A90E2),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    )),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Text(
                      state.errorText ?? '',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}

class TimingController extends GetxController {
  final RxSet<String> selectedTimes = <String>{}.obs;

  void toggleSelection(String time, {bool multiSelect = true}) {
    if (multiSelect) {
      if (selectedTimes.contains(time)) {
        selectedTimes.remove(time);
      } else {
        selectedTimes.add(time);
      }
    } else {
      if (selectedTimes.contains(time)) {
        selectedTimes.clear();
      } else {
        selectedTimes.value = {time};
      }
    }
  }

  void setInitialSelection(Set<String> times) {
    selectedTimes.assignAll(times);
  }

  void clearSelection() {
    selectedTimes.clear();
  }
}
