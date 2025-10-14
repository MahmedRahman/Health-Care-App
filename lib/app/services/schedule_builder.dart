import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

/// يبني جدول بالمواعيد (DateTime) من Map واحدة.
/// يدعم: daily | every_x_days | weekly | every_x_hours
/// الحقول الاختيارية:
/// - frequencyInterval: للأنماط every_x_days / every_x_hours
/// - daysOfWeek: للـ weekly (أرقام 1=Mon .. 7=Sun أو نصوص "Mon".."Sun")
/// - renewalDate: لو موجودة نستخدمها كنهاية، وإلا نحسب من doseDuration + doseDurationList
List<DateTime> buildScheduleFromMap(Map<String, dynamic> data,
    {bool sortAsc = true, bool inclusiveEnd = true}) {
  // -------- parsing helpers --------
  DateTime _parseDateFlexible(String s) {
    final candidates = <DateFormat>[
      DateFormat('dd/MM/yyyy'),
      DateFormat('MM/dd/yyyy'),
      DateFormat('yyyy-MM-dd'),
    ];
    for (final f in candidates) {
      try {
        return f.parseStrict(s);
      } catch (_) {}
    }
    for (final f in candidates) {
      try {
        return f.parse(s);
      } catch (_) {}
    }
    throw FormatException('Unrecognized date format: $s');
  }

  TimeOfDay _parseTimeOfDay(String s) {
    // يدعم "hh:mm a" مثل "12:00 PM"
    final f = DateFormat('hh:mm a');
    final dt = f.parseStrict(s);
    return TimeOfDay(hour: dt.hour, minute: dt.minute);
  }

  DateTime _mergeDateAndTime(DateTime d, TimeOfDay t) =>
      DateTime(d.year, d.month, d.day, t.hour, t.minute);

  DateTime _computeEndDate({
    required DateTime start,
    required int duration,
    required String unit,
  }) {
    switch (unit.toLowerCase()) {
      case 'day':
      case 'days':
        return start.add(Duration(days: duration));
      case 'week':
      case 'weeks':
        return start.add(Duration(days: 7 * duration));
      case 'month':
      case 'months':
        return DateTime(start.year, start.month + duration, start.day,
            start.hour, start.minute);
      default:
        return start.add(Duration(days: duration));
    }
  }

  // -------- read inputs --------
  final doseFrequency =
      (data['doseFrequency'] ?? 'daily').toString().toLowerCase();
  final doseDuration = (data['doseDuration'] ?? 0) is num
      ? (data['doseDuration'] as num).toInt()
      : 0;
  final doseDurationList = (data['doseDurationList'] ?? 'days').toString();
  final startFromStr = (data['startFrom'] ?? '').toString().trim();
  final renewalStr = (data['renewalDate'] ?? '').toString().trim();
  final frequencyInterval =
      (data['frequencyInterval'] ?? data['interval'] ?? 0) is num
          ? (data['frequencyInterval'] ?? data['interval'] ?? 0) as num
          : 0;
  final doseTimeList = (data['doseTimeList'] as List<dynamic>? ?? const [])
      .map((e) => e is Map ? e['doseTime']?.toString() ?? '' : '')
      .where((s) => s.isNotEmpty)
      .toList();

  // weekly أيام الأسبوع (اختياري): [1..7] (Mon..Sun) أو ["Mon","Tue",..]
  List<int> _parseDaysOfWeek(dynamic raw) {
    if (raw == null) return [];
    List<int> out = [];
    final mapDay = <String, int>{
      'mon': 1,
      'tue': 2,
      'wed': 3,
      'thu': 4,
      'fri': 5,
      'sat': 6,
      'sun': 7
    };
    if (raw is List) {
      for (final v in raw) {
        if (v is num)
          out.add(v.toInt().clamp(1, 7));
        else if (v is String && mapDay.containsKey(v.toLowerCase()))
          out.add(mapDay[v.toLowerCase()]!);
      }
    }
    return out.toSet().toList()..sort();
  }

  final daysOfWeek = _parseDaysOfWeek(data['daysOfWeek']);

  if (startFromStr.isEmpty) {
    throw ArgumentError('startFrom is required');
  }
  final startDate = _parseDateFlexible(startFromStr);

  DateTime endDate;
  if (renewalStr.isNotEmpty) {
    endDate = _parseDateFlexible(renewalStr);
  } else {
    endDate = _computeEndDate(
        start: startDate, duration: doseDuration, unit: doseDurationList);
  }

  // نحدد الحدّ النهائي (شامل/غير شامل)
  // لو inclusiveEnd=true نُدرج مواعيد يوم endDate بالكامل.
  final lastDay = inclusiveEnd
      ? DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59)
      : DateTime(endDate.year, endDate.month, endDate.day);

  final List<DateTime> out = [];

  // -------- scheduling --------
  if (doseFrequency == 'daily') {
    // كل يوم عند الأوقات المحددة
    final times = doseTimeList.isEmpty
        ? <TimeOfDay>[const TimeOfDay(hour: 9, minute: 0)] // افتراضي
        : doseTimeList.map(_parseTimeOfDay).toList();

    for (DateTime d = DateTime(startDate.year, startDate.month, startDate.day);
        !d.isAfter(lastDay);
        d = d.add(const Duration(days: 1))) {
      for (final t in times) {
        final dt = _mergeDateAndTime(d, t);
        if (!dt.isAfter(lastDay)) out.add(dt);
      }
    }
  } else if (doseFrequency == 'every_x_days') {
    final x = (frequencyInterval is num && frequencyInterval > 0)
        ? frequencyInterval.toInt()
        : 1;
    final times = doseTimeList.isEmpty
        ? <TimeOfDay>[const TimeOfDay(hour: 9, minute: 0)]
        : doseTimeList.map(_parseTimeOfDay).toList();

    for (DateTime d = DateTime(startDate.year, startDate.month, startDate.day);
        !d.isAfter(lastDay);
        d = d.add(Duration(days: x))) {
      for (final t in times) {
        final dt = _mergeDateAndTime(d, t);
        if (!dt.isAfter(lastDay)) out.add(dt);
      }
    }
  } else if (doseFrequency == 'weekly') {
    // daysOfWeek مطلوبة (1=Mon .. 7=Sun)
    final times = doseTimeList.isEmpty
        ? <TimeOfDay>[const TimeOfDay(hour: 9, minute: 0)]
        : doseTimeList.map(_parseTimeOfDay).toList();

    if (daysOfWeek.isEmpty) {
      // لو مش محدد، اعتبر كل أيام الأسبوع
      for (int i = 0; i < 7; i++) {
        daysOfWeek.add(i + 1);
      }
    }

    for (DateTime d = DateTime(startDate.year, startDate.month, startDate.day);
        !d.isAfter(lastDay);
        d = d.add(const Duration(days: 1))) {
      final weekdayMon1 =
          d.weekday == 7 ? 7 : d.weekday; // Dart: Mon=1 .. Sun=7 بالفعل
      if (daysOfWeek.contains(weekdayMon1)) {
        for (final t in times) {
          final dt = _mergeDateAndTime(d, t);
          if (!dt.isAfter(lastDay)) out.add(dt);
        }
      }
    }
  } else if (doseFrequency == 'every_x_hours') {
    final xh = (frequencyInterval is num && frequencyInterval > 0)
        ? frequencyInterval.toInt()
        : 8;
    // البداية: startDate + أول وقت من doseTimeList (لو موجود)، غير كده ابدأ 09:00
    DateTime cursor;
    if (doseTimeList.isNotEmpty) {
      final t = _parseTimeOfDay(doseTimeList.first);
      cursor = DateTime(
          startDate.year, startDate.month, startDate.day, t.hour, t.minute);
    } else {
      cursor = DateTime(startDate.year, startDate.month, startDate.day, 9, 0);
    }
    while (!cursor.isAfter(lastDay)) {
      out.add(cursor);
      cursor = cursor.add(Duration(hours: xh));
    }
  } else {
    // fallback: عاملها daily
    final times = doseTimeList.isEmpty
        ? <TimeOfDay>[const TimeOfDay(hour: 9, minute: 0)]
        : doseTimeList.map(_parseTimeOfDay).toList();
    for (DateTime d = DateTime(startDate.year, startDate.month, startDate.day);
        !d.isAfter(lastDay);
        d = d.add(const Duration(days: 1))) {
      for (final t in times) {
        final dt = _mergeDateAndTime(d, t);
        if (!dt.isAfter(lastDay)) out.add(dt);
      }
    }
  }

  if (sortAsc) {
    out.sort((a, b) => a.compareTo(b));
  }
  return out;
}

