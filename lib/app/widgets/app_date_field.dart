import 'package:flutter/material.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
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
    bool readOnly = true, // ✅ الخاصية الجديدة
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
                  readOnly: readOnly, // ✅ استخدام الخاصية هنا
                  onTap: readOnly ? null : () => _selectDate(state.context),
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

class AppTimeField extends FormField<TimeOfDay> {
  AppTimeField({
    Key? key,
    required String label,
    bool showLabel = true,
    Color labelColor = Colors.black,
    double radius = 30,
    FormFieldValidator<TimeOfDay>? validator,
    required Function(TimeOfDay) onTimeSelected,
    TimeOfDay? initialValue,
  }) : super(
          key: key,
          initialValue: initialValue ?? TimeOfDay.now(),
          validator: validator,
          builder: (FormFieldState<TimeOfDay> state) {
            TextEditingController _controller = TextEditingController(
              text:
                  state.value != null ? state.value!.format(state.context) : '',
            );

            Future<void> _selectTime(BuildContext context) async {
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: state.value ?? TimeOfDay.now(),
              );
              if (picked != null) {
                _controller.text = picked.format(context);
                state.didChange(picked);
                onTimeSelected(picked);
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
                  onTap: () => _selectTime(state.context),
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
                    suffixIcon:
                        const Icon(Icons.access_time, color: Color(0xFF0C2D48)),
                    errorText: state.errorText,
                  ),
                ),
              ],
            );
          },
        );
}

class DoseTimeFields extends StatelessWidget {
  final int doseCount; // عدد الجرعات
  final Function(int, TimeOfDay) onTimeSelected;
  final Function(String) onDateSelected;
  final String frequency;
  final Function(List<String>) onDaysSelected;

  const DoseTimeFields({
    Key? key,
    required this.doseCount,
    required this.onTimeSelected,
    required this.onDateSelected,
    required this.frequency,
    required this.onDaysSelected,
  }) : super(key: key);

//["daily", "weekly", "monthly"].obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),

//Dose Date Time
//initialValue is DateTime.now().toString() date only
        (frequency == "monthly")
            ? AppDateField(
                label: "Dose Date",
                initialValue: DateTime.now().toString().split(' ')[0],
                //   controller: TextEditingController(),
                readOnly: false,
                onDateSelected: (date) {
                  onDateSelected(date);
                },
              )
            : SizedBox(),

        (frequency != "daily") ? SizedBox(height: 16) : SizedBox(),

        (frequency == "weekly")
            ? AppBottomSheetMultiSelectField(
                label: "Dose Days",
                items: [
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday",
                  "Saturday",
                  "Sunday"
                ],
                onChanged: (value) {
                  onDaysSelected(value);
                },
              )
            : SizedBox(),
        (frequency != "daily") ? SizedBox(height: 16) : SizedBox(),

        Column(
          children: List.generate(
            doseCount,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AppTimeField(
                  label: "Dose ${index + 1} Time",
                  initialValue: TimeOfDay.now(),
                  onTimeSelected: (time) {
                    onTimeSelected(index, time);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
