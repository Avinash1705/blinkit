// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:swiggy/domain/AppConstant.dart';
//
// import '../ui/orderPlacedScreen.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:swiggy/domain/AppConstant.dart';
//
// import '../ui/orderPlacedScreen.dart';
//
// class RazorpayPaymentScreen extends StatefulWidget {
//   final double totalAmount;
//
//   const RazorpayPaymentScreen(this.totalAmount, {super.key});
//
//   @override
//   State<RazorpayPaymentScreen> createState() =>
//       _RazorpayPaymentScreenState();
// }
//
// class _RazorpayPaymentScreenState
//     extends State<RazorpayPaymentScreen> {
//
//   late Razorpay _razorpay;
//   bool isProcessing = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _razorpay = Razorpay();
//
//     _razorpay.on(
//       Razorpay.EVENT_PAYMENT_SUCCESS,
//       _handlePaymentSuccess,
//     );
//
//     _razorpay.on(
//       Razorpay.EVENT_PAYMENT_ERROR,
//       _handlePaymentError,
//     );
//
//     _razorpay.on(
//       Razorpay.EVENT_EXTERNAL_WALLET,
//       _handleExternalWallet,
//     );
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   // ================== OPEN CHECKOUT ==================
//
//   void _openCheckout() {
//     if (isProcessing) return;
//
//     if (widget.totalAmount <= 0) {
//       Get.snackbar(
//         "Invalid Amount",
//         "Cart total must be greater than zero",
//       );
//       return;
//     }
//
//     final amountInPaise =
//     (widget.totalAmount * 100).round();
//
//     _setProcessing(true);
//
//     final options = {
//
//       /// ✅ LIVE KEY ID ONLY (not secret)
//       'key': AppConstant.razrorPayLiveKey,
//
//       /// ⚠️ Recommended production upgrade:
//       /// create order on server and pass order_id here
//       // 'order_id': serverOrderId,
//
//       'amount': amountInPaise,
//       'currency': 'INR',
//
//       'name': 'FluxKart',
//       'description': 'Order Payment',
//
//       'timeout': 180,
//
//       'retry': {
//         'enabled': true,
//         'max_count': 2,
//       },
//
//       'prefill': {
//         'contact': AppConstant.phone ?? '',
//         'email': AppConstant.email ?? '',
//       },
//
//       'theme': {
//         'color': '#000000',
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       _setProcessing(false);
//       Get.snackbar(
//         "Error",
//         "Unable to start payment",
//       );
//     }
//   }
//
//   // ================== CALLBACKS ==================
//
//   void _handlePaymentSuccess(
//       PaymentSuccessResponse response) {
//
//     _setProcessing(false);
//
//     debugPrint(
//         "✅ PAYMENT SUCCESS ${response.paymentId}");
//
//     /// ✅ Production Step:
//     /// send paymentId + orderId + signature to backend
//     /// verify before marking order paid
//
//     Get.offAll(
//           () => const OrderPlacedScreen(),
//       transition: Transition.fadeIn,
//     );
//   }
//
//   void _handlePaymentError(
//       PaymentFailureResponse response) {
//
//     _setProcessing(false);
//
//     debugPrint(
//         "❌ PAYMENT FAIL ${response.code} ${response.message}");
//
//     Get.snackbar(
//       "Payment Failed",
//       response.message ?? "Transaction cancelled",
//       backgroundColor: Colors.red.shade100,
//       colorText: Colors.black,
//       mainButton: TextButton(
//         onPressed: _openCheckout,
//         child: const Text("Retry"),
//       ),
//     );
//   }
//
//   void _handleExternalWallet(
//       ExternalWalletResponse response) {
//
//     _setProcessing(false);
//
//     Get.snackbar(
//       "Wallet Selected",
//       response.walletName ?? "",
//     );
//   }
//
//   // ================== HELPERS ==================
//
//   void _setProcessing(bool v) {
//     if (!mounted) return;
//     setState(() => isProcessing = v);
//   }
//
//   // ================== UI ==================
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => !isProcessing,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Complete Payment"),
//           backgroundColor: Colors.black,
//         ),
//
//         body: Stack(
//           children: [
//
//             /// PAY BUTTON
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed:
//                 isProcessing ? null : _openCheckout,
//                 icon: const Icon(Icons.lock),
//                 label: Text(
//                   "Pay ₹${widget.totalAmount.toStringAsFixed(2)}",
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   foregroundColor: Colors.white,
//                   padding:
//                   const EdgeInsets.symmetric(
//                       horizontal: 30,
//                       vertical: 14),
//                 ),
//               ),
//             ),
//
//             /// BLOCKING OVERLAY
//             if (isProcessing)
//               Container(
//                 color:
//                 Colors.black.withOpacity(0.45),
//                 child: const Center(
//                   child:
//                   CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
