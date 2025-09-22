
import 'dart:io';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:get_storage/get_storage.dart';

import '../controllers/loginCustomerController.dart';
import '../domain/AppConstant.dart';
import '../services/notify.dart';
import '../ui/category/searchController.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> init() async {
  // await GetStorage.init();
  // localNotification();

  Get.lazyPut(() => SearchController());
  initNotifications();
  // requestNotificationPermission();
  /*Requesting permission */
  showStyledPermissionDialog(Get.context!);
  // Get.lazyPut(() => LoginCustomerController());

  // await Firebase.initializeApp();
  // Get.lazyPut(() => LivePageController());
  // Get.lazyPut(() => LiveStreamingController());
  // Get.lazyPut(() => LoginPageController());
  // loadUserData();

}

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

// Future<void> requestNotificationPermission() async {
//   // ✅ Request permission on Android 13+
//   if (Platform.isAndroid) {
//     final bool? granted = await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//
//     // print("Notification permission granted: $granted");
//     AppConstant.notificationGranted = granted ?? false;
//   }
// }
//  Future<void> showNotification() async {
//
//    // ✅ Request permission on Android 13+
//    if (Platform.isAndroid) {
//      final bool? granted = await flutterLocalNotificationsPlugin
//          .resolvePlatformSpecificImplementation<
//          AndroidFlutterLocalNotificationsPlugin>()
//          ?.requestNotificationsPermission();
//
//      print("Notification permission granted: $granted");
//    }
//
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     importance: Importance.high,
//     priority: Priority.high,
//   );
//
//   const NotificationDetails platformChannelSpecifics =
//   NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'Hello!',
//     'This is a local notification.',
//     platformChannelSpecifics,
//   );
// }


Future<void> loadUserData(SharedPreferences prefs) async {
   // final prefs = await SharedPreferences.getInstance();
  print("test profie inti  Worked");
  AppConstant.customer_id = prefs.getString('customer_id') ?? '';
  AppConstant.customer_name = prefs.getString('customer_name') ?? '';
  AppConstant.phone = prefs.getString('phone') ?? '';
  AppConstant.location =  prefs.getString('location') ?? '';
  AppConstant.customer_profile = prefs.getString('customer_profile') ?? '';
  print("test profie inti  ${AppConstant.customer_id}");
}


