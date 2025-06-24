
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swiggy/admin/ui/admin_dashboard.dart';
import 'package:swiggy/vender/ui/vender_dashboard.dart';

class StaticLoginScreen extends StatefulWidget {
  const StaticLoginScreen({super.key});

  @override
  State<StaticLoginScreen> createState() => _StaticLoginScreenState();
}

class _StaticLoginScreenState extends State<StaticLoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool otpSent = false;

  void simulateSendOtp() {
    setState(() {
      otpSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("OTP sent (simulated)")),
    );
  }

  void simulateLogin() {
    if (otpController.text == "123456") {
      checkLoginAccess();

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text(" Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                prefixText: "+91 ",
              ),
            ),
            const SizedBox(height: 20),
            if (otpSent)
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter OTP",
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: otpSent ? simulateLogin : simulateSendOtp,
              child: Text(otpSent ? "Verify OTP" : "Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
  void checkLoginAccess(){
    if(phoneController.value.text == "9999999999"){
      Get.to(AdminDashboard());
    }
    else {
      Get.to(VendorDashboard());
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Login successful")),
    );
  }
}
