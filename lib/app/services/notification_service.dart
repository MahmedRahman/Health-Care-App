import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/app/core/network/api_request.dart';

/// خدمة الإشعارات الرئيسية
/// يمكن استخدامها في أي مشروع Flutter
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  bool _isInitialized = false;

//getMedication
  Future<List<Map<String, dynamic>>> getMedication() async {
    final response = await ApiRequest().getMedicines();
    return response.body;
  }

  /// تهيئة خدمة الإشعارات
  Future<void> initialize({
    String? defaultIcon,
    List<NotificationChannel>? channels,
    bool debug = false,
  }) async {
    if (_isInitialized) return;

    // القنوات الافتراضية إذا لم يتم توفيرها
    final defaultChannels = channels ??
        [
          NotificationChannel(
            channelKey: 'default_channel',
            channelName: 'Default Notifications',
            channelDescription: 'Default notification channel',
            importance: NotificationImportance.High,
            defaultRingtoneType: DefaultRingtoneType.Notification,
            playSound: true,
            enableVibration: true,
          ),
        ];

    await AwesomeNotifications().initialize(
      defaultIcon,
      defaultChannels,
      debug: debug,
    );

    _isInitialized = true;
  }

  /// طلب إذن الإشعارات
  Future<bool> requestPermissions({
    String? channelKey,
    List<NotificationPermission>? permissions,
  }) async {
    final allowed = await AwesomeNotifications().isNotificationAllowed();

    if (!allowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    // طلب الأذونات المتقدمة
    await AwesomeNotifications().requestPermissionToSendNotifications(
      channelKey: channelKey,
      permissions: permissions ??
          [
            NotificationPermission.Alert,
            NotificationPermission.Sound,
            NotificationPermission.Badge,
            NotificationPermission.Vibration,
            NotificationPermission.Light,
          ],
    );

    return await AwesomeNotifications().isNotificationAllowed();
  }

  /// إرسال إشعار فوري
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String channelKey = 'default_channel',
    Map<String, String>? payload,
    String? largeIcon,
    String? bigPicture,
    NotificationCategory? category,
    bool fullScreenIntent = false,
    bool wakeUpScreen = false,
    bool criticalAlert = false,
    bool locked = false,
    List<NotificationActionButton>? actionButtons,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        payload: payload,
        largeIcon: largeIcon,
        bigPicture: bigPicture,
        category: category,
        fullScreenIntent: fullScreenIntent,
        wakeUpScreen: wakeUpScreen,
        criticalAlert: criticalAlert,
        locked: locked,
        displayOnForeground: true,
        displayOnBackground: true,
        showWhen: true,
      ),
      actionButtons: actionButtons,
    );
  }

  /// جدولة إشعار
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String channelKey = 'default_channel',
    Map<String, String>? payload,
    bool repeats = false,
    bool allowWhileIdle = true,
    bool preciseAlarm = true,
    List<NotificationActionButton>? actionButtons,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        payload: payload,
        displayOnForeground: true,
        displayOnBackground: true,
        showWhen: true,
      ),
      schedule: NotificationCalendar(
        year: scheduledDate.year,
        month: scheduledDate.month,
        day: scheduledDate.day,
        hour: scheduledDate.hour,
        minute: scheduledDate.minute,
        second: scheduledDate.second,
        repeats: repeats,
        allowWhileIdle: allowWhileIdle,
        preciseAlarm: preciseAlarm,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
      actionButtons: actionButtons,
    );
  }

  /// جدولة إشعار يومي
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String channelKey = 'default_channel',
    Map<String, String>? payload,
    List<NotificationActionButton>? actionButtons,
  }) async {
    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        time.hour,
        time.minute,
      ),
      channelKey: channelKey,
      payload: payload,
      repeats: true,
      actionButtons: actionButtons,
    );
  }

  /// إلغاء إشعار محدد
  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  /// إلغاء جميع الإشعارات
  Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  /// إعداد listener للتعامل مع الإشعارات
  void setNotificationListener({
    required Future<void> Function(ReceivedAction action) onActionReceived,
  }) {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceived,
    );
  }

  /// فتح صفحة من الإشعار
  void navigateFromNotification({
    required BuildContext context,
    required Widget page,
  }) {
    if (navigatorKey.currentState != null) {
      navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (_) => page),
      );
    }
  }

  /// التحقق من حالة الإشعارات
  Future<bool> isNotificationAllowed() async {
    return await AwesomeNotifications().isNotificationAllowed();
  }

  /// الحصول على المنطقة الزمنية
  Future<String> getLocalTimeZone() async {
    return await AwesomeNotifications().getLocalTimeZoneIdentifier();
  }
}
