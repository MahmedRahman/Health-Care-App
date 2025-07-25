import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateField extends FormField<String> {
  AppDateField({
    Key? key,
    required String label,
    bool showLabel = true,
    Color labelColor = Colors.black,
    double radius = 30,
    FormFieldValidator<String>? validator,
    required Function(String) onDateSelected,
    String? initialValue,
    TextEditingController? controller,
  }) : super(
          key: key,
          initialValue: initialValue ?? "05/05/1995",
          validator: validator,
          builder: (FormFieldState<String> state) {
            final TextEditingController _controller =
                controller ?? TextEditingController();

            if (_controller.text.isEmpty && state.value != null) {
              _controller.text = state.value!;
            }
            Future<void> _selectDate(BuildContext context) async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate:
                    DateFormat('dd/MM/yyyy').parse(state.value ?? "05/05/1995"),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                String formatted = DateFormat('dd/MM/yyyy').format(picked);
                _controller.text = formatted;
                state.didChange(formatted);
                onDateSelected(formatted);
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showLabel)
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: labelColor,
                    ),
                  ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _controller,
                  readOnly: true,
                  onTap: () => _selectDate(state.context),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 20),
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.calendar_today,
                        color: Color(0xFF0C2D48)),
                    errorText: state.errorText,
                  ),
                ),
              ],
            );
          },
        );
}
