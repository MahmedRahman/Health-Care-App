# خدمات الإشعارات (Notification Services)

مجموعة من الخدمات المنفصلة لإدارة الإشعارات في Flutter باستخدام `awesome_notifications`.

## الملفات المتضمنة

### 1. `notification_service.dart`
الخدمة الرئيسية للإشعارات - تحتوي على جميع الوظائف الأساسية.

### 2. `notification_channel_service.dart`
خدمة إدارة قنوات الإشعارات - تحتوي على قنوات جاهزة ومخصصة.

### 3. `notification_scheduler_service.dart`
خدمة جدولة الإشعارات المتقدمة - تحتوي على وظائف جدولة متخصصة.

## كيفية الاستخدام

### 1. تهيئة الخدمة

```dart
import 'app/services/notification_service.dart';
import 'app/services/notification_channel_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final notificationService = NotificationService();
  await notificationService.initialize(
    channels: NotificationChannelService.defaultChannels,
    debug: true,
  );
  
  runApp(MyApp(notificationService: notificationService));
}
```

### 2. طلب الأذونات

```dart
final allowed = await notificationService.requestPermissions(
  channelKey: 'medication_channel',
  permissions: [
    NotificationPermission.Alert,
    NotificationPermission.Sound,
    NotificationPermission.Badge,
    NotificationPermission.Vibration,
    NotificationPermission.Light,
    NotificationPermission.FullScreenIntent,
    NotificationPermission.CriticalAlert,
  ],
);
```

### 3. إرسال إشعار فوري

```dart
await notificationService.showNotification(
  id: 1001,
  title: 'تذكير دواء',
  body: 'حان وقت تناول الدواء',
  channelKey: 'medication_channel',
  payload: {'medicationId': '123'},
  actionButtons: [
    NotificationActionButton(
      key: 'TAKEN',
      label: 'أخذت الجرعة',
      actionType: ActionType.SilentAction,
    ),
  ],
);
```

### 4. جدولة إشعار

```dart
await notificationService.scheduleNotification(
  id: 1002,
  title: 'تذكير دواء',
  body: 'حان وقت تناول الدواء',
  scheduledDate: DateTime.now().add(Duration(minutes: 1)),
  channelKey: 'medication_channel',
  allowWhileIdle: true,
  preciseAlarm: true,
);
```

### 5. استخدام خدمة الجدولة المتقدمة

```dart
import 'app/services/notification_scheduler_service.dart';

final scheduler = NotificationSchedulerService();

// جدولة تذكير دواء
await scheduler.scheduleMedicationReminder(
  id: 1001,
  medicationName: 'أسبرين',
  dosage: '100 مجم',
  scheduledTime: DateTime.now().add(Duration(minutes: 1)),
  instructions: 'تناول مع الطعام',
);

// جدولة تذكير يومي
await scheduler.scheduleDailyMedicationReminder(
  id: 2001,
  medicationName: 'فيتامين د',
  dosage: '1000 وحدة',
  time: TimeOfDay(hour: 9, minute: 0),
  instructions: 'تناول مع الإفطار',
);

// جدولة تذكير ماء
await scheduler.scheduleWaterReminder(
  id: 3001,
  time: TimeOfDay(hour: 10, minute: 0),
  message: 'حان وقت شرب الماء',
);
```

### 6. إعداد Listener للإشعارات

```dart
notificationService.setNotificationListener(
  onActionReceived: (ReceivedAction action) async {
    final payload = action.payload ?? {};
    final medId = payload['medicationId'] ?? 'none';
    
    if (action.buttonKeyPressed == 'TAKEN') {
      debugPrint('User marked medication as taken');
      return;
    }
    
    // فتح صفحة من الإشعار
    notificationService.navigateFromNotification(
      context: context,
      page: MedicationDetailsPage(medId: medId),
    );
  },
);
```

## القنوات المتاحة

### قنوات جاهزة:
- `medication_channel` - للإشعارات الطبية
- `general_channel` - للإشعارات العامة
- `urgent_channel` - للإشعارات المهمة
- `silent_channel` - للإشعارات الصامتة

### إنشاء قناة مخصصة:

```dart
final customChannel = NotificationChannelService.createCustomChannel(
  channelKey: 'my_custom_channel',
  channelName: 'My Custom Channel',
  channelDescription: 'Custom notification channel',
  importance: NotificationImportance.High,
  playSound: true,
  enableVibration: true,
  ledColor: Colors.blue,
);
```

## المميزات

- ✅ **سهولة الاستخدام** - واجهة بسيطة وواضحة
- ✅ **قابلية إعادة الاستخدام** - يمكن استخدامها في أي مشروع
- ✅ **مرونة عالية** - قنوات مخصصة وإعدادات متقدمة
- ✅ **جدولة متقدمة** - وظائف جدولة متخصصة للرعاية الصحية
- ✅ **معالجة الأخطاء** - حماية من الأخطاء في جميع العمليات
- ✅ **دعم الأزرار** - أزرار تفاعلية في الإشعارات
- ✅ **دعم التنقل** - فتح صفحات من الإشعارات

## التثبيت

1. أضف `awesome_notifications` إلى `pubspec.yaml`
2. انسخ ملفات الخدمات إلى مجلد `lib/app/services/`
3. استخدم الخدمات كما هو موضح أعلاه

## المتطلبات

- Flutter 3.0+
- awesome_notifications ^0.9.3+
- Android SDK 21+
- iOS 10.0+
