import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controller/vender_register_controller.dart';


class VendorRegistrationPage extends StatefulWidget {
  @override
  _VendorRegistrationPageState createState() => _VendorRegistrationPageState();
}

class _VendorRegistrationPageState extends State<VendorRegistrationPage> {
  final controller = VendorRegisterController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _requestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      return status.isGranted;
    }

    // For gallery → NO permission required
    return true;
  }

  //permission handling is not needed here as we are not using camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    bool granted = await _requestPermission(source);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
      return;
    }

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendor Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 ElevatedButton(
                   onPressed: () => {
                     _pickImage(ImageSource.gallery),
                   },
                   child: Text('Pick from Gallery'),
                 ),
                 ElevatedButton(
                   onPressed: () => _pickImage(ImageSource.camera),
                   child: Text('Take a Photo'),
                 ),
               ],
             ),
              _image == null
                  ? Text('No image selected')
              // : Image.file(_image!, height: 200),
                  : Column(
                children: [
                  Image.file(
                    _image!,
                    height: 200,
                  ),
                  SizedBox(height: 10),

                  Text('Image Path: ${_image!.path.split('/').last}'),
                  // Text('Image Path:absoluit  ${_image!.absolute.path}'),
                ],
              ),
              SizedBox(height: 20),
              // TextFormField(
              //   controller: controller.vendorIdController,
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.digitsOnly,
              //   ],
              //   decoration: InputDecoration(labelText: 'Vendor ID'),
              //   validator: (v) => v!.isEmpty ? 'Enter Vendor ID' : null,
              // ),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'Vendor Name'),
                validator: (v) => v!.isEmpty ? 'Enter Vendor Name' : null,
              ),
              TextFormField(
                controller: controller.shopNameController,
                decoration: InputDecoration(labelText: 'Shop Name'),
                validator: (v) => v!.isEmpty ? 'Enter Shop Name' : null,
              ),
              TextFormField(
                controller: controller.phoneController,
                maxLength: 10,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.length != 10 ? 'Enter 10-digit phone' : null,
              ),
              TextFormField(
                controller: controller.locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (v) => v!.isEmpty ? 'Enter Location' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => {
                  // print("Registering Vendor$_image"),
                 controller.registerVendor(context,_image!)
                },
                child: Text('Register Vendor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
