import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/AppConstants.dart';

import '../venderModels/vendeRegisterResponseModel.dart';

class VendorRegisterController {
  final formKey = GlobalKey<FormState>();

  final vendorIdController = TextEditingController();
  final nameController = TextEditingController();
  final shopNameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  final apiUrl =
      "http://192.168.1.29:8080/fluxkart/apis/register_vender.php"; // Replace with your actual URL

  void dispose() {
    vendorIdController.dispose();
    nameController.dispose();
    shopNameController.dispose();
    phoneController.dispose();
    locationController.dispose();
  }

  Future<void> registerVendor(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    late vendeRegisterResponseModel urRes;
    try {
      var response = await http
          .post(
              Uri.parse(
                  "${apiUrl}?vender_id=${vendorIdController.text.trim()
                  }&vender_name=${nameController.text}"
                      "&shop_name=${shopNameController.text}"
                      "&phone=${phoneController.text}"
                      "&location=${locationController.text}"),
              )
          .timeout(Duration(seconds: 10));
      print("vendor response: ${response.body}");
      urRes = vendeRegisterResponseModel.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(urRes.status ?? 'Vendor registered successfully')),
        );
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
