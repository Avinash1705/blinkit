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

  const PaymentCheckingScreen({
    super.key,
    required this.phoneNumber,
    required this.expectedAmount,
  });

  @override
  State<PaymentCheckingScreen> createState() =>
      _PaymentCheckingScreenState();
}

class _PaymentCheckingScreenState
    extends State<PaymentCheckingScreen> {

  double paidAmount = 0.0;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    print("PaymentCheckingScreen opened");
    verifyLoop();
  }

  /// =========================
  /// PAYMENT VERIFY LOOP
  /// =========================

  Future<void> verifyLoop() async {
    try {
      if (_checking) return;
      _checking = true;

      for (int i = 0; i < 8; i++) {

        print("Polling attempt $i");

        final data = await checkPayment();
        print("API DATA = $data");

        final status = data["status"];

        /// ✅ SAFE PARSE (string/num safe)
        paidAmount = double.tryParse(
          (data["paid_total"] ?? 0).toString(),
        ) ?? 0.0;

        print("Paid = $paidAmount  Expected = ${widget.expectedAmount}");

        /// ✅ SUCCESS
        if (paidAmount >= widget.expectedAmount) {
          _checking = false;

          if (mounted) {
            Get.offAll(() => const OrderPlacedScreen());
          }
          return;
        }

        /// ❌ FAILED STATUS
        if (status == "failed") {
          _checking = false;
          Get.snackbar(
            "Payment Failed",
            "Transaction failed",
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.back();
          return;
        }

        /// ⏳ wait before next poll
        await Future.delayed(
          const Duration(seconds: 3),
        );
      }

      _checking = false;

      /// 🔻 UNDERPAID → retry dialog
      final diff = widget.expectedAmount - paidAmount;

      Get.dialog(
        AlertDialog(
          title: const Text("Amount Pending"),
          content: Text(
            "You paid ₹${paidAmount.toStringAsFixed(2)}\n"
                "Please pay ₹${diff.toStringAsFixed(2)} more.",
          ),
          actions: [

            /// 🔁 Retry
            TextButton(
              onPressed: () async {
                Get.back();
                await openPayment();
                verifyLoop();
              },
              child: const Text("Retry Payment"),
            ),

            /// ❌ Cancel
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

    } catch (e) {
      print("VERIFY LOOP ERROR = $e");
      _checking = false;

      Get.snackbar(
        "Error",
        "Payment check failed",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// =========================
  /// API CALL
  /// =========================

  Future<Map<String, dynamic>> checkPayment() async {

    /// normalize phone for your DB (+91 format)
    final phone = widget.phoneNumber.startsWith("+91")
        ? widget.phoneNumber
        : "+91${widget.phoneNumber}";

    final uri = Uri.parse(
      ApiConstants.orderStatusByRazorPay,
    ).replace(queryParameters: {
      "phone": phone,
    });

    final r = await http.get(uri);

    print("HTTP STATUS = ${r.statusCode}");
    print("HTTP BODY = ${r.body}");

    if (r.statusCode != 200) {
      return {"status": "error", "paid_total": 0};
    }

    return jsonDecode(r.body);
  }

  /// =========================
  /// UI
  /// =========================

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
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
