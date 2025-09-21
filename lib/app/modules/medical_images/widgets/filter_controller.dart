// filter_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// filter_result.dart
enum SortOrder { newestFirst, oldestFirst }

class FilterResult {
  final DateTime? from;
  final DateTime? to;
  final SortOrder? sort;

  const FilterResult({this.from, this.to, this.sort});

  FilterResult copyWith({DateTime? from, DateTime? to, SortOrder? sort}) =>
      FilterResult(
          from: from ?? this.from, to: to ?? this.to, sort: sort ?? this.sort);

  bool get isEmpty => from == null && to == null && sort == null;
}

class FilterController extends GetxController {
  final from = Rxn<DateTime>();
  final to = Rxn<DateTime>();
  final sort = Rxn<SortOrder>(); // null = "Select"

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
    );
    if (picked != null) to.value = picked;
  }

  void selectSort(SortOrder value) => sort.value = value;

  void resetAll() {
    from.value = null;
    to.value = null;
    sort.value = null;
  }

  void apply() {
    Get.back(
      result: FilterResult(from: from.value, to: to.value, sort: sort.value),
    );
  }
}
