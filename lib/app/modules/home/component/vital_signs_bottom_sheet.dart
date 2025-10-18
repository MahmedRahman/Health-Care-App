import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care_app/app/widgets/app_icon_button_svg.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class _Bounds {
  final double minX, maxX, minY, maxY;
  const _Bounds(this.minX, this.maxX, this.minY, this.maxY);
}

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
    DateTime date;
    try {
      // Try parsing as DD/MM/YYYY format first
      date = DateFormat('dd/MM/yyyy').parse(item['date']);
    } catch (e) {
      try {
        // Fallback to ISO format
        date = DateTime.parse(item['date']);
      } catch (e2) {
        // If both fail, use current date as fallback
        date = DateTime.now();
      }
    }
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

// class VitalSignsBottomSheet extends GetView {
//   final void Function() onFilterPressed;
//   final void Function() onAddPressed;
//   final String title;
//   final String value;
//   final String unit;
//   final Color? keyColor;
//   final List<Map<String, dynamic>> chartData;
//   final List<Map<String, dynamic>> line2ChartData;
//   final List<Map<String, dynamic>> line3ChartData;

//   VitalSignsBottomSheet({
//     super.key,
//     required this.onFilterPressed,
//     required this.onAddPressed,
//     required this.title,
//     required this.value,
//     required this.unit,
//     required this.keyColor,
//     required this.chartData,
//     this.line2ChartData = const [],
//     this.line3ChartData = const [],
//   });

//   List<FlSpot> get chartSpots => chartData
//       .map((point) => FlSpot(
//             point['x'].toDouble(),
//             point['y'].toDouble(),
//           ))
//       .toList();

//   List<FlSpot> get line2Spots => line2ChartData
//       .map((point) => FlSpot(
//             point['x'].toDouble(),
//             point['y'].toDouble(),
//           ))
//       .toList();

//   List<FlSpot> get line3Spots => line3ChartData
//       .map((point) => FlSpot(
//             point['x'].toDouble(),
//             point['y'].toDouble(),
//           ))
//       .toList();

//   double get minY {
//     final ys = chartData.map((e) => e['y'] as double).toList();
//     return (ys.reduce(min) - 10).clamp(0, double.infinity);
//   }

//   double get maxY {
//     final ys = chartData.map((e) => e['y'] as double).toList();
//     return (ys.reduce(max) + 10);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(color: Colors.black12),
//             ),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     children: [
//                       SizedBox(width: 4.w),
//                       Text(
//                         value,
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.w500,
//                           color: keyColor,
//                         ),
//                       ),
//                       SizedBox(width: 4.w),
//                       Text(
//                         unit,
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w500,
//                           color: keyColor,
//                         ),
//                       ),
//                       SizedBox(width: 4.w),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0, right: 32.0),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: SizedBox(
//                       height: 230,
//                       width: chartData.length * 50,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 15),
//                         child: LineChart(
//                           LineChartData(
//                             showingTooltipIndicators: [],
//                             gridData: FlGridData(show: true),
//                             clipData: FlClipData(
//                               top: false,
//                               bottom: false,
//                               left: false,
//                               right: false,
//                             ),
//                             titlesData: FlTitlesData(
//                               bottomTitles: AxisTitles(
//                                 sideTitles: SideTitles(
//                                   showTitles: true,
//                                   interval: 1,
//                                   reservedSize: 40, // جرّب 32-40 حسب الخط
//                                   getTitlesWidget: (value, meta) {
//                                     final matchedPoint = chartData.firstWhere(
//                                       (item) =>
//                                           (item['x'] as num).toDouble() ==
//                                           value,
//                                       orElse: () => {"label": ""},
//                                     );
//                                     final label =
//                                         (matchedPoint['label'] ?? '') as String;

