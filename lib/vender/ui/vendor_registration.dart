import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../controller/vender_register_controller.dart';

class VendorRegistrationPage extends StatefulWidget {
  const VendorRegistrationPage({super.key});

  @override
  State<VendorRegistrationPage> createState() =>
      _VendorRegistrationPageState();
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
    ScaffoldMessenger.of(context ).showSnackBar(
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
      appBar: AppBar(title: const Text('Vendor Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: const Text('Pick from Gallery'),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: const Text('Take Photo'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _image == null
                  ? const Text('No image selected')
                  : Column(
                children: [
                  Image.file(_image!, height: 200),
                  const SizedBox(height: 6),
                  Text(
                    _image!.path.split('/').last,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: controller.nameController,
                decoration:
                const InputDecoration(labelText: 'Vendor Name'),
                validator: (v) =>
                v!.isEmpty ? 'Enter Vendor Name' : null,
              ),

              TextFormField(
                controller: controller.shopNameController,
                decoration:
                const InputDecoration(labelText: 'Shop Name'),
                validator: (v) =>
                v!.isEmpty ? 'Enter Shop Name' : null,
              ),

              TextFormField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration:
                const InputDecoration(labelText: 'Phone'),
                validator: (v) =>
                v!.length != 10 ? 'Enter 10-digit phone' : null,
              ),

              TextFormField(
                controller: controller.locationController,
                decoration:
                const InputDecoration(labelText: 'Location'),
                validator: (v) =>
                v!.isEmpty ? 'Enter Location' : null,
              ),

              TextFormField(
                controller: controller.pincodeController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration:
                const InputDecoration(labelText: 'PinCode'),
                validator: (v) =>
                v!.isEmpty ? 'Enter PinCode' : null,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _onRegisterPressed,
                child: const Text('Register Vendor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
