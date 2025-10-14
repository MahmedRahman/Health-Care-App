# نظام إدارة الأدوية والجدولة

نظام شامل لإدارة الأدوية وجدولة الإشعارات في تطبيقات الرعاية الصحية.

## الملفات المتضمنة

### 1. `medication_service.dart`
الخدمة الرئيسية لإدارة الأدوية والجدولة.

### 2. `medication_schedule_controller.dart`
Controller للتعامل مع منطق الأعمال.

### 3. `medication_schedule_view.dart`
واجهة المستخدم لعرض الجدولة.

## المميزات

### ✅ **إدارة الأدوية**
- تحليل بيانات الأدوية من API
- إنشاء جدولة تلقائية للجرعات
- تصنيف الجرعات (اليوم، مفقودة، قادمة)

### ✅ **جدولة ذكية**
- جدولة الإشعارات قبل 15 دقيقة من موعد الجرعة
- دعم الجرعات المتعددة في اليوم
- تتبع الجرعات المفقودة

### ✅ **واجهة مستخدم متقدمة**
- عرض الجدولة في تبويبات منفصلة
- إحصائيات سريعة
- أزرار تفاعلية (تناول، تأجيل)

### ✅ **إشعارات ذكية**
- إشعارات مخصصة لكل دواء
- أزرار تفاعلية في الإشعارات
- دعم التأجيل والغفوة

## كيفية الاستخدام

### 1. إضافة Controller إلى التطبيق

```dart
// في main.dart أو في routes
Get.put(MedicationScheduleController());
```

### 2. استخدام الـ View

```dart
// في routes
GetPage(
  name: '/medication-schedule',
  page: () => const MedicationScheduleView(),
  binding: BindingsBuilder(() {
    Get.lazyPut<MedicationScheduleController>(() => MedicationScheduleController());
  }),
),
```

### 3. استخدام الـ Service مباشرة

```dart
final medicationService = MedicationService();

// تحويل بيانات الأدوية إلى جدولة
final schedule = await medicationService.createMedicationSchedule(medications);

// جدولة الإشعارات
await medicationService.scheduleMedicationNotifications(medications);

// الحصول على جدولة اليوم
final todaySchedule = await medicationService.getTodaySchedule(medications);
```

## نموذج البيانات

### Medication
```dart
class Medication {
  final int id;
  final String medicineName;
  final String medicineImage;
  final int dose;
  final String doseForm;
  final String doseRoute;
  final String doseFrequency;
  final int doseDuration;
  final String doseDurationList;
  final List<DoseTime> doseTimeList;
  final String specialInstructions;
  final String description;
  final String doctorName;
  final String startFrom;
  final String renewalDate;
  final int leftDosesCount;
  final int leftDosesDaysCouns;
  final double countOfDose;
  final double totalDoses;
  final int totalDuration;
  final String doseCompliance;
}
```

### MedicationSchedule
```dart
class MedicationSchedule {
  final int medicationId;
  final String medicationName;
  final String dose;
  final String doseForm;
  final String doseRoute;
  final DateTime scheduledTime;
  final String status; // 'upcoming', 'missed', 'taken'
  final String specialInstructions;
  final String doctorName;
  final bool isToday;
  final bool isPast;
}
```

## API Integration

### تنسيق البيانات المتوقع من API

```json
{
  "data": [
    {
      "id": 70,
      "medicineName": "PANADOLE",
      "medicineImage": "",
      "dose": 2,
      "doseForm": "Tablet",
      "doseRoute": "Oral",
      "doseFrequency": "daily",
      "doseDuration": 1,
      "doseDurationList": "months",
      "doseTimeList": [
        {
          "id": 39,
          "doseTime": "12:00 AM"
        },
        {
          "id": 40,
          "doseTime": "12:00 PM"
        }
      ],
      "specialInstructions": "Special",
      "description": "Description",
      "doctorName": "Doctor",
      "startFrom": "08/10/2025",
      "renewalDate": "08/11/2025",
      "leftDosesCount": 60,
      "leftDosesDaysCouns": 30,
      "countOfDose": 0.0,
      "totalDoses": 60.0,
      "totalDuration": 30,
      "doseCompliance": "0 %"
    }
  ]
}
```

## الوظائف المتاحة

### MedicationService
- `createMedicationSchedule()` - إنشاء جدولة من قائمة الأدوية
- `scheduleMedicationNotifications()` - جدولة الإشعارات
- `getTodaySchedule()` - الحصول على جدولة اليوم
- `getMissedDoses()` - الحصول على الجرعات المفقودة
- `getUpcomingDoses()` - الحصول على الجرعات القادمة
- `markDoseAsTaken()` - تسجيل تناول الجرعة
- `cancelMedicationSchedule()` - إلغاء جدولة دواء

### MedicationScheduleController
- `loadMedications()` - تحميل الأدوية من API
- `markDoseAsTaken()` - تسجيل تناول الجرعة
- `snoozeDose()` - تأجيل الجرعة
- `cancelMedication()` - إلغاء دواء
- `cancelAllMedications()` - إلغاء جميع الأدوية
- `refreshSchedule()` - تحديث الجدولة

## التخصيص

### تخصيص الألوان
```dart
// في medication_schedule_view.dart
Color cardColor = Colors.white;
Color borderColor = Colors.grey[300]!;

if (isMissed || isPast) {
  cardColor = Colors.red[50]!;
  borderColor = Colors.red[300]!;
}
```

### تخصيص الإشعارات
```dart
// في medication_service.dart
await _scheduler.scheduleMedicationReminder(
  id: id,
  medicationName: medicationName,
  dosage: dosage,
  scheduledTime: scheduledTime,
  instructions: instructions,
  payload: payload,
);
```

## المتطلبات

- Flutter 3.0+
- GetX
- awesome_notifications
- API endpoint للـ getMedicines

## التثبيت

1. انسخ الملفات إلى مجلد `lib/app/`
2. أضف الـ routes إلى `app_pages.dart`
3. استخدم الـ Controller في التطبيق
4. تأكد من وجود API endpoint للـ getMedicines

## مثال كامل

```dart
// في routes
GetPage(
  name: '/medication-schedule',
  page: () => const MedicationScheduleView(),
  binding: BindingsBuilder(() {
    Get.lazyPut<MedicationScheduleController>(() => MedicationScheduleController());
  }),
),

// في main.dart
Get.put(MedicationScheduleController());

// استخدام مباشر
final controller = Get.find<MedicationScheduleController>();
await controller.loadMedications();
```

هذا النظام يوفر حلولاً شاملة لإدارة الأدوية وجدولة الإشعارات في تطبيقات الرعاية الصحية! 🏥💊