//                                     return SideTitleWidget(
//                                       axisSide: meta.axisSide,
//                                       space: 6, // مسافة بين الرسم والعنوان
//                                       child: Text(
//                                         label,
//                                         style: const TextStyle(
//                                             fontSize: 10, color: Colors.grey),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               leftTitles: AxisTitles(
//                                 sideTitles: SideTitles(
//                                   showTitles: true,
//                                   reservedSize: 42,
//                                 ),
//                               ),
//                               topTitles: AxisTitles(
//                                 sideTitles: SideTitles(
//                                   showTitles: false,
//                                 ),
//                               ),
//                               rightTitles: AxisTitles(
//                                 sideTitles: SideTitles(
//                                   showTitles: true,
//                                   reservedSize: 20,
//                                 ),
//                               ),
//                             ),
//                             borderData: FlBorderData(show: false),
//                             minX: 0,
//                             maxX: chartData.length.toDouble() - 1,
//                             minY: minY,
//                             maxY: maxY + 20,
//                             lineBarsData: [
//                               LineChartBarData(
//                                 isCurved: true,
//                                 color: Colors.green,
//                                 barWidth: 2,
//                                 belowBarData: BarAreaData(show: false),
//                                 dotData: FlDotData(
//                                   show: true,
//                                   getDotPainter: (spot, percent, bar, index) {
//                                     return FlDotCirclePainter(
//                                       radius: 4,
//                                       color: Colors.green,
//                                       strokeWidth: 1,
//                                       strokeColor: Colors.white,
//                                     );
//                                   },
//                                 ),
//                                 spots: chartSpots,
//                               ),
//                               LineChartBarData(
//                                 isCurved: true,
//                                 color: Colors.red,
//                                 barWidth: 2,
//                                 belowBarData: BarAreaData(show: false),
//                                 dotData: FlDotData(
//                                   show: true,
//                                   getDotPainter: (spot, percent, bar, index) {
//                                     return FlDotCirclePainter(
//                                       radius: 4,
//                                       color: Colors.red,
//                                       strokeWidth: 1,
//                                       strokeColor: Colors.white,
//                                     );
//                                   },
//                                 ),
//                                 spots: line2Spots,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// vital_signs_bottom_sheet.dart

class VitalSignsBottomSheet extends GetView<dynamic> {
  final void Function() onFilterPressed;
  final void Function() onAddPressed;
  final String title;
  final String value;
  final String unit;
  final Color? keyColor;

  /// توقع الشكل:
  /// [{'x': 0.0, 'y': 100.0, 'label': 'Mon'}, ...]
  final List<Map<String, dynamic>> chartData;

  /// اختيارية لسلسلة تانية
  final List<Map<String, dynamic>> line2ChartData;

  /// اختيارية لسلسلة تالتة
  final List<Map<String, dynamic>> line3ChartData;

