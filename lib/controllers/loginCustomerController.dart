import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/domain/ApiConstants.dart';

import '../ui/bottomNav/bottomNavScreen.dart';

class LoginCustomerController {

 static Future loginRegisteredCustomer(String phone,BuildContext context) async {

    var url = "${ApiConstants.getRegisterCustomer}?phone=$phone";

    try {
      final response = await http.get(Uri.parse(url));
      // print("my login response ${response.body}");

        final data = json.decode(response.body);

        if (data["success"] == true) {
          final customer = data["data"];

          Map<String, dynamic> customerMap = {
            "customer_id": customer["customer_id"],
            "customer_name": customer["customer_name"],
            "phone": customer["phone"],
            "location": customer["location"],
            "customer_profile": customer["customer_profile"],
          };
          print("test profie1  ${customerMap}");
          saveUserData(customerMap);
          Get.to(BottomNavScreen(index: 0));
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update subscription: ${response.statusCode}")),
          );
        }
      // if (response.statusCode == 200) {
      //   // Handle successful response
      //   print("Subscription updated successfully ");
      //   /*need to update login */
      //   // Get.to(BottomNavScreen(index: 0));
      //   // return response.body;
      // } else {
      //
      //   // Handle error response
      //   print("Failed to update subscription: ${response.statusCode}");
      // }
    } catch (e) {
      // Handle exceptions
      print("Error updating subscription: $e");
    }
  }
static Future<void> saveUserData(Map<String, dynamic> user) async {
   final prefs = await SharedPreferences.getInstance();
   await prefs.setString('customer_id', user['customer_id']);
   await prefs.setString('customer_name', user['customer_name']);
   await prefs.setString('phone', user['phone']);
   await prefs.setString('location', user['location']);
   await prefs.setString('customer_profile', user['customer_profile']);
   await prefs.setString('token', user['token']); // if using JWT
 }
}


