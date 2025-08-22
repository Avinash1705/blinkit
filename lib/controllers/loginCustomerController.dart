import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/domain/AppConstant.dart';

import '../ui/bottomNav/bottomNavScreen.dart';

class LoginCustomerController extends ChangeNotifier {

  static Future loginRegisteredCustomer(String phone,
      BuildContext context) async {
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
        saveUserDataToAppConstant(customerMap);
        await saveUserData(customerMap);
        Get.offAll(BottomNavScreen(index: 0));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              "Failed to update subscription: ${response.statusCode}")),
        );
      }
    } catch (e) {
      // Handle exceptions
      print("Error updating subscription: $e");
    }
    // notifyListeners();
  }

  static Future<void> saveUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('customer_id', user['customer_id']);
    await prefs.setString('customer_name', user['customer_name']);
    await prefs.setString('phone', user['phone']);
    await prefs.setString('location', user['location']);
    await prefs.setString('customer_profile', user['customer_profile']);
    if (user['token'] != null) {
      await prefs.setString('token', user['token']);
    }
    print("test profie3  ${user['customer_id']}");
    /*i need to update */

  }

  static void saveUserDataToAppConstant(Map<String, dynamic> user) {
    AppConstant.customer_id = user['customer_id'];
    AppConstant.customer_name = user['customer_name'];
    AppConstant.phone = user['phone'];
    AppConstant.location = user['location'];
    AppConstant.customer_profile = user['customer_profile'];
    print("test profie2  ${AppConstant.customer_id} ${AppConstant
        .customer_name} ${AppConstant.phone} ${AppConstant
        .location} ${AppConstant.customer_profile}");
  }

  // static Future<void> saveUserDataNew() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('customer_id', AppConstant.customer_id);
  //   await prefs.setString('customer_name', AppConstant.customer_name);
  //   await prefs.setString('phone', AppConstant.phone);
  //   await prefs.setString('location', AppConstant.location);
  //   await prefs.setString('customer_profile', AppConstant.customer_profile);
  //   // await prefs.setString('token', user['token']); // if using JWT
  //   print("test profie3  ${AppConstant.customer_id}");
  //
  //   /*i need to update */
  //   AppConstant.customer_id = prefs.getString('customer_id') ?? '';
  //   AppConstant.customer_name = prefs.getString('customer_name') ?? '';
  //   AppConstant.phone = prefs.getString('phone') ?? '';
  //   AppConstant.location = prefs.getString('location') ?? '';
  //   AppConstant.customer_profile = prefs.getString('customer_profile') ?? '';
  //   print("test profie4  ${AppConstant.customer_id} ${AppConstant.customer_name}");
  // }
}

