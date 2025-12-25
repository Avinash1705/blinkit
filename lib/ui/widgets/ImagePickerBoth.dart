import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../vender/ui/categoryDropdown.dart';
import '../../vender/controller/addItemsController.dart';
import '../../vender/venderModels/GetVenderResponseModel.dart' as venderData;

class ImagepickerBoth extends StatefulWidget {
  final venderData.Data vendorDetail;

  const ImagepickerBoth(this.vendorDetail, {super.key});

  @override
  State<ImagepickerBoth> createState() => _ImagepickerBothState();
}

class _ImagepickerBothState extends State<ImagepickerBoth> {
  final ImagePicker _picker = ImagePicker();

  File? _image;
  bool isSubmitting = false;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String? selectedCategory;
  String selectedUnit = 'kg';

  final List<String> units = ['kg', 'g', 'liter', 'ml'];

  void handleSelection(String value) {
    selectedCategory = value;
  }

  // ---------------- PERMISSIONS ----------------
  Future<bool> _requestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      return await Permission.camera.request().isGranted;
    } else {
      return await Permission.photos.request().isGranted ||
          await Permission.storage.request().isGranted;
    }
  }

  // ---------------- IMAGE PICK ----------------
  Future<void> _pickImage(ImageSource source) async {
    final granted = await _requestPermission(source);
    if (!granted) {
      Get.snackbar("Permission", "Permission denied");
      return;
    }

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // ---------------- SUBMIT ----------------
  Future<void> _submitProduct() async {
    if (_image == null ||
        selectedCategory == null ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all required fields");
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final response = await AddItemsController.addItem(
        widget.vendorDetail.venderId.toString(),
        nameController.text.trim(),
        widget.vendorDetail.phone.toString(),
        descController.text.trim(),
        int.parse(priceController.text),
        0,
        weightController.text.trim(),
        selectedUnit,
        int.parse(quantityController.text),
        _image!,
      );

      final result = jsonDecode(response);
      Get.snackbar("Success", result['status'].toString());

      // Optional: Navigator.pop(context);
    } catch (e) {
      Get.snackbar("Error", "Failed to add product");
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    weightController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              CategoryDropdown(onSelected: handleSelection),

              TextField(
                controller: priceController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: const InputDecoration(labelText: 'Price'),
              ),

              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),

              TextField(
                controller: weightController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Weight',
                  suffixIcon: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedUnit,
                      items: units
                          .map(
                            (u) => DropdownMenuItem(
                          value: u,
                          child: Text(u),
                        ),
                      )
                          .toList(),
                      onChanged: (val) {
                        setState(() => selectedUnit = val!);
                      },
                    ),
                  ),
                ),
              ),

              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),

              const SizedBox(height: 20),

              _image == null
                  ? const Text("No image selected")
                  : Image.file(_image!, height: 200),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: const Text("Pick from Gallery"),
              ),

              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: const Text("Take Photo"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: isSubmitting ? null : _submitProduct,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),

        // ---------------- LOADER ----------------
        if (isSubmitting)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