  const VitalSignsBottomSheet({
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

  // ---------------- Spots Builders ----------------
  List<FlSpot> get chartSpots => chartData
      .map(
          (p) => FlSpot((p['x'] as num).toDouble(), (p['y'] as num).toDouble()))
      .toList();

  List<FlSpot> get line2Spots => line2ChartData
      .map(
          (p) => FlSpot((p['x'] as num).toDouble(), (p['y'] as num).toDouble()))
      .toList();

  List<FlSpot> get line3Spots => line3ChartData
      .map(
          (p) => FlSpot((p['x'] as num).toDouble(), (p['y'] as num).toDouble()))
      .toList();

  // --------------- Bounds Helper ------------------

  _Bounds _calcBounds() {
    final allSpots = <FlSpot>[
      ...chartSpots,
      ...line2Spots,
      ...line3Spots,
    ];

    if (allSpots.isEmpty) {
      // قيم افتراضية آمنة لو مفيش أي داتا
      return const _Bounds(0, 1, 0, 1);
    }

    double minX = allSpots.first.x;
    double maxX = allSpots.first.x;
    double minY = allSpots.first.y;
    double maxY = allSpots.first.y;

    for (final s in allSpots) {
      if (s.x < minX) minX = s.x;
      if (s.x > maxX) maxX = s.x;
      if (s.y < minY) minY = s.y;
      if (s.y > maxY) maxY = s.y;
    }

    // Padding على X لو المدى صفر (نقطة واحدة أو كل X متساوية)
    if ((maxX - minX).abs() < 1e-6) {
      minX -= 1;
      maxX += 1;
    }

    // Padding على Y
    if ((maxY - minY).abs() < 1e-6) {
      minY -= 10;
      maxY += 10;
    } else {
      maxY += 20; // زي ما كنت عامل
    }

    // لو ماينفعش قيم سالبة (مثلاً vital signs ممكن تكون دايمًا >= 0)
    if (minY < 0) minY = 0;

    return _Bounds(minX, maxX, minY, maxY);
  }

  // ترجيع اللابل بحسب قيمة X (لو موجودة في chartData)
  String _labelForX(double x) {
    final matched = chartData.firstWhere(
      (item) => ((item['x'] as num).toDouble() == x),
      orElse: () => const {"label": ""},
    );
    final label = matched['label'];
    return label is String ? label : '';
  }

  @override
  Widget build(BuildContext context) {
    final bounds = _calcBounds();

    // عرض الرسم: لكل نقطة ~50 بكسل مع حد أدنى 220
    final double computedWidth = (chartData.length * 50).toDouble();
    const double minChartWidth = 220;
    final double chartWidth =
        computedWidth < minChartWidth ? minChartWidth : computedWidth;

    // لو مفيش أي داتا في كل السلاسل
    final bool noData =
        chartSpots.isEmpty && line2Spots.isEmpty && line3Spots.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // البطاقة الرئيسية
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            child: Column(
              children: [
                // السطر اللي فيه القيمة والوحدة
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: keyColor ?? Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        unit,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: keyColor ?? Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                // الـ Chart
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 24.0, bottom: 12.0),
                  child: SizedBox(
                    height: 230,
                    child: noData
                        ? const Center(child: Text('No data'))
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: chartWidth,
                              child: LineChart(
                                LineChartData(
                                  showingTooltipIndicators: const [],
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
                                        reservedSize: 40,
                                        getTitlesWidget: (value, meta) =>
                                            SideTitleWidget(
                                          axisSide: meta.axisSide,
                                          space: 6,
                                          child: Text(
                                            _labelForX(value),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 42,
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 24,
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),

                                  // الحدود المحسوبة تلقائيًا
                                  minX: bounds.minX,
                                  maxX: bounds.maxX,
                                  minY: bounds.minY,
                                  maxY: bounds.maxY,

                                  lineBarsData: [
                                    if (chartSpots.isNotEmpty)
                                      LineChartBarData(
                                        isCurved: true,
                                        color: Colors.green,
                                        barWidth: 2,
                                        belowBarData: BarAreaData(show: false),
                                        dotData: FlDotData(
                                          show: true,
                                          getDotPainter:
                                              (spot, percent, bar, index) =>
                                                  FlDotCirclePainter(
                                            radius: 4,
                                            color: Colors.green,
                                            strokeWidth: 1,
                                            strokeColor: Colors.white,
                                          ),
                                        ),
                                        spots: chartSpots,
                                      ),
                                    if (line2Spots.isNotEmpty)
                                      LineChartBarData(
                                        isCurved: true,
                                        color: Colors.red,
                                        barWidth: 2,
                                        belowBarData: BarAreaData(show: false),
                                        dotData: FlDotData(
                                          show: true,
                                          getDotPainter:
                                              (spot, percent, bar, index) =>
                                                  FlDotCirclePainter(
                                            radius: 4,
                                            color: Colors.red,
                                            strokeWidth: 1,
                                            strokeColor: Colors.white,
                                          ),
                                        ),
                                        spots: line2Spots,
                                      ),
                                    if (line3Spots.isNotEmpty)
                                      LineChartBarData(
                                        isCurved: true,
                                        color: Colors.orange,
                                        barWidth: 2,
                                        belowBarData: BarAreaData(show: false),
                                        dotData: FlDotData(show: true),
                                        spots: line3Spots,
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
        const SizedBox(height: 12),
      ],
    );
  }
}
