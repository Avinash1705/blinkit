// import 'package:flutter/material.dart';
//
// import 'OtpService.dart';
//  // Import the service file you created
//
// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});
//
//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//
//   final OtpService otpService = OtpService();
//
//   String? sessionId;
//   bool otpSent = false;
//   bool isLoading = false;
//
//   void sendOtp() async {
//     setState(() => isLoading = true);
//
//     final res = await otpService.sendOtp(phoneController.text.trim());
//
//     setState(() => isLoading = false);
//
//     if (res["Status"] == "Success") {
//       setState(() {
//         otpSent = true;
//         sessionId = res["Details"]; // store sessionId
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("OTP sent successfully!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${res["Details"]}")),
//       );
//     }
//   }
//
//   void verifyOtp() async {
//     if (sessionId == null) return;
//
//     setState(() => isLoading = true);
//
//     final res = await otpService.verifyOtp(sessionId!, otpController.text.trim());
//
//     setState(() => isLoading = false);
//
//     if (res["Status"] == "Success") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("OTP Verified! Login successful ✅")),
//       );
//       // Navigate to home screen
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Verification failed: ${res["Details"]}")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("OTP Verification")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: phoneController,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(
//                 labelText: "Phone Number",
//                 hintText: "Enter phone number ",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             if (otpSent) ...[
//               TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: "Enter OTP",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//
//             ElevatedButton(
//               onPressed: isLoading
//                   ? null
//                   : otpSent
//                   ? verifyOtp
//                   : sendOtp,
//               child: isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : Text(otpSent ? "Verify OTP" : "Send OTP"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
