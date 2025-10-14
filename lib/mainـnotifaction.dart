import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'app/services/notification_service.dart';
import 'app/services/notification_channel_service.dart';
import 'app/services/notification_scheduler_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة خدمة الإشعارات
  final notificationService = NotificationService();
  await notificationService.initialize(
    channels: NotificationChannelService.defaultChannels,
    debug: true,
  );

  // إعداد listener للإشعارات
  notificationService.setNotificationListener(
    onActionReceived: (ReceivedAction action) async {
      try {
        final payload = action.payload ?? {};
        final medId = payload['medicationId'] ?? 'none';
        final medName = payload['medicationName'] ?? 'الدواء';

        // التعامل مع الأزرار
        if (action.buttonKeyPressed == 'TAKEN') {
          debugPrint('User marked medication as taken: $medName');
          return;
        }
        if (action.buttonKeyPressed == 'SNOOZE_10') {
          await _handleSnooze(medId, medName, 10);
          return;
        }
        if (action.buttonKeyPressed == 'SNOOZE_30') {
          await _handleSnooze(medId, medName, 30);
          return;
        }

        // الضغط العادي على الإشعار
        notificationService.navigateFromNotification(
          context: notificationService.navigatorKey.currentContext!,
          page: MedicationDetailsPage(medId: medId, medName: medName),
        );
      } catch (e) {
        debugPrint('Error in notification listener: $e');
      }
    },
  );

  runApp(MyApp(notificationService: notificationService));
}

// دالة مساعدة للتعامل مع الغفوة
Future<void> _handleSnooze(String medId, String medName, int minutes) async {
  final now = DateTime.now().add(Duration(minutes: minutes));
  final scheduler = NotificationSchedulerService();

  await scheduler.scheduleMedicationReminder(
    id: DateTime.now().millisecondsSinceEpoch % 1000000,
    medicationName: medName,
    dosage: 'الجرعة',
    scheduledTime: now,
    payload: {'medicationId': medId, 'medicationName': medName},
  );
}

class MyApp extends StatelessWidget {
  final NotificationService notificationService;

  const MyApp({super.key, required this.notificationService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: notificationService.navigatorKey,
      title: 'اختبار الإشعارات',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: HomePage(notificationService: notificationService),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  final NotificationService notificationService;

  const HomePage({super.key, required this.notificationService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay dailyTime = const TimeOfDay(hour: 9, minute: 0);
  final NotificationSchedulerService _scheduler =
      NotificationSchedulerService();

  Future<void> _requestPermission() async {
    final allowed = await widget.notificationService.requestPermissions(
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

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              allowed ? 'تم تفعيل الإشعارات بنجاح!' : 'فشل في تفعيل الإشعارات'),
          backgroundColor: allowed ? Colors.green : Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _showNow() async {
    await widget.notificationService.showNotification(
      id: 1001,
      title: 'تجربة إشعار فوري',
      body: 'لو ضغطت هنا، هتروح لشاشة الدواء',
      channelKey: 'medication_channel',
      payload: {'medicationId': 'sample-123', 'medicationName': 'أسبرين'},
      category: NotificationCategory.Reminder,
      actionButtons: [
        NotificationActionButton(
          key: 'TAKEN',
          label: 'أخذت الجرعة',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'SNOOZE_10',
          label: 'غفوة 10د',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  Future<void> _scheduleIn1Min() async {
    final dt = DateTime.now().add(const Duration(minutes: 1));
    await _scheduler.scheduleMedicationReminder(
      id: 1002,
      medicationName: 'أسبرين',
      dosage: '100 مجم',
      scheduledTime: dt,
      instructions: 'تناول مع الطعام',
    );
  }

  Future<void> _scheduleDaily() async {
    await _scheduler.scheduleDailyMedicationReminder(
      id: 2001,
      medicationName: 'فيتامين د',
      dosage: '1000 وحدة',
      time: dailyTime,
      instructions: 'تناول مع الإفطار',
    );
  }

  Future<void> _scheduleWaterReminder() async {
    await _scheduler.scheduleWaterReminder(
      id: 3001,
      time: const TimeOfDay(hour: 10, minute: 0),
      message: 'حان وقت شرب الماء للحفاظ على صحتك',
    );
  }

  Future<void> _cancelAll() async {
    await _scheduler.cancelAllReminders();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إلغاء كل الإشعارات المجدولة')),
      );
    }
  }

  Future<void> _pickTime() async {
    final picked =
        await showTimePicker(context: context, initialTime: dailyTime);
    if (picked != null) setState(() => dailyTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختبار الإشعارات'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.notifications_active,
                        size: 48, color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      'مرحباً بك في اختبار الإشعارات!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'اضغط على الأزرار بالترتيب لاختبار الإشعارات',
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestPermission,
              child: const Text('1) طلب/تأكيد صلاحية الإشعارات'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _showNow,
              child: const Text('2) إشعار فوري الآن'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _scheduleIn1Min,
              child: const Text('3) جدولة إشعار بعد دقيقة'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _scheduleDaily,
                    child: Text('4) تذكير يومي ${dailyTime.format(context)}'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _pickTime,
                  child: const Text('اختيار وقت'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _scheduleWaterReminder,
              child: const Text('5) تذكير شرب الماء'),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: _cancelAll,
              child: const Text('إلغاء الكل'),
            ),
            const SizedBox(height: 20),
            const Text(
              'جرّب: اقفل التطبيق/شغّله في الخلفية واضغط على الإشعار',
              style: TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class MedicationDetailsPage extends StatelessWidget {
  final String medId;
  final String medName;

  const MedicationDetailsPage({
    super.key,
    required this.medId,
    required this.medName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الدواء'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication, size: 64, color: Colors.teal),
            const SizedBox(height: 16),
            Text(
              'تم فتح الصفحة من الإشعار',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('معرف الدواء: $medId'),
            Text('اسم الدواء: $medName'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('العودة'),
            ),
          ],
        ),
      ),
    );
  }
}
