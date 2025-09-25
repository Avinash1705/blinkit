// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:swiggy/domain/ApiConstants.dart';
//
// class NotificationController {
//   final String baseUrl =
//       ApiConstants.sendNotification; // Replace with your PHP API base URL
//
//   /// Send notification to a vendor (all devices)
//   Future<void> sendVendorNotification({
//     required String orderId,
//     required List<String> fcmTokens, // send token array
//   }) async {
//     try {
//       print("pppp Sending notification to tokens: $fcmTokens for orderId: $orderId");
//       final url = Uri.parse(baseUrl);
//       String? token = await FirebaseMessaging.instance.getToken();
//       print("FCM Token: $token");
//       fcmTokens.add(token??'');
//       final response = await http.post(
//         url,
//         body: {
//           'order_id': orderId,
//           'tokens': jsonEncode(fcmTokens), // convert array to JSON string
//         },
//       );
//       print("pppp Raw response: ${response.body}");
//       if (response.statusCode == 200) {
//         final res = jsonDecode(response.body);
//         print("pppp Notification Response: $res");
//           return res;
//       } else {
//         // print("pppp Error sending notification: ${response.statusCode}");
//         print("pppp Error sending notification: ${response.statusCode} - ${response.body} ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       print("pppp Exception sending notification: $e");
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

// class NotificationController {
//   final String baseUrl = "https://avitechly.com/fluxKart/apis/sendNotification.php";
//
//   /// Send notification to a specific vendor
//   Future<void> sendVendorNotification({
//     required String vendorId,
//     required String orderId,
//     required String title,
//     required String body,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(baseUrl),
//         body: {
//           "vendor_id": vendorId,
//           "order_id": orderId,
//           "title": title,
//           "body": body,
//         },
//       );
//
//       print("Raw response: ${response.body}");
//
//       final data = jsonDecode(response.body);
//       if (data["success"] == true) {
//         print("✅ Notification sent successfully!");
//       } else {
//         print("❌ Failed: ${data["message"]}");
//       }
//     } catch (e) {
//       print("Exception sending notification: $e");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationController {
  final String baseUrl = "https://avitechly.com/fluxKart/apis/sendMessage.php"; // 🔴 Change to your PHP API URL

  /// Save FCM token to backend
  Future<bool> saveToken(String vendorId, String fcmToken) async {
    print("Saving token for vendorId: $vendorId, fcmToken: $fcmToken");
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          "action": "save_token",
          "vender_id": vendorId,
          "fcm_token": fcmToken,
        },
      );

      final data = jsonDecode(response.body);
      if (data["success"] == true) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error saving token: $e");
      return false;
    }
  }

  /// Send notification to vendor using phone
  Future<bool> sendNotification({
    required String vendorId,
    required String phone,
    required String title,
    required String body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          "action": "send_notification",
          "vender_id": vendorId,
          "phone": phone,
          "title": title,
          "body": body,
        },
      );

      final data = jsonDecode(response.body);
      print("Notification Response: $data");

      if (data["name"] == "projects/chatroom-2e5b7/messages/") {
        return true;
      }
      return false;
    } catch (e) {
      print("Error sending notification: $e");
      return false;
    }
  }
}
