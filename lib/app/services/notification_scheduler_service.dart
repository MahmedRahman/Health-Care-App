import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'notification_service.dart';

/// خدمة جدولة الإشعارات المتقدمة
/// يمكن استخدامها لجدولة الإشعارات المعقدة
class NotificationSchedulerService {
  static final NotificationSchedulerService _instance =
      NotificationSchedulerService._internal();
  factory NotificationSchedulerService() => _instance;
  NotificationSchedulerService._internal();

  final NotificationService _notificationService = NotificationService();

  /// جدولة إشعار دواء
  Future<void> scheduleMedicationReminder({
    required int id,
    required String medicationName,
    required String dosage,
    required DateTime scheduledTime,
    String? instructions,
    Map<String, String>? payload,
  }) async {
    await _notificationService.scheduleNotification(
      id: id,
      title: 'تذكير دواء: $medicationName',
      body:
          'حان وقت تناول $dosage من $medicationName${instructions != null ? '\n$instructions' : ''}',
      scheduledDate: scheduledTime,
      channelKey: 'medication_channel',
      payload: payload ??
          {'medicationId': id.toString(), 'medicationName': medicationName},
      allowWhileIdle: true,
      preciseAlarm: true,
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
        NotificationActionButton(
          key: 'SNOOZE_30',
          label: 'غفوة 30د',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  /// جدولة إشعار يومي للدواء
  Future<void> scheduleDailyMedicationReminder({
    required int id,
    required String medicationName,
    required String dosage,
    required TimeOfDay time,
    String? instructions,
    Map<String, String>? payload,
  }) async {
    await _notificationService.scheduleDailyNotification(
      id: id,
      title: 'تذكير يومي: $medicationName',
      body:
          'حان وقت تناول $dosage من $medicationName${instructions != null ? '\n$instructions' : ''}',
      time: time,
      channelKey: 'medication_channel',
      payload: payload ??
          {'medicationId': id.toString(), 'medicationName': medicationName},
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

  /// جدولة إشعار موعد طبي
  Future<void> scheduleAppointmentReminder({
    required int id,
    required String doctorName,
    required String appointmentType,
    required DateTime appointmentTime,
    String? location,
    Map<String, String>? payload,
  }) async {
    await _notificationService.scheduleNotification(
      id: id,
      title: 'تذكير موعد طبي',
      body:
          'موعدك مع د. $doctorName - $appointmentType${location != null ? '\nالمكان: $location' : ''}',
      scheduledDate: appointmentTime,
      channelKey: 'urgent_channel',
      payload:
          payload ?? {'appointmentId': id.toString(), 'doctorName': doctorName},
      allowWhileIdle: true,
      preciseAlarm: true,
      actionButtons: [
        NotificationActionButton(
          key: 'REMIND_AGAIN',
          label: 'تذكير مرة أخرى',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'CANCEL',
          label: 'إلغاء الموعد',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  /// جدولة إشعار فحص طبي
  Future<void> scheduleMedicalTestReminder({
    required int id,
    required String testName,
    required DateTime testTime,
    String? preparation,
    Map<String, String>? payload,
  }) async {
    await _notificationService.scheduleNotification(
      id: id,
      title: 'تذكير فحص طبي',
      body:
          'فحص $testName${preparation != null ? '\nالتحضير: $preparation' : ''}',
      scheduledDate: testTime,
      channelKey: 'urgent_channel',
      payload: payload ?? {'testId': id.toString(), 'testName': testName},
      allowWhileIdle: true,
      preciseAlarm: true,
      actionButtons: [
        NotificationActionButton(
          key: 'REMIND_AGAIN',
          label: 'تذكير مرة أخرى',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  /// جدولة إشعار ماء
  Future<void> scheduleWaterReminder({
    required int id,
    required TimeOfDay time,
    String? message,
  }) async {
    await _notificationService.scheduleDailyNotification(
      id: id,
      title: 'تذكير شرب الماء',
      body: message ?? 'حان وقت شرب الماء للحفاظ على صحتك',
      time: time,
      channelKey: 'general_channel',
      payload: {'reminderType': 'water', 'reminderId': id.toString()},
      actionButtons: [
        NotificationActionButton(
          key: 'DRANK',
          label: 'شربت الماء',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'SNOOZE_30',
          label: 'غفوة 30د',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  /// جدولة إشعار تمرين
  Future<void> scheduleExerciseReminder({
    required int id,
    required String exerciseName,
    required TimeOfDay time,
    String? duration,
  }) async {
    await _notificationService.scheduleDailyNotification(
      id: id,
      title: 'تذكير التمرين',
      body: 'حان وقت $exerciseName${duration != null ? ' لمدة $duration' : ''}',
      time: time,
      channelKey: 'general_channel',
      payload: {'reminderType': 'exercise', 'exerciseName': exerciseName},
      actionButtons: [
        NotificationActionButton(
          key: 'COMPLETED',
          label: 'أكملت التمرين',
          actionType: ActionType.SilentAction,
        ),
        NotificationActionButton(
          key: 'SNOOZE_15',
          label: 'غفوة 15د',
          actionType: ActionType.SilentAction,
        ),
      ],
    );
  }

  /// إلغاء جميع تذكيرات الدواء
  Future<void> cancelAllMedicationReminders() async {
    // يمكن تحسين هذا لاحقاً بحفظ IDs محددة
    await _notificationService.cancelAllNotifications();
  }

  /// إلغاء تذكير دواء محدد
  Future<void> cancelMedicationReminder(int medicationId) async {
    await _notificationService.cancelNotification(medicationId);
  }

  /// إلغاء جميع التذكيرات
  Future<void> cancelAllReminders() async {
    await _notificationService.cancelAllNotifications();
  }
}
