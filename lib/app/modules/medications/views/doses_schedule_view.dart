import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:health_care_app/app/services/notification_service.dart';

class DosesScheduleView extends StatelessWidget {
  final List<Map<String, dynamic>> dosesData;
  final NotificationService _notificationService = NotificationService();

  DosesScheduleView({
    Key? key,
    required this.dosesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // الحصول على البيانات من الـ arguments
    final arguments = Get.arguments;
    print('Arguments received: $arguments');

    List<Map<String, dynamic>> dosesData;
    if (arguments is List) {
      dosesData = arguments.cast<Map<String, dynamic>>();
    } else {
      dosesData = this.dosesData;
    }

    print('Doses data length: ${dosesData.length}');
    print('Doses data: $dosesData');

    // بيانات تجريبية في حالة عدم وجود بيانات
    if (dosesData.isEmpty) {
      dosesData = [
        {
          "date": "2025-01-15",
          "time": "09:00",
          "datetimeIso": "2025-01-15T09:00:00.000",
          "doseTimeLabel": "9:00 AM",
          "medicineName": "PANADOLE",
          "medicineId": "70",
          "status": "upcoming",
          "isPassed": false
        },
        {
          "date": "2025-01-15",
          "time": "21:00",
          "datetimeIso": "2025-01-15T21:00:00.000",
          "doseTimeLabel": "9:00 PM",
          "medicineName": "PANADOLE",
          "medicineId": "70",
          "status": "upcoming",
          "isPassed": false
        }
      ];
      print('Using sample data: $dosesData');
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF60A5FA),
        elevation: 0,
        title: const Text(
          'Doses Schedule',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active, color: Colors.white),
            onPressed: () => _scheduleAllNotifications(dosesData),
            tooltip: 'Schedule All Notifications',
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF60A5FA),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Column(
        children: [
          // إحصائيات سريعة
          Container(
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  'Total Doses',
                  dosesData.length.toString(),
                  Colors.blue,
                ),
                _buildStatCard(
                  'Upcoming',
                  dosesData
                      .where((dose) => dose['status'] == 'upcoming')
                      .length
                      .toString(),
                  Colors.green,
                ),
                _buildStatCard(
                  'Completed',
                  dosesData
                      .where((dose) => dose['status'] == 'completed')
                      .length
                      .toString(),
                  Colors.orange,
                ),
              ],
            ),
          ),

