import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';

import '../ui/login/roleBasedLogin/RoleSelectionPage.dart';

class VerifyMsg91UI extends StatefulWidget {
  final String phoneNumber;
  String reqId;
   VerifyMsg91UI({super.key, required this.phoneNumber, required this.reqId});

  @override
  State<VerifyMsg91UI> createState() => _VerifyMsg91UIState();
}

class _VerifyMsg91UIState extends State<VerifyMsg91UI> {
  String otp = "";
  bool isResendEnabled = false;
  int timerSeconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timerSeconds = 30;
    isResendEnabled = false;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (timerSeconds > 0) {
          timerSeconds--;
        } else {
          isResendEnabled = true;
          t.cancel();
        }
      });
    });
  }

  Future<void> verifyOtp() async {
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid OTP")),
      );
      return;
    }
    // if(otp.length == 6){
    //   Get.off(() => RoleSelectionPage(widget.phoneNumber));
    // }
    final response = await OTPWidget.verifyOTP({
      "reqId": widget.reqId, // 🔥 REQUIRED
      "otp": otp,
    });

    debugPrint("OTP VERIFY RESPONSE → $response");

    if (response?['type'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verified")),
      );
      String accRole = "";    //temp define no need
      // ✅ Redirect after verification
      Get.off(() => RoleSelectionPage( widget.phoneNumber));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response?['message'] ?? "Invalid OTP")),
      );
    }
  }

  Future<void> resendOtp() async {
    if (!isResendEnabled) return;

    final response = await OTPWidget.sendOTP({
      "identifier": "91${widget.phoneNumber}",
    });

    // 🔥 UPDATE reqId
    widget.reqId = response?['reqId'];

    startTimer();
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
              const SizedBox(height: 30),

              const Text(
                "Verify OTP",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                "We have sent an OTP to ${widget.phoneNumber}",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 40),

              PinCodeTextField(
                appContext: context,
                length: 6,
                keyboardType: TextInputType.number,
                onChanged: (value) => otp = value,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 55,
                  fieldWidth: 50,
                  activeColor: Colors.blue,
                  selectedColor: Colors.blue,
                  inactiveColor: Colors.grey.shade300,
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: isResendEnabled
                    ? GestureDetector(
                  onTap: resendOtp,
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                )
                    : Text(
                  "Resend in 00:${timerSeconds.toString().padLeft(2, '0')}",
                  style:
                  TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: verifyOtp,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Verify & Continue",
                  style: TextStyle(fontSize: 18),
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
