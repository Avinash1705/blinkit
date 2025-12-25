import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:swiggy/domain/ApiConstants.dart';
import '../venderModels/vendeRegisterResponseModel.dart';
import '../../ui/login/roleBasedLogin/RoleSelectionPage.dart';

class VendorRegisterController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final shopNameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final pincodeController = TextEditingController();

  final String apiUrl = ApiConstants.registerVenders;

  /// 🔥 Pure business logic (no loader, no setState)
  Future<void> registerVendor({
    required BuildContext context,
    required File imgFile,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      // 1️⃣ Get FCM token
      final String? fcmToken =
      await FirebaseMessaging.instance.getToken();

      // 2️⃣ Build request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          "$apiUrl?"
              "vender_name=${nameController.text}"
              "&shop_name=${shopNameController.text}"
              "&phone=${phoneController.text}"
              "&pincode=${pincodeController.text}"
              "&location=${locationController.text}",
        ),
      );

      request.fields['name'] = nameController.text;
      request.fields['fcm_token'] = fcmToken ?? '';

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imgFile.path,
        ),
      );

      // 3️⃣ Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint("Vendor register response: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception("Server error");
      }

      final result =
      vendeRegisterResponseModel.fromJson(jsonDecode(response.body));

      // 4️⃣ Success → Navigate
      Get.off(
        RoleSelectionPage(phoneController.text),
      );

      // 5️⃣ Optional success message
      Get.snackbar(
        "Success",
        result.status ?? "Vendor registered successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint("Vendor register error: $e");

      // ❌ Do NOT navigate
      Get.snackbar(
        "Error",
        "Vendor registration failed",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void dispose() {
    nameController.dispose();
    shopNameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    pincodeController.dispose();
  }
}