/// فورماتر بسيط لو حابب تعرض الجدول نصيًا
List<String> formatSchedule(List<DateTime> list) {
  final df = DateFormat('yyyy-MM-dd HH:mm');
  return list.map(df.format).toList();
}

/// استعمل نفس الدالة اللي بنبني بيها الجدول من رسالة سابقة:
/// List<DateTime> buildScheduleFromMap(Map<String, dynamic> data, {bool sortAsc = true, bool inclusiveEnd = true})

/// تبني شكل مخرَج غني لكل موعد
List<Map<String, dynamic>> buildRichScheduleFromMap(
  Map<String, dynamic> data, {
  Duration dueWindow = const Duration(minutes: 5), // نافذة "due now"
  DateTime? nowOverride, // لو عايز تختبر بوقت معيّن
}) {
  final List<DateTime> occurrences = buildScheduleFromMap(data);
  final now = nowOverride ?? DateTime.now();

  // جرّب نجيب أول label من doseTimeList لو موجود علشان نحتفظ به
  final doseTimeLabels = (data['doseTimeList'] as List<dynamic>? ?? const [])
      .map((e) => e is Map ? (e['doseTime']?.toString() ?? '') : '')
      .where((s) => s.isNotEmpty)
      .toList();

  final medName = (data['medicineName'] ?? '').toString();
  final medId = (data['id'] ?? '').toString();

  final dfDate = DateFormat('yyyy-MM-dd');
  final dfTime = DateFormat('HH:mm');

  String _statusFor(DateTime dt) {
    if (dt.isBefore(now.subtract(dueWindow))) return 'missed';
    if (dt.isAfter(now.add(dueWindow))) return 'upcoming';
    return 'due_now';
  }

  return List<Map<String, dynamic>>.generate(occurrences.length, (i) {
    final dt = occurrences[i];
    // لو عندك أكتر من وقت في اليوم، حاول نجيب الـ label المناظر (إن وُجد)
    // مثال بسيط: لو فيه 2 أوقات يوميًا، هيتكرروا بالتتابع؛ نستخدم modulo
    String? label;
    if (doseTimeLabels.isNotEmpty) {
      final dayTimesCount = doseTimeLabels.length;
      label = doseTimeLabels[i % dayTimesCount];
    }

    final status = _statusFor(dt);
    return {
      'date': dfDate.format(dt),
      'time': dfTime.format(dt),
      'datetimeIso': dt.toIso8601String(),
      'doseTimeLabel': label, // قد تكون null لو مفيش labels
      'medicineName': medName,
      'medicineId': medId,
      'status': status, // missed | due_now | upcoming
      'isPassed': status == 'missed',
    };
  });
}

/// بيرجع جدول مجمّع لكل الأدوية في ليستة واحدة
List<Map<String, dynamic>> buildSchedulesForAllMedicines(
  List<Map<String, dynamic>> medsData, {
  Duration dueWindow = const Duration(minutes: 5),
  DateTime? nowOverride,
}) {
  final List<Map<String, dynamic>> all = [];
  for (final med in medsData) {
    final rich = buildRichScheduleFromMap(
      med,
      dueWindow: dueWindow,
      nowOverride: nowOverride,
    );
    all.addAll(rich);
  }
  // رتّب الكل حسب التاريخ/الوقت
  all.sort((a, b) {
    final da = DateTime.parse(a['datetimeIso']);
    final db = DateTime.parse(b['datetimeIso']);
    return da.compareTo(db);
  });
  return all;
}
