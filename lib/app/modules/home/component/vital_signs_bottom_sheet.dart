import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';

final List<Map<String, dynamic>> chartData = List.generate(365, (index) {
  final date = DateTime(2025, 1, 1).add(Duration(days: index));
  final yValue = 60 + Random().nextInt(60); // مثلاً من 60 لـ 120 bpm

  return {
    "x": index.toDouble(),
    "y": yValue.toDouble(),
    "date":
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
});

final List<Map<String, dynamic>> line2ChartData = List.generate(365, (index) {
  final date = DateTime(2025, 1, 1).add(Duration(days: index));
  final yValue = 60 + Random().nextInt(60); // مثلاً من 60 لـ 120 bpm

  return {
    "x": index.toDouble(),
    "y": yValue.toDouble(),
    "date":
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
});

final List<Map<String, dynamic>> line3ChartData = List.generate(365, (index) {
  final date = DateTime(2025, 1, 1).add(Duration(days: index));
  final yValue = 60 + Random().nextInt(60); // مثلاً من 60 لـ 120 bpm

  return {
    "x": index.toDouble(),
    "y": yValue.toDouble(),
    "date":
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
});

List<Map<String, dynamic>> toDailyData(List<Map<String, dynamic>> data) {
  return data.map((item) {
    final date = DateTime.parse(item['date']);
    return {
      "x": item['x'],
      "y": item['y'],
      "date": item['date'],
      "label": "${date.day}/${date.month}",
    };
  }).toList();
}

List<Map<String, dynamic>> getWeeklyChartData(
    List<Map<String, dynamic>> yearlyData) {
  final List<Map<String, dynamic>> weeklyData = [];

  // نقسم الداتا إلى أسابيع (كل أسبوع = 7 أيام)
  for (int i = 0; i < yearlyData.length; i += 7) {
    final weekData = yearlyData.sublist(
      i,
      i + 7 > yearlyData.length ? yearlyData.length : i + 7,
    );

    final avgY = weekData.map((e) => e['y'] as double).reduce((a, b) => a + b) /
        weekData.length;

    final startDate = DateTime.parse(weekData.first['date']);
    final endDate = DateTime.parse(weekData.last['date']);

    weeklyData.add({
      "x": (i / 7).toDouble(), // رقم الأسبوع
      "y": avgY,
      "label": "الأسبوع ${(i ~/ 7) + 1}",
      "dateRange":
          "${startDate.day}/${startDate.month} - ${endDate.day}/${endDate.month}",
    });
  }

  return weeklyData;
}

List<Map<String, dynamic>> toMonthlyData(List<Map<String, dynamic>> data) {
  Map<int, List<Map<String, dynamic>>> months = {};

  for (var item in data) {
    final date = DateTime.parse(item['date']);
    final month = date.month;

    months.putIfAbsent(month, () => []);
    months[month]!.add(item);
  }

  List<Map<String, dynamic>> result = [];
  months.forEach((month, items) {
    final yAvg = items.map((e) => e['y'] as double).reduce((a, b) => a + b) /
        items.length;
    final firstDate = DateTime.parse(items.first['date']);

    result.add({
      "x": month.toDouble() - 1,
      "y": yAvg,
      "date": items.first['date'],
      "label": "${_monthName(firstDate.month)}",
    });
  });

  return result;
}

String _monthName(int month) {
  const names = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر"
  ];
  return names[month - 1];
}

class VitalSignsBottomSheet extends GetView {
  final void Function() onFilterPressed;
  final void Function() onAddPressed;
  final String title;
  final String value;
  final String unit;
  final Color? keyColor;
  final List<Map<String, dynamic>> chartData;
  final List<Map<String, dynamic>> line2ChartData;
  final List<Map<String, dynamic>> line3ChartData;

  VitalSignsBottomSheet({
    super.key,
    required this.onFilterPressed,
    required this.onAddPressed,
    required this.title,
    required this.value,
    required this.unit,
    required this.keyColor,
    required this.chartData,
    this.line2ChartData = const [],
    this.line3ChartData = const [],
  });

  List<FlSpot> get chartSpots => chartData
      .map((point) => FlSpot(
            point['x'].toDouble(),
            point['y'].toDouble(),
          ))
      .toList();

  List<FlSpot> get line2Spots => line2ChartData
      .map((point) => FlSpot(
            point['x'].toDouble(),
            point['y'].toDouble(),
          ))
      .toList();

  List<FlSpot> get line3Spots => line3ChartData
      .map((point) => FlSpot(
            point['x'].toDouble(),
            point['y'].toDouble(),
          ))
      .toList();

  double get minY {
    final ys = chartData.map((e) => e['y'] as double).toList();
    return (ys.reduce(min) - 10).clamp(0, double.infinity);
  }

  double get maxY {
    final ys = chartData.map((e) => e['y'] as double).toList();
    return (ys.reduce(max) + 10);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SizedBox(width: 4.w),
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: keyColor,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        unit,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: keyColor,
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 32.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 230,
                      width: chartData.length * 50,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: LineChart(
                          LineChartData(
                            showingTooltipIndicators: [],
                            gridData: FlGridData(show: true),
                            clipData: FlClipData(
                              top: false,
                              bottom: false,
                              left: false,
                              right: false,
                            ),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  reservedSize: 40, // جرّب 32-40 حسب الخط
                                  getTitlesWidget: (value, meta) {
                                    final matchedPoint = chartData.firstWhere(
                                      (item) =>
                                          (item['x'] as num).toDouble() ==
                                          value,
                                      orElse: () => {"label": ""},
                                    );
                                    final label =
                                        (matchedPoint['label'] ?? '') as String;

                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 6, // مسافة بين الرسم والعنوان
                                      child: Text(
                                        label,
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.grey),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 42,
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 20,
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: 0,
                            maxX: chartData.length.toDouble() - 1,
                            minY: minY,
                            maxY: maxY + 20,
                            lineBarsData: [
                              LineChartBarData(
                                isCurved: true,
                                color: Colors.green,
                                barWidth: 2,
                                belowBarData: BarAreaData(show: false),
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter: (spot, percent, bar, index) {
                                    return FlDotCirclePainter(
                                      radius: 4,
                                      color: Colors.green,
                                      strokeWidth: 1,
                                      strokeColor: Colors.white,
                                    );
                                  },
                                ),
                                spots: chartSpots,
                              ),
                              LineChartBarData(
                                isCurved: true,
                                color: Colors.red,
                                barWidth: 2,
                                belowBarData: BarAreaData(show: false),
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter: (spot, percent, bar, index) {
                                    return FlDotCirclePainter(
                                      radius: 4,
                                      color: Colors.red,
                                      strokeWidth: 1,
                                      strokeColor: Colors.white,
                                    );
                                  },
                                ),
                                spots: line2Spots,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
