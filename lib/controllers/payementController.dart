

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swiggy/domain/AppConstants.dart';
import 'package:http/http.dart' as http;

import '../vender/ui/vender_dashboard.dart';

class PaymentController {


  // Add methods and properties related to payment processing here
  void processPayment(double amount) {
    String url = AppConstants.updateValidity+"?phone=4444444444&valid=3";
    // Logic to process payment
    print("Processing payment of \$${amount}");
  }

  void refundPayment(double amount) {
    // Logic to refund payment
    print("Refunding payment of \$${amount}");
  }

  Future<dynamic> updateSubscription(String phone, int valid) async {
    // Logic to update subscription
    String url = AppConstants.updateValidity + "?phone=$phone&valid=$valid";

    try {
      final response = await http.get(Uri.parse(url));
      // print("Response status: ${jsonDecode(response.body)['data']}");
      if (response.statusCode == 200) {
        // Handle successful response
        print("Subscription updated successfully");
        Get.off(VendorDashboard(
          vendorDetails: jsonDecode(response.body)['data']
        ));
        return response.body;
      } else {
        // Handle error response
        print("Failed to update subscription: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle exceptions
      print("Error updating subscription: $e");
      return null;
    }
  }
}