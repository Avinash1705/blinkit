import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiggy/domain/AppConstant.dart';
import 'package:swiggy/ui/login/loginScreen.dart';

import '../widgets/uihelper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // remove all saved user data

    // Redirect to Login screen
    if (mounted) {
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
      body: AppConstant.customer_name == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurple,
                    backgroundImage: AppConstant.customer_profile == null
                        ? Icon(Icons.person, size: 60, color: Colors.white)
                        : UiHelper.CustomImageNetworkCustomerProfile(
                            img: AppConstant.customer_profile),
                    // child: Icon(Icons.person, size: 60, color: Colors.white),
                  //   child: UiHelper.CustomImageNetworkCustomerProfile(
                  //       img: customer_profile),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.badge, color: Colors.blueAccent),
                              const SizedBox(width: 8),
                              Text("ID: ${AppConstant.customer_id}",
                                  style: const TextStyle(fontSize: 16, color: Colors.black87)),
                            ],
                          ),
                          const Divider(height: 20, thickness: 1),

                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.green),
                              const SizedBox(width: 8),
                              Text("Name: ${AppConstant.customer_name}",
                                  style: const TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.orange),
                              const SizedBox(width: 8),
                              Text("Phone: ${AppConstant.phone}",
                                  style: const TextStyle(fontSize: 16, color: Colors.black87)),
                            ],
                          ),
                          const SizedBox(height: 15),

                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.redAccent),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text("Location: ${AppConstant.location}",
                                    style: const TextStyle(fontSize: 16, color: Colors.black87)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
