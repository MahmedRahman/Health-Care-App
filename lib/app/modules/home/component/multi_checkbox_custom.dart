import 'package:flutter/material.dart';
import 'package:health_care_app/app/constants/colors.dart';

/// Reusable component (no enums)
class MultiCheckboxCustom extends StatelessWidget {
  MultiCheckboxCustom({
    super.key,
    required this.value, // <- your input variable
    required this.onChanged, // <- returns updated map
    this.title = 'Blood Pressure Parameters',
    this.accentColor,
    this.labelColor,
  });

  /// Input selection, e.g. { "sbp": true, "dbp": true, "map": false }
  final List<Map<String, dynamic>> value;

  /// Emits the updated map when any item toggles
  final ValueChanged<List<Map<String, dynamic>>> onChanged;

  final String title;
  final Color? accentColor;
  Color? labelColor = Color(0xff728098);

  bool _isSelected(String key) =>
      value.firstWhere((e) => e["key"] == key)["value"];

  void _toggle(String key) {
    final next = value.map((e) => {e["key"]: !(e["value"] ?? false)}).toList();
    //  onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final c = accentColor ?? Colors.black;
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: c.withOpacity(0.8), fontWeight: FontWeight.w600);

    Widget item(String label, String key) {
      final selected = _isSelected(key);
      return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => _toggle(key),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: selected ? c : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: c, width: 2),
                ),
                alignment: Alignment.center,
                child: selected
                    ? const Icon(Icons.check, size: 18, color: Colors.white)
                    : const SizedBox.shrink(),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textStyle?.copyWith(color: labelColor)),
        const SizedBox(height: 12),
        for (final opt in value) item(opt["label"]!, opt["key"]!),
      ],
    );
  }
}
