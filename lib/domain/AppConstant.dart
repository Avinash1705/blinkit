

import 'package:shared_preferences/shared_preferences.dart';

class AppConstant {
  static const String appName = "My Flutter App";
  static const String apiBaseUrl = "https://api.example.com";
  static const int timeoutDuration = 30; // in seconds
  static const String defaultLanguage = "en";
  static const String supportEmail = "";
  static  bool notificationGranted = false;



  /*customer profile */
  static  String customer_id = "";
  static  String customer_name = "";
  static  String phone = "";
  static  String email = "arawat696@gmail.com";
  static  String location = "";
  static  String pin = "226040";
  static  String customer_profile = "";
  static  String vendorDetails = "vendorKey";

  //secretKey
  static  String msgAuthKey = "";
  static  String msgWidgetKey = "";
  static  String razrorPayLiveKey = "";
  static  String paymentUser = "https://razorpay.me/@avinashrawat";
}
