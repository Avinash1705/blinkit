import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'LoginCustomerProfileScreen.dart';
import 'RegistrationCustomerProfileScreen.dart';

class CustomerLoginRegistrationScreen extends StatelessWidget {
  const CustomerLoginRegistrationScreen({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🎨 App Icon
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),

              // 📝 Title
              const Text(
                "Welcome, Customer 👋",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Login or create a new account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),

              // 🔑 Login Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to login screen
                  Get.to(LoginCustomerProfileScreen());
                },
                icon: const Icon(Icons.login, color: Colors.white),
                label: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🆕 Register Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to registration screen
                  Get.to(RegistrationCustomerProfilePage());
                },
                icon: const Icon(Icons.app_registration, color: Colors.white),
                label: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
