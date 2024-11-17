// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AlarmScheduler {
  static Future<void> scheduleAlarm(DateTime alarmTime) async {
    final tz.TZDateTime scheduleTime = tz.TZDateTime.from(alarmTime, tz.local);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .zonedSchedule(
      1, // Notification ID
      'Alarm', // Notification title
      'Wake up! It\'s time!', // Notification body
      scheduleTime, // Scheduled time
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'alarm_channel_id1',
          'Alarm Channel1',
          channelDescription: 'Channel for alarm notifications',
          importance: Importance.max,
          priority: Priority.high,
          fullScreenIntent: true,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('alarm_ringtone'),
        ),
        iOS: DarwinNotificationDetails(
          sound: 'alarm_ringtone.mp3',
        )
      ),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    )
        .catchError((e) {
      debugPrint(e.toString());
    });
  }
}
