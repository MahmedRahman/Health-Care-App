import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppBottomSheetDropdown extends FormField<String> {
  AppBottomSheetDropdown({
    Key? key,
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
    FormFieldValidator<String>? validator,
    bool showLabel = true,
    Color labelColor = Colors.black,
    double radius = 30,
    String icon = '',
  }) : super(
          key: key,
          initialValue: value,
          validator: validator,
          builder: (FormFieldState<String> state) {
            void _openBottomSheet() {
              Get.bottomSheet(
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: SafeArea(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected = item == state.value;
                        return ListTile(
                          title: Text(
                            item,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected ? Colors.blue : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: Colors.blue)
                              : null,
                          onTap: () {
                            Get.back();
                            state.didChange(item);
                            onChanged(item);
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            }

            return GestureDetector(
              onTap: _openBottomSheet,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showLabel)
                    icon.isNotEmpty
                        ? Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radius),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(icon,
                                    width: 24, height: 24),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: labelColor,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            label,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: labelColor,
                            ),
                          ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(
                        color:
                            state.hasError ? Colors.red : Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.value?.isEmpty ?? true
                              ? 'Select...'
                              : state.value!,
                          style: TextStyle(
                            fontSize: 16,
                            color: state.value?.isEmpty ?? true
                                ? Colors.grey
                                : Colors.black87,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down,
                            color: Color(0xFF0C2D48)),
                      ],
                    ),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 8),
                      child: Text(
                        state.errorText ?? '',
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            );
          },
        );
}
