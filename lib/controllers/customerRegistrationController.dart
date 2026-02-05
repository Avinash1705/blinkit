

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';

import '../ui/customerProfile/LoginCustomerProfileScreen.dart';

class CustomerRegistrationController {
  // This class will handle customer registration logic
  // For example, it can include methods to validate input, save customer data, etc.

  static Future registerCustomer(Map<String, dynamic> product,File imgUrl,BuildContext context) async {
    var url = Uri.parse(ApiConstants.registerCustomer);
    // Logic to register a customer
    var request = http.MultipartRequest(
      'POST',
      url);
    // ✅ Add text fields
    request.fields['customer_name'] = product["customer_name"];
    request.fields['phone'] = product["phone"];
    request.fields['location'] = product["location"];

    request.headers.addAll({
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // must match $_FILES['image'] in PHP
        imgUrl.path,
      ),
    );
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    try {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${jsonDecode(response.body)['status']}  🎉")),
        );
        Get.off(LoginCustomerProfileScreen());
        // print("DDDDDD Customer registered successfully: ${response.body}");
      } else {
        print("DDDDDD Failed to register customer: ${response.statusCode}");
      }
    } catch (e) {
      print("DDDDDD Error registering customer: $e");
    }
    return response.body;
  }


  bool validateEmail(String email) {
    // Simple email validation logic
    return email.contains('@') && email.contains('.');
  }
}