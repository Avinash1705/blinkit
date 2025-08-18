import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/locationWidget.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Profile")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Customer Name"),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter customer name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? "Enter a name" : null,
                ),
                const SizedBox(height: 16),

                LocationWidget(
                  locationController: _locationController,
                ),
                const SizedBox(height: 16),
                // Displaying the current location
                Text("Phone Number ${_locationController.text}"),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Enter phone number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.length < 10 ? "Enter valid phone" : null,
                ),
                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // ✅ Handle save / API call here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Profile Saved")),
                        );
                      }
                    },
                    child: const Text("Register Profile"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
