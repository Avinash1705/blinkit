

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiggy/domain/ApiConstants.dart';

import '../dependency/dependency.dart';
import '../domain/AppConstant.dart';

Future<void> showNotificationMessage(String title, String body) async {
  print("Showing local notification with title: $title and body: $body");
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
    title,
    body,
    platformChannelSpecifics,
  );
}

Future<void> showNotification(String str) async {
  print("Showing local notification with message: $str");
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
    'This is a local Notify. $str',
    platformChannelSpecifics,
  );
}


void showStyledPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // force user to choose
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔔 Icon
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_active,
                  size: 48,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),

              // 📝 Title
              const Text(
                "Enable Notifications",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // 📄 Message
              const Text(
                "Stay updated with the latest alerts and offers. "
                    "Would you like to allow notifications?",
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // ✅ Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "No, Thanks",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),

                  // Allow button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);

                      final granted = await flutterLocalNotificationsPlugin
                          .resolvePlatformSpecificImplementation<
                          AndroidFlutterLocalNotificationsPlugin>()
                          ?.requestNotificationsPermission();
                      AppConstant.notificationGranted = granted ?? false;
                      debugPrint("Notification permission granted: $granted");
                    },
                    child: const Text(
                      "Allow",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

void remoteFcm(){
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  print("FCM Token Remote: ${messaging.getToken().then((value) => print(value))}");

}
void setupFCM() {
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // print("FCM Token: ${messaging.getToken()}");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message while in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('dddd Message title: ${message.notification!.title}');
      print('dddd Message body: ${message.notification!.body}');
      print("dddd name ${message.notification!.android!.channelId}");
      showNotification(message.notification!.body ?? "No body");
      print('Message also contained a notification: ${message.notification}');
    }
  });
}
