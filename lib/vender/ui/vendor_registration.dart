import 'package:flutter/material.dart';
import '../controller/vender_register_controller.dart';


class VendorRegistrationPage extends StatefulWidget {
  @override
  _VendorRegistrationPageState createState() => _VendorRegistrationPageState();
}

class _VendorRegistrationPageState extends State<VendorRegistrationPage> {
  final controller = VendorRegisterController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              TextFormField(
                controller: controller.vendorIdController,
                decoration: InputDecoration(labelText: 'Vendor ID'),
                validator: (v) => v!.isEmpty ? 'Enter Vendor ID' : null,
              ),
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
                onPressed: () => controller.registerVendor(context),
                child: Text('Register Vendor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
