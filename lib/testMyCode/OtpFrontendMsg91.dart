import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/ui/login/roleBasedLogin/RoleSelectionPage.dart';
import '../dependency/dependency.dart';
import '../domain/AppConstant.dart';
import 'VerifyMsg91UI.dart';


class PhoneMsg91UI extends StatefulWidget {
  const PhoneMsg91UI({super.key});

  @override
  State<PhoneMsg91UI> createState() => _PhoneMsg91UIState();
}

class _PhoneMsg91UIState extends State<PhoneMsg91UI> {
  final TextEditingController phoneController = TextEditingController();
  bool loading = false;

  // ❌ Frontend keys (NOT SAFE – demo/testing only)
  final String widgetId = "356c6f684232393832373134";
  final String authToken = "483075AcTbs2eIf694a882cP1";
  String? reqId;

  @override
  void initState() {
    super.initState();
    OTPWidget.initializeWidget(widgetId, authToken);
  }

  Future<void> sendOtp() async {
    final phone = phoneController.text.trim();

    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid 10-digit phone number")),
      );
      return;
    }

    setState(() => loading = true);

    try {
      // final response = await OTPWidget.sendOTP({
      //   "identifier": "91$phone",
      // });

      // debugPrint("OTP SEND RESPONSE → $response");

      setState(() => loading = false);
      //check from loginuser phone if it exit
      final isLoggedIn = await isUserLoggedInWithPhone(phone);

      // 🔹 If same phone → skip OTP
      if (isLoggedIn) {
        Get.offAll(() => RoleSelectionPage(phone));
        return;
      }
      else {
        // ✅ IMPORTANT
        // reqId = response?['message'];
        reqId = "response?['message']";
        // ✅ Redirect to verification screen
        Get.to(() => VerifyMsg91UI(phoneNumber: phone, reqId: reqId!,));
      }
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP sending failed")),
      );
    }
  }
  Future<bool> isUserLoggedInWithPhone(String inputPhone) async {
    final prefs = await SharedPreferences.getInstance();

    // 🔹 Customer phone
    final String? customerPhone = prefs.getString('phone');

    // 🔹 Vendor phone (stored as JSON)
    String? vendorPhone;
    final vendorJson = prefs.getString(AppConstant.vendorDetails);

    if (vendorJson != null && vendorJson.isNotEmpty) {
      final Map<String, dynamic> vendorMap = jsonDecode(vendorJson);
      vendorPhone = vendorMap['phone'];
    }

    return inputPhone == customerPhone || inputPhone == vendorPhone;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              const Text(
                "Enter Your Number",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                "We'll send you a verification code.",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 40),

              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Text(
                      "+91",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          counterText: "",
                          hintText: "Phone number",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: loading ? null : sendOtp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: loading
                    ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  "Send OTP",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
