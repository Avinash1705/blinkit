import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:swiggy/domain/AppConstant.dart';

import '../ui/orderPlacedScreen.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  final double totalAmount; // in rupees

  const RazorpayPaymentScreen(this.totalAmount, {super.key});

  @override
  State<RazorpayPaymentScreen> createState() =>
      _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  late Razorpay _razorpay;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _openCheckout() {
    if (isProcessing) return;

    setState(() => isProcessing = true);

    final int amountInPaise =
    (widget.totalAmount * 100).round();

    var options = {
      'key': AppConstant.razrorPayLiveKey,
      'amount': amountInPaise,
      'name': 'FluxKart',
      'description': 'Order Payment',
      'timeout': 120,
      'prefill': {
        'contact': AppConstant.phone ?? '',
        'email': 'test@fluxkart.com' ?? '',
      },
      'theme': {
        'color': '#000000',
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() => isProcessing = false);
      Get.snackbar("Error", "Unable to start payment");
    }
  }

  // ---------------- CALLBACKS ----------------

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() => isProcessing = false);

    debugPrint("✅ Payment Success: ${response.paymentId}");

    Get.offAll(
          () => const OrderPlacedScreen(),
      transition: Transition.fadeIn,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => isProcessing = false);

    debugPrint(
        "❌ Payment Failed: ${response.code} | ${response.message}");

    Get.snackbar(
      "Payment Failed",
      response.message ?? "Something went wrong",
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() => isProcessing = false);

    debugPrint("💰 Wallet: ${response.walletName}");

    Get.snackbar(
      "Wallet Selected",
      response.walletName ?? '',
    );
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton.icon(
              onPressed: isProcessing ? null : _openCheckout,
              icon: const Icon(Icons.lock),
              label: Text(
                'Pay ₹${widget.totalAmount.toStringAsFixed(2)}',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 14),
              ),
            ),
          ),

          // 🔒 BLOCKING LOADER
          if (isProcessing)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
