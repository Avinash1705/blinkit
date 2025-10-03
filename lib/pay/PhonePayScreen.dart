// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:android_intent_plus/flag.dart';
//
// class PhonePePaymentScreen extends StatefulWidget {
//   const PhonePePaymentScreen({super.key});
//
//   @override
//   State<PhonePePaymentScreen> createState() => _PhonePePaymentScreenState();
// }
//
// class _PhonePePaymentScreenState extends State<PhonePePaymentScreen> {
//   // Receiver details (replace with yours)
//   // final String upiId = "arawat696@okhdfcbank";
//   final String upiId = "avinashrawat1705-2@okicici";
//   final String receiverName = "Avinash Rawat";
//
//   // amount should be a string with two decimals
//   String _formatAmount(num amount) => amount.toStringAsFixed(2);
//
//   // Unique transaction reference per attempt
//   String _newTr() =>
//       "FLTR${DateTime.now().millisecondsSinceEpoch}${Random().nextInt(9999)}";
//
//   // Build a standards-compliant UPI URI
//   Uri _buildUpiUri({
//     required String pa,
//     required String pn,
//     required String am, // already formatted "1.00"
//     required String tr, // unique each attempt
//     String tn = "Order Payment",
//   }) {
//     // Encode only values (not keys)
//     final params = {
//       'pa': pa,
//       'pn': pn,
//       'am': am,
//       'cu': 'INR',
//       'tr': tr,
//       'tn': tn,
//       // Optional (only if you have): 'url': 'https://your.domain/order/123'
//       // Avoid unsupported params. Keep ASCII in pn/tn to be safe.
//     };
//
//     final query = params.entries
//         .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
//         .join('&');
//
//     return Uri.parse('upi://pay?$query');
//   }
//   pay(){
//     String GOOGLE_PAY_PACKAGE_NAME = "com.google.android.apps.nbu.paisa.user";
//     int GOOGLE_PAY_REQUEST_CODE = 123;
//
//     Uri uri =
//     new Uri.Builder()
//         .scheme("upi")
//         .authority("pay")
//         .appendQueryParameter("pa", "your-merchant-vpa@xxx")
//         .appendQueryParameter("pn", "your-merchant-name")
//         .appendQueryParameter("mc", "your-merchant-code")
//         .appendQueryParameter("tr", "your-transaction-ref-id")
//         .appendQueryParameter("tn", "your-transaction-note")
//         .appendQueryParameter("am", "your-order-amount")
//         .appendQueryParameter("cu", "INR")
//         .appendQueryParameter("url", "your-transaction-url")
//         .build();
//     Intent intent = new Intent(Intent.ACTION_VIEW);
//     intent.setData(uri);
//     intent.setPackage(GOOGLE_PAY_PACKAGE_NAME);
//     activity.startActivityForResult(intent, GOOGLE_PAY_REQUEST_CODE);
//   }
//   Future<void> _launchWithPackage(Uri upiUri, String package) async {
//     // Preferred: use an explicit Android intent to target a PSP
//     final intent = AndroidIntent(
//       action: 'android.intent.action.VIEW',
//       data: upiUri.toString(),
//       package: package,
//       flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
//     );
//     await intent.launch();
//   }
//
//   void _show(String msg) =>
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//
//   Future<void> payWithPhonePe() async {
//     if (!Platform.isAndroid) {
//       _show("UPI works only on Android in this flow.");
//       return;
//     }
//     final tr = _newTr();
//     final uri = _buildUpiUri(
//       pa: upiId,
//       pn: receiverName,
//       am: _formatAmount(1), // "1.00"
//       tr: tr,
//       tn: "Order Payment", // keep short ASCII
//     );
//
//     try {
//       await _launchWithPackage(uri, 'com.phonepe.app');
//     } catch (e) {
//       _show("PhonePe not installed or couldn't be opened.");
//     }
//   }
//
//   Future<void> payWithGpay() async {
//     if (!Platform.isAndroid) {
//       _show("UPI works only on Android in this flow.");
//       return;
//     }
//     final tr = _newTr();
//     final uri = _buildUpiUri(
//       pa: upiId,
//       pn: receiverName,
//       am: _formatAmount(1), // "1.00"
//       tr: tr,
//       tn: "Order Payment",
//     );
//
//     try {
//       await _launchWithPackage(
//           uri, 'com.google.android.apps.nbu.paisa.user'); // GPay package
//     } catch (e) {
//       // Fallback: let user pick any UPI app
//       final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
//       if (!launched) {
//         _show("No UPI app found to handle this payment.");
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pay via UPI")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton.icon(
//               onPressed: payWithPhonePe,
//               icon: const Icon(Icons.payment),
//               label: const Text("Pay ₹1 via PhonePe"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepPurple,
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: payWithGpay,
//               icon: const Icon(Icons.payment),
//               label: const Text("Pay ₹1 via GPay"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.amber.withOpacity(0.8),
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }