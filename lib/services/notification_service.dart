import 'dart:convert';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder/app/routes/routing_service.dart';
import 'package:reminder/models/reminder.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  factory NotificationService() => NotificationService._();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings, 
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log('Notification Response : $response');

        if(response.payload != null){
          log('${response.payload}');
          Map<String, dynamic> data = jsonDecode(response.payload!);
          Reminder reminderData = Reminder.formMap(data);
          RoutingService.navigateToViewSingleReminderPage(reminder: reminderData);
        }
      },
    );
  }

  Future<void> setSheduleNotification(Map<String, dynamic> reminder, DateTime sheduleDateTime) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'ID of Notification',
      'Channel name of notification',
      channelDescription: 'Channel description of Notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      fullScreenIntent: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      reminder['id'] ?? 0,
      reminder['title'],
      reminder['desc'],
      tz.TZDateTime.from(sheduleDateTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: jsonEncode(reminder)
    );
  }

  void cancleNotification({required int id}) {
    _flutterLocalNotificationsPlugin.cancel(id);
  }
}
