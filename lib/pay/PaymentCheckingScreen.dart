import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:swiggy/domain/ApiConstants.dart';
import 'package:swiggy/pay/razoryPayment.dart';

import '../ui/orderPlacedScreen.dart';

class PaymentCheckingScreen extends StatefulWidget {
  final String phoneNumber;
  final double expectedAmount;

  const PaymentCheckingScreen({super.key, required this.phoneNumber, required  this.expectedAmount});

  @override
  State<PaymentCheckingScreen> createState() => _PaymentCheckingScreenState();
}

class _PaymentCheckingScreenState extends State<PaymentCheckingScreen> {
  double paidAmount  = 0.0;
  @override
  void initState() {
    super.initState();
    verifyLoop();
  }

  bool _checking = false;

  Future<void> verifyLoop() async {

    if (_checking) return;
    _checking = true;

    for (int i = 0; i < 8; i++) {

      final data = await checkPayment();

      final status = data["status"];
       paidAmount =
      (data["paid_total"] ?? 0).toDouble();

      // ✅ success — SUM reached
      if (paidAmount >= widget.expectedAmount) {
        _checking = false;
        Get.offAll(() => const OrderPlacedScreen());
        return;
      }

      // ❌ explicit failed event (rare but safe)
      if (status == "failed") {
        _checking = false;
        Get.snackbar("Payment Failed", "Transaction failed");
        Get.back();
        return;
      }

      await Future.delayed(const Duration(seconds: 3));
    }

    _checking = false;

    // 🔻 Underpaid after polling window → show retry dialog
    final diff = widget.expectedAmount - paidAmount;

    Get.dialog(
      AlertDialog(
        title: const Text("Amount Pending"),
        content: Text(
          "You paid ₹${paidAmount.toStringAsFixed(2)}\n"
              "Please pay ₹${diff.toStringAsFixed(2)} more.",
        ),
        actions: [

          // 🔁 Retry
          TextButton(
            onPressed: () async {
              Get.back();

              await openPayment();   // open razorpay.me again

              verifyLoop();          // restart polling
            },
            child: const Text("Retry Payment"),
          ),

          // ❌ Cancel
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }


  /* Future<void> verifyLoop() async {
    for (int i = 0; i < 8; i++) {

      final status = await checkPaid();

      if (status == "paid") {
        Get.offAll(() => const OrderPlacedScreen());
        return;
      }

      if (status == "failed") {
        Get.snackbar(
          "Payment Failed",
          "Transaction failed",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.back();
        return;
      }

      await Future.delayed(const Duration(seconds: 3));
    }

    // timeout
    Get.snackbar(
      "Payment",
      "Payment not confirmed yet. Please retry.",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.back();
  }*/

  Future<Map<String, dynamic>> checkPayment() async {

    final uri = Uri.parse(
        ApiConstants.orderStatusByRazorPay
    ).replace(queryParameters: {
      "phone": widget.phoneNumber,
    });

    final r = await http.get(uri);

    if (r.statusCode != 200) {
      return {"status": "error"};
    }

    return jsonDecode(r.body);
  }

/*  Future<bool> checkPaid() async {
    final url = "${ApiConstants.orderStatusByRazorPay}"
        "?phone=${widget.orderId}";

    final r = await http.get(Uri.parse(url));
    final data = jsonDecode(r.body);
    print("checkmYPay ${r}");
    return data["paid"] == true;
  }*/

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Verifying payment..."),
          ],
        ),
      ),
    );
  }
}
