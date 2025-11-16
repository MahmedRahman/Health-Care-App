// filter_bottom_sheet.dart
// filter_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_app/app/widgets/app_drop_down_field.dart';
import 'package:intl/intl.dart';

class FilterBottomLabs extends GetView<FilterLabsController> {
  FilterLabsController controller = Get.put(FilterLabsController());

  String _fmt(DateTime? d) => d == null
      ? ''
      : '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const orange = Color(0xFFFDC61E0);
    const navy = Color(0xFF0E2A38);

    InputBorder _fieldBorder() => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        );

    Widget label(String text) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(text,
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xFF6B7C93),
                fontWeight: FontWeight.w600,
              )),
        );

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // drag handle
              Container(
                width: 48,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(4)),
              ),
              // header row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Filter',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: navy,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.resetAll,
                    child: Text('Reset',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: navy,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Align(alignment: Alignment.centerLeft, child: label('Lab Type')),

              // add dropdown for lab type selete one item

              AppBottomSheetSelectField(
                label: 'Lab Type',
                items: [
                  'Blood Test',
                  'Urine Test',
                  'X-Ray',
                  'CT Scan',
                  'MRI',
                  'Ultrasound',
                  'Endoscopy',
                  'Biopsy',
                  'Other'
                ],
                value: "Other",
                onChanged: (value) {
                  print(value);
                },
              ),

              const SizedBox(height: 8),
              Align(alignment: Alignment.centerLeft, child: label('Date')),

              // Date row
              Row(children: [
                Expanded(
                  child: Obx(() => InkWell(
                        onTap: () => controller.pickFromDate(context),
                        borderRadius: BorderRadius.circular(14),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            hintText: 'From',
                            suffixIcon:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                            border: _fieldBorder(),
                            enabledBorder: _fieldBorder(),
                            focusedBorder: _fieldBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          child: Text(
                            _fmt(controller.from.value).isEmpty
                                ? 'From'
                                : _fmt(controller.from.value),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: _fmt(controller.from.value).isEmpty
                                  ? Colors.black45
                                  : navy,
                            ),
                          ),
                        ),
                      )),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(() => InkWell(
                        onTap: () => controller.pickToDate(context),
                        borderRadius: BorderRadius.circular(14),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            hintText: 'To',
                            suffixIcon:
                                const Icon(Icons.keyboard_arrow_down_rounded),
                            border: _fieldBorder(),
                            enabledBorder: _fieldBorder(),
                            focusedBorder: _fieldBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                          child: Text(
                            _fmt(controller.to.value).isEmpty
                                ? 'To'
                                : _fmt(controller.to.value),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: _fmt(controller.to.value).isEmpty
                                  ? Colors.black45
                                  : navy,
                            ),
                          ),
                        ),
                      )),
                ),
              ]),

              // Sort selector (dropdown feel + list underneath like the mock)

              const SizedBox(height: 26),

              // Buttons
              Row(children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    onPressed: controller.apply,
                    child: const Text('Filter'),
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        side: const BorderSide(
                          color: Color(0xFF0E2A38),
                        ),
                        foregroundColor: navy,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: controller.resetAll,
                      child: const Text(
                        'Reset',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _SortTile(
      {required this.title, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
    );
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: ShapeDecoration(
          shape: border,
          color: selected ? const Color(0xFFF3F4F6) : Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600))),
            if (selected)
              const Icon(Icons.check_circle, color: Color(0xFFFF6A2A)),
          ],
        ),
      ),
    );
  }
}

class FilterLabsController extends GetxController {
  final from = Rxn<DateTime>();
  final to = Rxn<DateTime>();

  final formKey = GlobalKey<FormState>();

  // Pickers
  Future<void> pickFromDate(BuildContext context) async {
    final now = DateTime.now();
    final first = DateTime(now.year - 10);
    final last = DateTime(now.year + 10);
    final initial = from.value ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFFDC61E0), // لون الهيدرات والأزرار
              onPrimary: Colors.white, // لون النص داخل الهيدر
              surface: Color(0xFFFDC61E0), // لون الخلفية (الأساسية)
              onSurface: Colors.black, // لون النص داخل التقويم
            ),
            dialogBackgroundColor:
                Colors.yellow[50], // خلفية نافذة الـ dialog نفسها
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      from.value = picked;
      // keep consistency: if to < from, clear to
      if (to.value != null && to.value!.isBefore(picked)) {
        to.value = null;
      }
    }
  }

  Future<void> pickToDate(BuildContext context) async {
    final now = DateTime.now();
    final first = from.value ?? DateTime(now.year - 10);
    final last = DateTime(now.year + 10);
    final initial = to.value ?? (from.value ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFFDC61E0), // لون الهيدرات والأزرار
              onPrimary: Colors.white, // لون النص داخل الهيدر
              surface: Color(0xFFFDC61E0), // لون الخلفية (الأساسية)
              onSurface: Colors.black, // لون النص داخل التقويم
            ),
            dialogBackgroundColor:
                Colors.yellow[50], // خلفية نافذة الـ dialog نفسها
          ),
          child: child!,
        );
      },
    );
    if (picked != null) to.value = picked;
  }

  void resetAll() {
    from.value = null;
    to.value = null;
  }

  void apply() {
    if (!formKey.currentState!.validate()) return;
    final dateFormat = DateFormat('MM-dd-yyyy');
    Get.back(
      result: FilterResult(
        from:
            from.value != null ? dateFormat.format(from.value!).toString() : "",
        to: to.value != null ? dateFormat.format(to.value!).toString() : "",
      ),
    );
  }
}

class FilterResult {
  final String? from;
  final String? to;

  const FilterResult({this.from, this.to});
}
