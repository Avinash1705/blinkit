import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/ui/login/loginScreen.dart';

import '../widgets/uihelper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? customerId;
  String? customerName;
  String? phone;
  String? location;
  String? customer_profile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      customerId = prefs.getString('customer_id');
      customerName = prefs.getString('customer_name');
      phone = prefs.getString('phone');
      location = prefs.getString('location');
      customer_profile = prefs.getString('customer_profile');
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // remove all saved user data

    // Redirect to Login screen
    if (mounted) {
      // Navigator.pushReplacementNamed(context, '/login');
      Get.off(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: customerId == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple,
                    backgroundImage: customer_profile == null
                        ? Icon(Icons.person, size: 60, color: Colors.white)
                        : UiHelper.CustomImageNetworkCustomerProfile(
                            img: customer_profile!),
                    // child: Icon(Icons.person, size: 60, color: Colors.white),
                  //   child: UiHelper.CustomImageNetworkCustomerProfile(
                  //       img: customer_profile),
                  ),
                  const SizedBox(height: 20),
                  Text("ID: $customerId", style: const TextStyle(fontSize: 16)),
                  Text("Name: $customerName",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Phone: $phone", style: const TextStyle(fontSize: 16)),
                  Text("Location: $location",
                      style: const TextStyle(fontSize: 16)),
                  const Spacer(),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _logout,
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
