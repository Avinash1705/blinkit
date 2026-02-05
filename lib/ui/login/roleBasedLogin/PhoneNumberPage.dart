// import 'dart:convert';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../controllers/getUserRoleController.dart';
// import '../../../dependency/dependency.dart';
// import '../../../domain/AppConstant.dart';
// import '../../../model/userRole.dart';
// import 'verifyOtpMsg91.dart';
// import 'RoleSelectionPage.dart';
//
// class PhoneNumberPage extends StatefulWidget {
//   const PhoneNumberPage({super.key});
//
//   @override
//   State<PhoneNumberPage> createState() => _PhoneNumberPageState();
// }
//
// class _PhoneNumberPageState extends State<PhoneNumberPage> {
//   final TextEditingController phoneController = TextEditingController();
//   late RoleController roleController ;
//   bool loading = false;
//
//   void sendOtp() async {
//     String phone = phoneController.text.trim();
//     isUserLoggedIn();
//     if (phone.length != 10) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Enter a valid 10-digit phone number")),
//       );
//       return;
//     }
//
//     setState(() => loading = true);
//
//     // 👇 Wait for API response
//     UserRole roleResponse = await roleController.getRole(phone);
//
//     setState(() => loading = false);
//     bool loggedIn = await isUserLoggedIn();
//     if (roleResponse.status == true && loggedIn) {
//       // 👉 User exists -> go to role selection
//       Get.to(() => RoleSelectionPage(roleResponse.role ?? "", phone));
//     } else {
//       // 👉 New user -> send OTP
//       sendOTP(phoneController.text.trim());
//       // Get.to(() => OTPVerificationPage(phoneNumber: phone));
//     }
//   }
//   String verificationId = "";
//
//   Future<void> sendOTP(String phone) async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: "+91$phone",
//       timeout: const Duration(seconds: 60),
//
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         print("fffffff ✅ Auto OTP verified");
//       },
//
//       verificationFailed: (FirebaseAuthException e) {
//         print("$phone");
//         print("fffffff ❌ OTP Failed: ${e.message}");
//       },
//
//       codeSent: (String verId, int? resendToken) {
//         verificationId = verId;
//         print("fffffff 📩 OTP Sent");
//       },
//
//       codeAutoRetrievalTimeout: (String verId) {
//         verificationId = verId;
//       },
//     );
//   }
//
//   Future<bool> isUserLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     print("test keys ${prefs.containsKey("customer_id")}");
//     print("test keys ${jsonEncode( prefs.getString(AppConstant.vendorDetails))}");
//     loadUserData(prefs); // Your existing function
//     return prefs.containsKey('customer_id')|| prefs.containsKey(AppConstant.vendorDetails);
//   }
//
//   @override
//   void initState() {
//     roleController = RoleController();
//     super.initState();
//   }
//   void getFilteredRole(){
//     roleController.getRole(phoneController.text).then((value) {
//     if(  value.status){
//       Get.to(RoleSelectionPage("",phoneController.text));
//     }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               const SizedBox(height: 40),
//
//               const Text(
//                 "Enter Your Number",
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//
//               const SizedBox(height: 10),
//
//               Text(
//                 "We'll send you a verification code.",
//                 style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
//               ),
//
//               const SizedBox(height: 40),
//
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   children: [
//                     const Text(
//                       "+91",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: TextField(
//                         controller: phoneController,
//                         keyboardType: TextInputType.phone,
//                         maxLength: 10,
//                         decoration: const InputDecoration(
//                           counterText: "",
//                           hintText: "Phone number",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const Spacer(),
//
//               ElevatedButton(
//                 onPressed: loading ? null : sendOtp,
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(double.infinity, 55),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: loading
//                     ? const SizedBox(
//                   height: 25,
//                   width: 25,
//                   child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
//                 )
//                     : const Text(
//                   "Send OTP",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
