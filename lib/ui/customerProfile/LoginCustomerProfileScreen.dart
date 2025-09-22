

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/loginCustomerController.dart';
import '../../dependency/dependency.dart';
import 'RegistrationCustomerProfileScreen.dart';

class LoginCustomerProfileScreen extends StatefulWidget {
  const LoginCustomerProfileScreen({super.key});

  @override
  State<LoginCustomerProfileScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<LoginCustomerProfileScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon / Logo
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.phone_android,
                      size: 60,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Login with Phone",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Enter your phone number to continue",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 30),

                  // Phone Number Input
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone, color: Colors.white),
                      hintText: "Enter phone number",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Show OTP field only if sent
                  if (otpSent)
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.white),
                        hintText: "Enter OTP",
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  if (otpSent) const SizedBox(height: 20),

                  // Buttons
                  ElevatedButton(
                    onPressed: () {
                      if (!otpSent) {
                        setState(() {
                          otpSent = true; // Simulate OTP sent
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("OTP Sent ✅")),
                        );
                      } else {
                        // Verify OTP logic
                        if (_otpController.text == "12345") {
                          LoginCustomerController.loginRegisteredCustomer(_phoneController.text.toString(),context);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text("Login Successful 🎉")),
                          // );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Invalid OTP ❌")),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      otpSent ? "Verify OTP" : "Send OTP",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle register tap
                          Get.off(RegistrationCustomerProfilePage());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.orangeAccent, Colors.yellow],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(2, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                  ElevatedButton(onPressed: (){
                    showNotification();
                    print("worked" )  ;
                  }, child: Text("Test Notification"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

