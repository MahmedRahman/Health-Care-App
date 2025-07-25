import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/app/constants/colors.dart';

class AppAgreementCheckForm extends FormField<bool> {
  AppAgreementCheckForm({
    Key? key,
    required VoidCallback onTermsTap,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          key: key,
          initialValue: initialValue,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<bool> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primary,
                      value: state.value ?? false,
                      onChanged: (val) => state.didChange(val),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "Clicking Next means you agree to the ",
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Terms of Use",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.grey,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = onTermsTap,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 4),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}
