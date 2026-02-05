//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'package:get/get.dart';
// import 'package:swiggy/admin/ui/admin_dashboard.dart';
// import 'package:swiggy/vender/controller/AllVenderController.dart';
// import 'package:swiggy/vender/ui/vender_dashboard.dart';
// import 'package:swiggy/vender/venderModels/GetVenderResponseModel.dart';
//
// import '../../2factorOpt/OtpService.dart';
// import '../../services/notify.dart';
// import '../../vender/ui/vendor_registration.dart';
//
// class StaticLoginScreen extends StatefulWidget {
//   const StaticLoginScreen({super.key});
//
//   @override
//   State<StaticLoginScreen> createState() => _StaticLoginScreenState();
// }
//
// class _StaticLoginScreenState extends State<StaticLoginScreen> {
//
//   late GetVenderResponseModel getVenderResponseModel ;
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//
//   final OtpService otpService = OtpService();
//   String? sessionId;
//   bool otpSent = false;
//   bool isLoading = false;
//
//   // void sendOtp() async {
//   //   setState(() => isLoading = true);
//   //
//   //   final res = await otpService.sendOtp(phoneController.text.trim());
//   //
//   //   setState(() => isLoading = false);
//   //
//   //   if (res["Status"] == "Success") {
//   //     setState(() {
//   //       otpSent = true;
//   //       sessionId = res["Details"]; // store sessionId
//   //     });
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text("OTP sent successfully!")),
//   //     );
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text("Error: ${res["Details"]}")),
//   //     );
//   //   }
//   // }
//   void sendOtp() async {
//     final phone = phoneController.text.trim();
//
//     if (phone.length != 10) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Enter valid 10-digit phone number")),
//       );
//       return;
//     }
//
//     setState(() => isLoading = true);
//
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+91$phone',
//
//       verificationCompleted: (PhoneAuthCredential credential) {
//         // Auto verification on Android
//
//       },
//
//       verificationFailed: (FirebaseAuthException e) {
//         setState(() => isLoading = false);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: ${e.message}")),
//         );
//       },
//
//       codeSent: (String verificationId, int? resendToken) {
//         // OTP SENT SUCCESSFULLY
//         setState(() {
//           isLoading = false;
//           otpSent = true;
//           sessionId = verificationId; // store Firebase verification ID
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("OTP sent successfully!")),
//         );
//       },
//
//       codeAutoRetrievalTimeout: (String verificationId) {
//         // Timeout after 60 seconds
//         sessionId = verificationId;
//       },
//     );
//   }
//
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
//       checkLoginAccess();
//       // Navigate to home screen
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Verification failed: ${res["Details"]}")),
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     AllVenderController().fetchVendors().then((value) => {
//       getVenderResponseModel = value,
//       print("Vendors fetched: ${getVenderResponseModel.data?.length}"),
//       setState(() {
//         // This will trigger a rebuild with the fetched data
//       })
//     });
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     print("loginScreenStaic");
//     return Scaffold(
//       backgroundColor: Colors.yellow.shade50,
//       appBar: AppBar(title: const Text(" Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextField(
//                     controller: phoneController,
//                     maxLength: 10,
//                     keyboardType: TextInputType.phone,
//                     decoration: const InputDecoration(
//                       labelText: "Phone Number",
//                       hintText: "Enter phone number ",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   if (otpSent) ...[
//                     TextField(
//                       controller: otpController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         labelText: "Enter OTP",
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//
//                   ElevatedButton(
//                     onPressed: isLoading
//                         ? null
//                         : otpSent
//                         ? verifyOtp
//                         : sendOtp,
//                     child: isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : Text(otpSent ? "Verify OTP" : "Send OTP"),
//                   ),
//                   // ElevatedButton(onPressed: (){
//                   //
//                   // }, child: Text("Login as Guest ${getVenderResponseModel.data!.length}")),
//                 ],
//               ),
//             ),
//             SizedBox(height: 100),
//             ElevatedButton(onPressed: (){
//               Get.to(VendorRegistrationPage());
//             }, child: Text("Register")),
//           ],
//         ),
//       ),
//     );
//   }
//   void checkLoginAccess(){
//     if(phoneController.value.text == "9999999999"){
//       Get.to(AdminDashboard());
//     }
//     else {
//       for(int i=0;i<getVenderResponseModel.data!.length;i++){
//         print("no are ${getVenderResponseModel.data?[i].phone}");
//         if(getVenderResponseModel.data?[i].phone == phoneController.value.text){
//           Get.to(VendorDashboard(
//             vendorDetails: getVenderResponseModel.data![i],
//           ));
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Login successful")),
//           );
//           return;
//         }
//       }
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Phone Not Registered")),
//     );
//   }
// }
//
//
