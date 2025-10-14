import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;

  /// اختياري: controller أو value
  final TextEditingController? controller;
  final String? value;

  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final AutovalidateMode autovalidateMode;

  final bool showLabel;
  final Color labelColor;
  final double radius;
  final String icon;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.controller,
    this.value,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.showLabel = true,
    this.labelColor = Colors.black,
    this.radius = 30,
    this.icon = '',
  });

  @override
  Widget build(BuildContext context) {
    // priority: controller.text > value
    final currentValue =
        controller?.text.isNotEmpty == true ? controller!.text : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          if (icon.isNotEmpty)
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(icon),
                ),
                const SizedBox(width: 8),
                Text(label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: labelColor)),
              ],
            )
          else
            Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: labelColor)),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: currentValue?.isEmpty == true ? null : currentValue,
              isExpanded: true,
              autovalidateMode: autovalidateMode,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              icon: const Icon(Icons.keyboard_arrow_down,
                  color: Color(0xFF0C2D48)),
              items: items
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16)),
                      ))
                  .toList(),
              onChanged: (v) {
                if (controller != null) controller!.text = v ?? '';
                if (onChanged != null) onChanged!(v);
              },
              validator: validator,
              onSaved: (v) {
                if (controller != null) controller!.text = v ?? '';
                if (onSaved != null) onSaved!(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class AppBottomSheetSelectField extends StatelessWidget {
  final String label;
  final List<String> items;

  /// اختياري: controller أو value (الأولوية للـ controller)
  final TextEditingController? controller;
  final String? value;

  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final AutovalidateMode autovalidateMode;

  // UI
  final bool showLabel;
  final Color labelColor;
  final double radius;
  final String icon;
  final String? hintText;
  final bool enableSearch;

  const AppBottomSheetSelectField({
    super.key,
    required this.label,
    required this.items,
    this.controller,
    this.value,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.showLabel = true,
    this.labelColor = Colors.black,
    this.radius = 30,
    this.icon = '',
    this.hintText,
    this.enableSearch = false,
  });

  String? get _currentValue =>
      (controller?.text.isNotEmpty ?? false) ? controller!.text : value;

  @override
  Widget build(BuildContext context) {
    final currentValue = _currentValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          if (icon.isNotEmpty)
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(icon),
                ),
                const SizedBox(width: 8),
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
          else
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: labelColor,
              ),
            ),
          const SizedBox(height: 8),
        ],

        // Form wrapper to get validator + onSaved
        FormField<String>(
          initialValue: currentValue,
          autovalidateMode: autovalidateMode,
          validator: validator,
          onSaved: (v) {
            // Sync back to controller if present
            if (controller != null) controller!.text = v ?? '';
            onSaved?.call(v);
          },
          builder: (state) {
            final error = state.errorText;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(radius),
                  onTap: () async {
                    final picked = await _showPicker(
                      context: context,
                      items: items,
                      initial: (controller?.text.isNotEmpty ?? false)
                          ? controller!.text
                          : value,
                      title: label,
                      enableSearch: enableSearch,
                    );
                    if (picked != null) {
                      // Update form + controller + external callback
                      state.didChange(picked);
                      if (controller != null) controller!.text = picked;
                      onChanged?.call(picked);
                    }
                  },
                  child: InputDecorator(
                    isEmpty: (currentValue == null || currentValue!.isEmpty),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(radius),
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      errorText: error,
                      suffixIcon: const Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF0C2D48)),
                    ),
                    child: Text(
                      (state.value ?? currentValue) ?? (hintText ?? 'Select'),
                      style: TextStyle(
                        color: (state.value ?? currentValue) == null
                            ? Colors.grey
                            : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (error != null) ...[
                  const SizedBox(height: 6),
                  Text(error,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Future<String?> _showPicker({
    required BuildContext context,
    required List<String> items,
    String? initial,
    String? title,
    bool enableSearch = false,
  }) async {
    String? temp = initial;
    List<String> filtered = List.of(items);
    final controller = TextEditingController();

    return await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            void filter(String q) {
              setState(() {
                filtered = items
                    .where((e) => e.toLowerCase().contains(q.toLowerCase()))
                    .toList();
              });
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                  if (enableSearch)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: TextField(
                        controller: controller,
                        onChanged: filter,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (ctx, i) {
                        final item = filtered[i];
                        return RadioListTile<String>(
                          value: item,
                          groupValue: temp,
                          onChanged: (v) => setState(() => temp = v),
                          title: Text(item),
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop(temp),
                          child: const Text('Select'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AppBottomSheetMultiSelectField extends StatelessWidget {
  final String label;
  final List<String> items;

  // Form value (قائمة القيم المختارة)
  final List<String>? value;
  final ValueChanged<List<String>>? onChanged;
  final FormFieldValidator<List<String>>? validator;
  final FormFieldSetter<List<String>>? onSaved;
  final AutovalidateMode autovalidateMode;

  // UI
  final String? hintText;
  final double radius;
  final bool enableSearch;
  final bool showChips; // عرض الـ Chips تحت الحقل
  final int? maxSelect; // حد أقصى للاختيار

  const AppBottomSheetMultiSelectField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.hintText,
    this.radius = 12,
    this.enableSearch = true,
    this.showChips = true,
    this.maxSelect,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<List<String>>(
      initialValue: (value ?? const []),
      autovalidateMode: autovalidateMode,
      validator: validator,
      onSaved: onSaved,
      builder: (state) {
        final current = state.value ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: () async {
                final picked = await _showPicker(
                  context: context,
                  items: items,
                  initial: current,
                  title: label,
                  enableSearch: enableSearch,
                  maxSelect: maxSelect,
                );
                if (picked != null) {
                  state.didChange(picked);
                  onChanged?.call(picked);
                }
              },
              child: InputDecorator(
                isEmpty: current.isEmpty,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  errorText: state.errorText,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down,
                      color: Color(0xFF0C2D48)),
                ),
                child: Text(
                  current.isEmpty
                      ? (hintText ?? 'Select')
                      : '${current.length} selected',
                  style: TextStyle(
                    color: current.isEmpty ? Colors.grey : Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            if (showChips && current.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: current.map((e) {
                  return Chip(
                    label: Text(e),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () {
                      final next = List<String>.from(current)..remove(e);
                      state.didChange(next);
                      onChanged?.call(next);
                    },
                    backgroundColor: const Color(0xFFE9F0F6),
                  );
                }).toList(),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<List<String>?> _showPicker({
    required BuildContext context,
    required List<String> items,
    required List<String> initial,
    String? title,
    bool enableSearch = true,
    int? maxSelect,
  }) async {
    final selected = {...initial}; // Set for easy toggle
    List<String> filtered = List.of(items);
    final searchCtrl = TextEditingController();

    return await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setState) {
          void filter(String q) {
            setState(() {
              filtered = items
                  .where((e) => e.toLowerCase().contains(q.toLowerCase()))
                  .toList();
            });
          }

          void toggle(String item) {
            setState(() {
              if (selected.contains(item)) {
                selected.remove(item);
              } else {
                if (maxSelect == null || selected.length < maxSelect) {
                  selected.add(item);
                }
              }
            });
          }

          return Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Text('${selected.length}'
                            '${maxSelect != null ? '/$maxSelect' : ''}'),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                if (enableSearch)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: TextField(
                      controller: searchCtrl,
                      onChanged: filter,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      final item = filtered[i];
                      final checked = selected.contains(item);
                      final disabled = !checked &&
                          maxSelect != null &&
                          selected.length >= maxSelect;
                      return CheckboxListTile(
                        value: checked,
                        onChanged: disabled ? null : (_) => toggle(item),
                        title: Text(item),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.of(ctx).pop(selected.toList()),
                        child: const Text('Done'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
