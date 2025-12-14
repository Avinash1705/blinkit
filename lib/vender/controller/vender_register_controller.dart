import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/ui/bottomNav/bottomNavScreen.dart';

import '../../ui/login/loginScreenStatic.dart';
import '../venderModels/vendeRegisterResponseModel.dart';

class VendorRegisterController {
  final formKey = GlobalKey<FormState>();

  // final vendorIdController = TextEditingController();
  final nameController = TextEditingController();
  final shopNameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final pincodeController = TextEditingController();

  final apiUrl =
      ApiConstants.registerVenders; // Replace with your actual URL

  void dispose() {
    // vendorIdController.dispose();
    nameController.dispose();
    shopNameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    pincodeController.dispose();
  }

  Future<void> registerVendor(BuildContext context,File imgFile) async {
    if (!formKey.currentState!.validate()) return;
    late vendeRegisterResponseModel urRes;
    try {
      // ✅ Get FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      print("Device FCM Token: $fcmToken");
      var request = await http.MultipartRequest(
          'POST',
          Uri.parse("$apiUrl?vender_name=${nameController.text}"
              "&shop_name=${shopNameController.text}"
              "&phone=${phoneController.text}"
              "&pincode=${pincodeController.text}"
              "&location=${locationController.text}"),
      );
      request.fields['name'] = nameController.text;
      request.fields['fcm_token'] = fcmToken ?? '';
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // must match $_FILES['image'] in PHP
          imgFile.path,
        ),
      );
      print("Request URL: ${imgFile.path}");
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("vendor response: ${response.body}");
      urRes = vendeRegisterResponseModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(urRes.status ?? 'Vendor registered successfully')));
        Get.off(BottomNavScreen(index: 0));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register vendor')),
        );
      }
    } catch (ex) {
      print("Error during registration: $ex");
    }
  }
}
