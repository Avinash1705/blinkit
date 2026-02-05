// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:swiggy/domain/ApiConstants.dart';
//
// import '../../../controllers/getUserRoleController.dart';
// import '../../../model/userRole.dart';
// import 'RoleSelectionPage.dart';
//
// class OTPVerificationPage extends StatefulWidget {
//   final String phoneNumber;
//   const OTPVerificationPage({super.key, required this.phoneNumber});
//
//   @override
//   State<OTPVerificationPage> createState() => _OTPVerificationPageState();
// }
//
// class _OTPVerificationPageState extends State<OTPVerificationPage> {
//   String otp = "";
//   bool isResendEnabled = false;
//   int timerSeconds = 30;
//   Timer? timer;
//
//   String accRole = "";
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserRole();
//     startTimer();
//   }
//
//   Future<void> fetchUserRole() async {
//     RoleController controller = RoleController();
//     UserRole roleResponse = await controller.getRole(widget.phoneNumber);
//     accRole = roleResponse.role ?? "";
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
//
//   void startTimer() {
//     timerSeconds = 30;
//     isResendEnabled = false;
//
//     timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       setState(() {
//         if (timerSeconds > 0) {
//           timerSeconds--;
//         } else {
//           isResendEnabled = true;
//           t.cancel();
//         }
//       });
//     });
//   }
//
//   /// ✅ VERIFY OTP
//   Future<void> verifyOTP() async {
//     if (otp.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Enter valid OTP")),
//       );
//       return;
//     }
//
//     try {
//       final response = await http.post(
//         Uri.parse(
//           ApiConstants.verifyOtpMsg91,
//         ),
//         body: {
//           "phone": widget.phoneNumber,
//           "otp": otp,
//         },
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (data['status'] == true) {
//         Get.off(() => RoleSelectionPage(accRole, widget.phoneNumber));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(data['message'])),
//         );
//       }
//     } catch (_) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Verification failed")),
//       );
//     }
//   }
//
//   /// 🔁 RESEND OTP (ONLY ON CLICK)
//   Future<void> resendOTP() async {
//     if (!isResendEnabled) return;
//
//     await http.post(
//       Uri.parse(
//         ApiConstants.sendOtpMsg91,
//       ),
//       body: {
//         "phone": widget.phoneNumber,
//       },
//     );
//
//     startTimer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 30),
//
//               const Text(
//                 "Verify OTP",
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//
//               const SizedBox(height: 10),
//
//               Text(
//                 "We have sent an OTP to ${widget.phoneNumber}",
//                 style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//               ),
//
//               const SizedBox(height: 40),
//
//               PinCodeTextField(
//                 appContext: context,
//                 length: 6,
//                 keyboardType: TextInputType.number,
//                 onChanged: (value) => otp = value,
//                 pinTheme: PinTheme(
//                   shape: PinCodeFieldShape.box,
//                   borderRadius: BorderRadius.circular(10),
//                   fieldHeight: 55,
//                   fieldWidth: 50,
//                   activeColor: Colors.blue,
//                   selectedColor: Colors.blue,
//                   inactiveColor: Colors.grey.shade300,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Center(
//                 child: isResendEnabled
//                     ? GestureDetector(
//                   onTap: resendOTP,
//                   child: const Text(
//                     "Resend OTP",
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue),
//                   ),
//                 )
//                     : Text(
//                   "Resend in 00:${timerSeconds.toString().padLeft(2, '0')}",
//                   style:
//                   TextStyle(fontSize: 16, color: Colors.grey.shade600),
//                 ),
//               ),
//
//               const Spacer(),
//
//               ElevatedButton(
//                 onPressed: verifyOTP,
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 55),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Verify & Continue",
//                   style: TextStyle(fontSize: 18),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
