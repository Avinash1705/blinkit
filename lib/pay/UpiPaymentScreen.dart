// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pay/pay.dart';
//
// class GooglePayScreen extends StatefulWidget {
//   const GooglePayScreen({super.key});
//
//   @override
//   State<GooglePayScreen> createState() => _GooglePayScreenState();
// }
//
// class _GooglePayScreenState extends State<GooglePayScreen> {
//   // Create a list of payment items
//   final _paymentItems = [
//     PaymentItem(
//       label: 'Total',
//       amount: '1.00',
//       status: PaymentItemStatus.final_price,
//     ),
//   ];
//
//   late Future<PaymentConfiguration> _gpayConfig;
//
//   @override
//   void initState() {
//     super.initState();
//     // rootBundle.loadString('assets/google_pay_payment_profile.json').then((value) {
//     //   print('Google Pay Config: $value');
//     // }).catchError((e)  {
//     //   print('Error loading Google Pay config: $e');
//     // });
//     // ✅ Load payment configuration from your JSON file
//     // _gpayConfig =
//     //     PaymentConfiguration.fromAsset('assets/google_pay_payment_profile.json')
//     //         .timeout(const Duration(seconds: 5));
//     _gpayConfig = Future.value(
//       PaymentConfiguration.fromJsonString('''
//   {
//     "provider": "google_pay",
//     "data": {
//       "environment": "PRODUCTION",
//       "apiVersion": 2,
//       "apiVersionMinor": 0,
//       "allowedPaymentMethods": [{
//         "type": "CARD",
//         "parameters": {
//           "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
//           "allowedCardNetworks": ["VISA", "MASTERCARD"]
//         },
//         "tokenizationSpecification": {
//           "type": "PAYMENT_GATEWAY",
//           "parameters": {
//             "gateway": "razorpay",
//
//             "gatewayMerchantId": "rzp_test_RcxP2McpmMmsXQ"
//           }
//         }
//       }],
//       "merchantInfo": {
//         "merchantName": "FluxKart Store"
//       },
//       "transactionInfo": {
//         "totalPriceStatus": "FINAL",
//         "totalPrice": "1.00",
//         "currencyCode": "INR"
//       }
//     }
//   }
//   '''),
//     );
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Google Pay Integration'),
//         backgroundColor: Colors.black,
//       ),
//       body: FutureBuilder<PaymentConfiguration>(
//         future: _gpayConfig,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Buy Premium Plan',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // ✅ Google Pay Button with paymentConfiguration
//                 GooglePayButton(
//                   paymentConfiguration: snapshot.data!,
//                   paymentItems: _paymentItems,
//                   type: GooglePayButtonType.pay,
//                   onPaymentResult: (result) {
//                     print('Payment Result: $result');
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text("Payment Successful!")),
//                     );
//                   },
//                   loadingIndicator: const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
