import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../ui/widgets/locationWidget.dart';
import '../controller/vender_register_controller.dart';

class VendorRegistrationPage extends StatefulWidget {
  const VendorRegistrationPage({super.key});

  @override
  State<VendorRegistrationPage> createState() => _VendorRegistrationPageState();
}

class _VendorRegistrationPageState extends State<VendorRegistrationPage> {
  final VendorRegisterController controller = VendorRegisterController();
  final ImagePicker _picker = ImagePicker();

  File? _image;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );

      if (picked == null) {
        showSnack("No image selected");
        return;
      }

      setState(() {
        _image = File(picked.path);
      });
    } catch (e) {
      showSnack("Permission denied or error");
    }
  }

  void showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _onRegisterPressed() async {
    if (_image == null) {
      Get.snackbar("Image", "Please select an image");
      return;
    }

    // 🔥 BLOCKING LOADER (industry standard)
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    await controller.registerVendor(
      context: context,
      imgFile: _image!,
    );

    // ❌ Do NOT close loader manually
    // Navigation removes it automatically
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Vendor Registration"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7F9CF5),
              Color(0xFFB39DDB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [

                /// 🖼 IMAGE PICKER AVATAR
                Center(
                  child: GestureDetector(
                    onTap: _showImageSheet,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white.withOpacity(0.25),
                      backgroundImage:
                      _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(Icons.camera_alt,
                          size: 40, color: Colors.white)
                          : null,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// 📦 FORM CARD
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [

                      _styledField(
                        controller.nameController,
                        "Vendor Name",
                        Icons.person,
                      ),

                      _styledField(
                        controller.shopNameController,
                        "Shop Name",
                        Icons.store,
                      ),

                      _styledField(
                        controller.phoneController,
                        "Phone",
                        Icons.phone,
                        keyboard: TextInputType.phone,
                        maxLength: 10,
                      ),

                      const SizedBox(height: 8),

                      /// 📍 YOUR EXISTING LOCATION WIDGET
                      LocationWidget(
                        locationController:
                        controller.locationController,
                        pincodeController:
                        controller.pincodeController,
                        nearcolor: Colors.white,
                      ),

                      const SizedBox(height: 12),

                      _styledField(
                        controller.pincodeController,
                        "Pincode",
                        Icons.pin_drop,
                        keyboard: TextInputType.number,
                        maxLength: 6,
                      ),

                      const SizedBox(height: 20),

                      /// 🚀 REGISTER BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _onRegisterPressed,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            "Register Vendor",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _styledField(
      TextEditingController controller,
      String label,
      IconData icon, {
        TextInputType keyboard = TextInputType.text,
        int? maxLength,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.white),
        validator: (v) => v!.isEmpty ? "Enter $label" : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
  void _showImageSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("Gallery"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text("Camera"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

}
