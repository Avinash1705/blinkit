import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentScreen extends StatefulWidget {
  const RazorpayPaymentScreen({super.key});

  @override
  State<RazorpayPaymentScreen> createState() => _RazorpayPaymentScreenState();
}

class _RazorpayPaymentScreenState extends State<RazorpayPaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    // Handle callbacks
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // VERY IMPORTANT: removes listeners
    super.dispose();
  }

  void _openCheckout() {
    var options = {
      'key': 'rzp_test_RcxP2McpmMmsXQ', // your Razorpay Test Key
      // 'key': 'rzp_live_RieABQDvK5VhlF', // your Razorpay live
      'amount': 1, // amount in paise => 100 INR
      'name': 'FluxKart Store',
      'description': 'Test Payment',
      'timeout': 120, // in seconds
      'prefill': {
        'contact': '9999999999',
        'email': 'test@fluxkart.com',
      },
      'external': {
        // 'wallets': ['paytm'] // optional
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      print("handlePay error $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("handlePay Success ${response.paymentId}");
    debugPrint('✅ Payment Successful: ${response.paymentId}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful! ID: ${response.paymentId}')),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('❌ Payment Failed: ${response.code} | ${response.message}');
    print("handlePay failed ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('💰 External Wallet: ${response.walletName}');
    print("handlePay wallet ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet: ${response.walletName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Razorpay Test Payment')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _openCheckout,
          icon: const Icon(Icons.payment),
          label: const Text('Pay ₹1 via Razorpay (Test)'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          ),
        ),
      ),
    );
  }
}
