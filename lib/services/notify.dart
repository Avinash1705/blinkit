

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../dependency/dependency.dart';

Future<void> showNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Hello!',
    'This is a local notification.',
    platformChannelSpecifics,
  );
}