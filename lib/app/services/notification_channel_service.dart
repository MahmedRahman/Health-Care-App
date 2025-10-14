import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

/// خدمة إدارة قنوات الإشعارات
/// يمكن استخدامها لإنشاء قنوات مخصصة للإشعارات
class NotificationChannelService {
  static final NotificationChannelService _instance =
      NotificationChannelService._internal();
  factory NotificationChannelService() => _instance;
  NotificationChannelService._internal();

  /// قناة الإشعارات الطبية
  static NotificationChannel get medicationChannel => NotificationChannel(
        channelKey: 'medication_channel',
        channelName: 'Medication Reminders',
        channelDescription: 'Reminders to take medications on time',
        importance: NotificationImportance.Max,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        playSound: true,
        enableVibration: true,
        locked: true,
        criticalAlerts: true,
        enableLights: true,
        ledColor: Colors.red,
      );

  /// قناة الإشعارات العادية
  static NotificationChannel get generalChannel => NotificationChannel(
        channelKey: 'general_channel',
        channelName: 'General Notifications',
        channelDescription: 'General app notifications',
        importance: NotificationImportance.High,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        playSound: true,
        enableVibration: true,
        locked: false,
        enableLights: true,
        ledColor: Colors.blue,
      );

  /// قناة الإشعارات المهمة
  static NotificationChannel get urgentChannel => NotificationChannel(
        channelKey: 'urgent_channel',
        channelName: 'Urgent Notifications',
        channelDescription: 'Urgent and critical notifications',
        importance: NotificationImportance.Max,
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        playSound: true,
        enableVibration: true,
        locked: true,
        criticalAlerts: true,
        enableLights: true,
        ledColor: Colors.red,
      );

  /// قناة الإشعارات الصامتة
  static NotificationChannel get silentChannel => NotificationChannel(
        channelKey: 'silent_channel',
        channelName: 'Silent Notifications',
        channelDescription: 'Silent notifications without sound',
        importance: NotificationImportance.Low,
        defaultRingtoneType: DefaultRingtoneType.Notification,
        playSound: false,
        enableVibration: false,
        locked: false,
        enableLights: false,
      );

  /// إنشاء قناة مخصصة
  static NotificationChannel createCustomChannel({
    required String channelKey,
    required String channelName,
    required String channelDescription,
    NotificationImportance importance = NotificationImportance.High,
    DefaultRingtoneType ringtoneType = DefaultRingtoneType.Notification,
    bool playSound = true,
    bool enableVibration = true,
    bool locked = false,
    bool criticalAlerts = false,
    bool enableLights = true,
    Color? ledColor,
  }) {
    return NotificationChannel(
      channelKey: channelKey,
      channelName: channelName,
      channelDescription: channelDescription,
      importance: importance,
      defaultRingtoneType: ringtoneType,
      playSound: playSound,
      enableVibration: enableVibration,
      locked: locked,
      criticalAlerts: criticalAlerts,
      enableLights: enableLights,
      ledColor: ledColor,
    );
  }

  /// الحصول على جميع القنوات الافتراضية
  static List<NotificationChannel> get defaultChannels => [
        medicationChannel,
        generalChannel,
        urgentChannel,
        silentChannel,
      ];

  /// الحصول على قنوات الإشعارات الطبية
  static List<NotificationChannel> get medicalChannels => [
        medicationChannel,
        urgentChannel,
      ];

  /// الحصول على قنوات الإشعارات العامة
  static List<NotificationChannel> get generalChannels => [
        generalChannel,
        silentChannel,
      ];
}
