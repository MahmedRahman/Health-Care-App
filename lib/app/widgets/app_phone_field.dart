import 'package:flutter/material.dart';
import 'package:health_care_app/app/constants/colors.dart';

class AppPhoneFieldForm extends FormField<String> {
  AppPhoneFieldForm({
    Key? key,
    required String label,
    required TextEditingController controller,
    String initialCode = "966",
    required List<String> countryCodes,
    required ValueChanged<String> onCodeChanged,
    FormFieldValidator<String>? validator,
    Color labelColor = Colors.grey,
  }) : super(
          key: key,
          initialValue: '$initialCode${controller.text}',
          validator: validator,
          builder: (FormFieldState<String> state) {
            String selectedCode = initialCode;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: labelColor,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: state.hasError ? Colors.red : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      DropdownButton<String>(
                        value: selectedCode,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.black54),
                        items: countryCodes.map((code) {
                          return DropdownMenuItem<String>(
                            value: code,
                            child: Text(
                              code,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textLight,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newCode) {
                          if (newCode != null) {
                            selectedCode = newCode;
                            onCodeChanged(newCode);
                            state.didChange('$selectedCode${controller.text}');
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.blue.shade900,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone number",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          onChanged: (val) {
                            state.didChange('$selectedCode$val');
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 12),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        );
}
