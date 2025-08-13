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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              Row(
                children: [
                  Text(
                    "Vital signs",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  AppIconButtonSvg(
                    assetPath: 'assets/svg/filter.svg',
                    iconSize: 32.w,
                    onPressed: onFilterPressed,
                  ),
                  SizedBox(width: 4.w),
                  AppIconButtonSvg(
                    assetPath: 'assets/svg/plus.svg',
                    iconSize: 32.w,
                    onPressed: onAddPressed,
                  ),
                  SizedBox(width: 4.w),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            'assets/svg/info-empty.svg',
                            width: 24.w,
                            height: 24.h,
                          ),
                          const Spacer(),
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
                    SizedBox(height: 0.h),

                    // ✅ Line Chart with scroll
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 32.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height: 230,
                          width: chartData.length * 50,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
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
                                    getTitlesWidget: (value, meta) {
                                      final matchedPoint = chartData.firstWhere(
                                        (item) => item['x'].toDouble() == value,
                                        orElse: () => {"label": ""},
                                      );

                                      final label = matchedPoint['label'] ?? '';

                                      return Text(
                                        label,
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.grey),
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
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
