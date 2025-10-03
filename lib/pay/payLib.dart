// import 'package:flutter/material.dart';
// import 'package:upi_india/upi_india.dart';
// import 'package:pay/pay.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   UpiIndia _upiIndia = UpiIndia();
//   late Future<List<UpiApp>> _appsFuture;
//   PaymentConfiguration? _googlePayConfig;
//   final _paymentItems = [
//     PaymentItem(
//       label: 'Order Total',
//       amount: '1.00',
//       status: PaymentItemStatus.final_price,
//     )
//   ];
//
//   @override
//   void initState() {
//     _appsFuture = _upiIndia.getAllUpiApps(mandatoryTransactionId: false);
//     PaymentConfiguration.fromAsset('assets/google_pay_payment_profile.json')
//         .then((config) {
//       setState(() {
//         _googlePayConfig = config;
//       });
//     });
//     super.initState();
//   }
//
//   Future<void> _startUpiPayment(String appName, String receiverUpiId) async {
//     try {
//       final response = await _upiIndia.startTransaction(
//         app: UpiApp.allBank,
//         receiverUpiId: receiverUpiId,
//         receiverName: "FluxKart",
//         transactionRefId: "TXN_${DateTime.now().millisecondsSinceEpoch}",
//         transactionNote: "FluxKart Order Payment",
//         amount: 1.00,
//       );
//
//       if (response.status == UpiPaymentStatus.SUCCESS) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Payment successful via UPI!")),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("UPI Payment Failed!")),
//         );
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
//
//   void _onGooglePayResult(paymentResult) {
//     debugPrint('Google Pay Result: $paymentResult');
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Google Pay Payment Successful!")),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("FluxKart Checkout")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               "Choose a payment method",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//
//             // ✅ Google Pay Button
//             GooglePayButton(
//               // paymentConfigurationAsset: _googlePayConfig != null ? 'assets/google_pay_payment_profile.json' : null,
//               paymentItems: _paymentItems,
//               type: GooglePayButtonType.pay,
//               onPaymentResult: _onGooglePayResult,
//               loadingIndicator: const Center(child: CircularProgressIndicator()), paymentConfiguration: _googlePayConfig!,
//             ),
//
//             const SizedBox(height: 40),
//             const Text("Or pay via UPI", style: TextStyle(fontSize: 16)),
//
//             FutureBuilder<List<UpiApp>>(
//               future: _appsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Text("No UPI apps found.");
//                 } else {
//                   return Wrap(
//                     spacing: 10,
//                     runSpacing: 10,
//                     children: snapshot.data!
//                         .map((app) => InkWell(
//                       onTap: () => _startUpiPayment(app.name, "arawat696@okhdfcbank"),
//                       child: Column(
//                         children: [
//                           Image.memory(app.icon, height: 60, width: 60),
//                           Text(app.name),
//                         ],
//                       ),
//                     ))
//                         .toList(),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
