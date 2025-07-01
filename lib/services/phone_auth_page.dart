// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class PhoneAuthPage extends StatefulWidget {
//   const PhoneAuthPage({super.key});
//
//   @override
//   State<PhoneAuthPage> createState() => _PhoneAuthPageState();
// }
//
// class _PhoneAuthPageState extends State<PhoneAuthPage> {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//
//   String verificationId = "";
//   bool otpSent = false;
//   bool loading = false;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   void sendOTP() async {
//     setState(() => loading = true);
//
//     await _auth.verifyPhoneNumber(
//       phoneNumber: '+91${phoneController.text}',
//       timeout: const Duration(seconds: 60),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // Auto verification on some devices
//         await _auth.signInWithCredential(credential);
//         setState(() => loading = false);
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("Phone number automatically verified"),
//         ));
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         setState(() => loading = false);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Verification failed: ${e.message}"),
//         ));
//       },
//       codeSent: (String verId, int? resendToken) {
//         setState(() {
//           otpSent = true;
//           verificationId = verId;
//           loading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text("OTP sent to your number"),
//         ));
//       },
//       codeAutoRetrievalTimeout: (String verId) {
//         verificationId = verId;
//       },
//     );
//   }
//
//   void verifyOTP() async {
//     setState(() => loading = true);
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: otpController.text,
//       );
//
//       await _auth.signInWithCredential(credential);
//       setState(() => loading = false);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Phone number verified successfully"),
//       ));
//       // Navigate to Home or Dashboard
//     } catch (e) {
//       setState(() => loading = false);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Invalid OTP"),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Phone Authentication")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             if (!otpSent)
//               TextField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   labelText: "Phone Number",
//                   prefixText: "+91 ",
//                 ),
//               ),
//             if (otpSent)
//               TextField(
//                 controller: otpController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: "Enter OTP"),
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: loading
//                   ? null
//                   : otpSent
//                   ? verifyOTP
//                   : sendOTP,
//               child: Text(otpSent ? "Verify OTP" : "Send OTP"),
//             ),
//             if (loading) const CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }
