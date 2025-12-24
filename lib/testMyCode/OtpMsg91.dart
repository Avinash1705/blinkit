// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:swiggy/domain/ApiConstants.dart';
// import '../../../controllers/getUserRoleController.dart';
// import '../../../domain/AppConstant.dart';
// import '../../../model/userRole.dart';
// import '../ui/login/roleBasedLogin/RoleSelectionPage.dart';
// import '../ui/login/roleBasedLogin/verifyOtpMsg91.dart';
//
//
// class OtpMsg91 extends StatefulWidget {
//   const OtpMsg91({super.key});
//
//   @override
//   State<OtpMsg91> createState() => _OtpMsg91State();
// }
//
// class _OtpMsg91State extends State<OtpMsg91> {
//   final TextEditingController phoneController = TextEditingController();
//   late RoleController roleController;
//   bool loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     roleController = RoleController();
//   }
//
//   /// 🔑 MAIN ENTRY
//   Future<void> sendOtp() async {
//     final phone = phoneController.text.trim();
//
//     if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
//       _showMsg("Enter valid 10-digit phone number");
//       return;
//     }
//
//     setState(() => loading = true);
//
//     try {
//       /// 1️⃣ Check role from backend
//       UserRole roleResponse = await roleController.getRole(phone);
//
//       /// 2️⃣ Check local login
//       bool loggedIn = await isUserLoggedIn();
//
//       /// ✅ CASE: Existing user + already logged in
//       if (roleResponse.status == true && loggedIn) {
//         setState(() => loading = false);
//
//         Get.off(() => RoleSelectionPage(
//           roleResponse.role ?? "",
//           phone,
//         ));
//         return;
//       }
//
//       /// ✅ CASE: New / logged-out user → send OTP
//       await sendOtpFromBackend(phone);
//
//       setState(() => loading = false);
//
//       Get.to(() => OTPVerificationPage(phoneNumber: phone));
//     } catch (_) {
//       setState(() => loading = false);
//       _showMsg("Something went wrong");
//     }
//   }
//
//   /// 🔐 SEND OTP (BACKEND ONLY)
//   Future<void> sendOtpFromBackend(String phone) async {
//     final response = await http.post(
//       Uri.parse(ApiConstants.sendOtpMsg91),
//       body: {"phone": phone},
//     );
//     print("check resonse ${jsonEncode(response.body)}");
//     if (response.body.isEmpty) {
//       throw Exception("Empty server response");
//     }
//
//     final data = jsonDecode(response.body);
//     print("kkkk ${data}");
//     if (data['status'] != true) {
//       throw Exception(data['message'] ?? "OTP failed");
//     }
//   }
//
//   /// 🔐 CHECK LOCAL LOGIN
//   Future<bool> isUserLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.containsKey('customer_id') ||
//         prefs.containsKey(AppConstant.vendorDetails);
//   }
//
//   void _showMsg(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg)),
//     );
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
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   children: [
//                     const Text(
//                       "+91",
//                       style:
//                       TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     color: Colors.white,
//                   ),
//                 )
//                     : const Text(
//                   "Send OTP",
//                   style: TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
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