          // قائمة الجرعات
          Expanded(
            child: dosesData.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: dosesData.length,
                    itemBuilder: (context, index) {
                      final dose = dosesData[index];
                      print('Building dose card for index $index: $dose');
                      return _buildDoseCard(dose, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.medication,
            size: 64.w,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'No scheduled doses',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoseCardOld(Map<String, dynamic> dose, int index) {
    final date = dose['date'] ?? '';
    final time = dose['time'] ?? '';
    final doseTimeLabel = dose['doseTimeLabel'] ?? '';
    final medicineName = dose['medicineName'] ?? '';
    final medicineId = dose['medicineId'] ?? '';
    final status = dose['status'] ?? 'upcoming';
    final isPassed = dose['isPassed'] ?? false;

    Color cardColor = Colors.white;
    Color borderColor = Colors.grey[300]!;
    Color statusColor = Colors.blue;
    String statusText = 'Upcoming';

    if (status == 'completed') {
      cardColor = Colors.green[50]!;
      borderColor = Colors.green[300]!;
      statusColor = Colors.green;
      statusText = 'Completed';
    } else if (isPassed) {
      cardColor = Colors.red[50]!;
      borderColor = Colors.red[300]!;
      statusColor = Colors.red;
      statusText = 'Missed';
    } else if (status == 'upcoming') {
      cardColor = Colors.blue[50]!;
      borderColor = Colors.blue[300]!;
      statusColor = Colors.blue;
      statusText = 'Upcoming';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصف الأول: اسم الدواء والوقت
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    medicineName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    doseTimeLabel,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // الصف الثاني: التاريخ والوقت
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16.w,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 4.w),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.access_time,
                  size: 16.w,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 4.w),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // الصف الثالث: الحالة والأزرار
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                if (status == 'upcoming' && !isPassed) ...[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: () => _markAsCompleted(medicineId),
                          icon: Icon(Icons.check, size: 14.w),
                          label:
                              Text('Taken', style: TextStyle(fontSize: 10.sp)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.h),
                            minimumSize: Size.zero,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: OutlinedButton.icon(
                          onPressed: () => _snoozeDose(medicineId),
                          icon: Icon(Icons.snooze, size: 14.w),
                          label:
                              Text('Snooze', style: TextStyle(fontSize: 10.sp)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.orange,
                            side: const BorderSide(color: Colors.orange),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.h),
                            minimumSize: Size.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  // أزرار الإشعارات
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: OutlinedButton.icon(
                          onPressed: () => _sendNotificationNow(dose),
                          icon: Icon(Icons.notifications_active, size: 14.w),
                          label: Text('Now', style: TextStyle(fontSize: 10.sp)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            side: const BorderSide(color: Colors.blue),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.h),
                            minimumSize: Size.zero,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: OutlinedButton.icon(
                          onPressed: () => _sendNotificationInMinute(dose),
                          icon: Icon(Icons.timer, size: 14.w),
                          label:
                              Text('1 min', style: TextStyle(fontSize: 10.sp)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.purple,
                            side: const BorderSide(color: Colors.purple),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 6.h),
                            minimumSize: Size.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else if (isPassed) ...[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 16.w),
                        SizedBox(width: 4.w),
                        Text(
                          'Missed Dose',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _markAsCompleted(String medicineId) {
    Get.snackbar(
      'Success',
      'Dose marked as taken',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void _snoozeDose(String medicineId) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Snooze Dose',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Snoozed', 'Dose snoozed for 15 minutes');
                    },
                    child: Text('15 min', style: TextStyle(fontSize: 12.sp)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Snoozed', 'Dose snoozed for 30 minutes');
                    },
                    child: Text('30 min', style: TextStyle(fontSize: 12.sp)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Snoozed', 'Dose snoozed for 1 hour');
                    },
                    child: Text('1 hour', style: TextStyle(fontSize: 12.sp)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.snackbar('Snoozed', 'Dose snoozed for 2 hours');
                    },
                    child: Text('2 hours', style: TextStyle(fontSize: 12.sp)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// إرسال إشعار فوري
  void _sendNotificationNow(Map<String, dynamic> dose) async {
    try {
      final medicineName = dose['medicineName'] ?? 'Medicine';
      final doseTimeLabel = dose['doseTimeLabel'] ?? 'Now';

      await _notificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: '💊 Medication Reminder',
        body: 'Time to take $medicineName at $doseTimeLabel',
        channelKey: 'medication_channel',
        payload: {
          'medicineId': dose['medicineId']?.toString() ?? '',
          'medicineName': medicineName,
          'type': 'immediate_reminder',
        },
        fullScreenIntent: true,
        wakeUpScreen: true,
        criticalAlert: true,
        locked: true,
        actionButtons: [
          NotificationActionButton(
            key: 'TAKEN',
            label: 'Mark as Taken',
            color: Colors.green,
          ),
          NotificationActionButton(
            key: 'SNOOZE',
            label: 'Snooze 15 min',
            color: Colors.orange,
          ),
        ],
      );

      Get.snackbar(
        'Notification Sent',
        'Reminder sent for $medicineName',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error sending notification: $e');
      Get.snackbar(
        'Error',
        'Failed to send notification',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// إرسال إشعار بعد دقيقة
  void _sendNotificationInMinute(Map<String, dynamic> dose) async {
    try {
      final medicineName = dose['medicineName'] ?? 'Medicine';
      final doseTimeLabel = dose['doseTimeLabel'] ?? 'Now';
      final scheduledTime = DateTime.now().add(const Duration(minutes: 1));

      await _notificationService.scheduleNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 1,
        title: '⏰ Medication Reminder',
        body: 'Reminder: Take $medicineName at $doseTimeLabel',
        scheduledDate: scheduledTime,
        channelKey: 'medication_channel',
        payload: {
          'medicineId': dose['medicineId']?.toString() ?? '',
          'medicineName': medicineName,
          'type': 'scheduled_reminder',
        },
        allowWhileIdle: true,
        preciseAlarm: true,
        actionButtons: [
          NotificationActionButton(
            key: 'TAKEN',
            label: 'Mark as Taken',
            color: Colors.green,
          ),
          NotificationActionButton(
            key: 'SNOOZE',
            label: 'Snooze 15 min',
            color: Colors.orange,
          ),
        ],
      );

      Get.snackbar(
        'Notification Scheduled',
        'Reminder scheduled for $medicineName in 1 minute',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print('Error scheduling notification: $e');
      Get.snackbar(
        'Error',
        'Failed to schedule notification',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildDoseCard(Map<String, dynamic> dose, int index) {
    final date = dose['date'] ?? '';
    final time = dose['time'] ?? '';
    final doseTimeLabel = dose['doseTimeLabel'] ?? '';
    final medicineName = dose['medicineName'] ?? '';
    final medicineId = dose['medicineId'] ?? '';
    final status = dose['status'] ?? 'upcoming';
    final isPassed = dose['isPassed'] ?? false;

    // تحديد الألوان والحالة
    Color cardColor = Colors.white;
    Color borderColor = Colors.grey[300]!;
    Color statusColor = Colors.blue;
    String statusText = 'Upcoming';
    IconData statusIcon = Icons.schedule;

    if (status == 'completed') {
      cardColor = Colors.green[50]!;
      borderColor = Colors.green[300]!;
      statusColor = Colors.green;
      statusText = 'Completed';
      statusIcon = Icons.check_circle;
    } else if (isPassed) {
      cardColor = Colors.red[50]!;
      borderColor = Colors.red[300]!;
      statusColor = Colors.red;
      statusText = 'Missed';
      statusIcon = Icons.warning;
    } else if (status == 'upcoming') {
      cardColor = Colors.blue[50]!;
      borderColor = Colors.blue[300]!;
      statusColor = Colors.blue;
      statusText = 'Upcoming';
      statusIcon = Icons.schedule;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header مع الخلفية الملونة
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
            ),
            child: Row(
              children: [
                // أيقونة الحالة
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    statusIcon,
                    color: Colors.white,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: 12.w),
                // معلومات الدواء
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicineName,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 14.w, color: Colors.grey[600]),
                          SizedBox(width: 4.w),
                          Text(
                            doseTimeLabel,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // الوقت في دائرة
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // المحتوى الرئيسي
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // معلومات التاريخ
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16.w, color: Colors.grey[600]),
                    SizedBox(width: 8.w),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Spacer(),
                    // حالة الجرعة
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // الأزرار حسب الحالة
                if (status == 'upcoming' && !isPassed) ...[
                  // أزرار الجرعات القادمة
                  Column(
                    children: [
                      // السطر الأول: أزرار Taken و Snooze
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _markAsCompleted(medicineId),
                              icon: Icon(Icons.check, size: 16.w),
                              label: Text('Mark as Taken',
                                  style: TextStyle(fontSize: 12.sp)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _snoozeDose(medicineId),
                              icon: Icon(Icons.snooze, size: 16.w),
                              label: Text('Snooze',
                                  style: TextStyle(fontSize: 12.sp)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.orange,
                                side: const BorderSide(color: Colors.orange),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      // السطر الثاني: أزرار الإشعارات
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _sendNotificationNow(dose),
                              icon:
                                  Icon(Icons.notifications_active, size: 16.w),
                              label: Text('Notify Now',
                                  style: TextStyle(fontSize: 12.sp)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.blue,
                                side: const BorderSide(color: Colors.blue),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _sendNotificationInMinute(dose),
                              icon: Icon(Icons.timer, size: 16.w),
                              label: Text('Notify in 1 min',
                                  style: TextStyle(fontSize: 12.sp)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.purple,
                                side: const BorderSide(color: Colors.purple),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ] else if (isPassed) ...[
                  // رسالة الجرعة المفقودة
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 24.w),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Missed Dose',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                'This dose was missed and needs attention',
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else if (status == 'completed') ...[
                  // رسالة الجرعة المكتملة
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.green, size: 24.w),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dose Completed',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                'Great job! This dose has been taken',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// جدولة جميع الإشعارات مرة واحدة
  void _scheduleAllNotifications(List<Map<String, dynamic>> dosesData) async {
    try {
      int scheduledCount = 0;
      int errorCount = 0;

      // عرض loading dialog
      Get.dialog(
        Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16.h),
                Text(
                  'Scheduling notifications...',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      for (final dose in dosesData) {
        try {
          final medicineName = dose['medicineName'] ?? 'Medicine';
          final doseTimeLabel = dose['doseTimeLabel'] ?? 'Now';
          final datetimeIso = dose['datetimeIso'] ?? '';
          final status = dose['status'] ?? 'upcoming';
          final isPassed = dose['isPassed'] ?? false;

          // جدولة الإشعارات للجرعات القادمة فقط
          if (status == 'upcoming' && !isPassed && datetimeIso.isNotEmpty) {
            final scheduledDate = DateTime.parse(datetimeIso);

            // التحقق من أن الوقت لم يمر بعد
            if (scheduledDate.isAfter(DateTime.now())) {
              await _notificationService.scheduleNotification(
                id: DateTime.now().millisecondsSinceEpoch ~/ 1000 +
                    scheduledCount,
                title: '💊 Medication Reminder',
                body: 'Time to take $medicineName at $doseTimeLabel',
                scheduledDate: scheduledDate,
                channelKey: 'medication_channel',
                payload: {
                  'medicineId': dose['medicineId']?.toString() ?? '',
                  'medicineName': medicineName,
                  'type': 'scheduled_medication',
                },
                allowWhileIdle: true,
                preciseAlarm: true,
                actionButtons: [
                  NotificationActionButton(
                    key: 'TAKEN',
                    label: 'Mark as Taken',
                    color: Colors.green,
                  ),
                  NotificationActionButton(
                    key: 'SNOOZE',
                    label: 'Snooze 15 min',
                    color: Colors.orange,
                  ),
                ],
              );
              scheduledCount++;
            }
          }
        } catch (e) {
          print(
              'Error scheduling notification for ${dose['medicineName']}: $e');
          errorCount++;
        }
      }

      // إغلاق loading dialog
      Get.back();

      // عرض النتيجة
      if (scheduledCount > 0) {
        Get.snackbar(
          'Success',
          '$scheduledCount notifications scheduled successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
      }

      if (errorCount > 0) {
        Get.snackbar(
          'Warning',
          '$errorCount notifications failed to schedule',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          icon: Icon(Icons.warning, color: Colors.white),
        );
      }

      if (scheduledCount == 0 && errorCount == 0) {
        Get.snackbar(
          'Info',
          'No upcoming doses to schedule',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          icon: Icon(Icons.info, color: Colors.white),
        );
      }
    } catch (e) {
      // إغلاق loading dialog في حالة الخطأ
      Get.back();

      print('Error scheduling all notifications: $e');
      Get.snackbar(
        'Error',
        'Failed to schedule notifications',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        icon: Icon(Icons.error, color: Colors.white),
      );
    }
  }
}
